%Copyright © 2018 Naturalpoint
%
%Licensed under the Apache License, Version 2.0 (the "License");
%you may not use this file except in compliance with the License.
%You may obtain a copy of the License at
%
%http://www.apache.org/licenses/LICENSE-2.0
%
%Unless required by applicable law or agreed to in writing, software
%distributed under the License is distributed on an "AS IS" BASIS,
%WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
%See the License for the specific language governing permissions and
%limitations under the License.
% Optitrack Matlab / NatNet Polling Sample
%  Requirements:
%   - OptiTrack Motive 2.0 or later
%   - OptiTrack NatNet 3.0 or later
%   - Matlab R2013
% This sample connects to the server and displays rigid body data.
% natnet.p, needs to be located on the Matlab Path.
function NatNetPollingSample
	fprintf( 'NatNet Polling Sample Start\n' )
	% create an instance of the natnet client class
	fprintf( 'Creating natnet class object\n' )
	natnetclient = natnet;
	% connect the client to the server (multicast over local loopback) -
	% modify for your network
	fprintf( 'Connecting to the server\n' )
	natnetclient.HostIP = '192.168.0.80';
	natnetclient.ClientIP = '192.168.0.80';
	natnetclient.ConnectionType = 'Multicast';
	natnetclient.connect;
	if ( natnetclient.IsConnected == 0 )
		fprintf( 'Client failed to connect\n' )
		fprintf( '\tMake sure the host is connected to the network\n' )
		fprintf( '\tand that the host and client IP addresses are correct\n\n' ) 
		return
	end
	% get the asset descriptions for the asset names
	model = natnetclient.getModelDescription;
 
	if ( model.RigidBodyCount < 1 )
		return
	end
	% Poll for the rigid body data a regular intervals (~1 sec) for 10 sec.
	fprintf( '\nPrinting rigid body frame data approximately every second for 10 seconds...\n\n' )
	all_pos=[];
%     time(ms)
%          Nhz를 만들고 싶다면 time은 1000/N 으로 설정하면 됨.
%         1000ms : 1hz  time1000으로 설정하면 1hz. 정확하게는 time 996으로 설정해야함
%           33ms : 30hz  1초에 30개 찍혀야하니까 1000/30
%     count
%         time으로 설정한 초 간격으로 몇개를 출력할것인지
% 150장 이미지 출력하려면 150/30=5초 인데 나는 keyframe selection 있잖아 그 파트 고민해봐야지.....빠르게
% 움직일게 아니라면 
% N개의 이미지 출력하려면 N/설정한 hz
% 근데 그냥 이번 실험에서는 time = 996으로 세팅해놓고 count 150으로 해놓고 keyframe selection 30개 마다 하는게 clear 하긴하지. 2분 30초
% 아니면 반 줄이던가 
    
    time = 996
    count = 10;
    for idx = 1 : count
		java.lang.Thread.sleep(time); %996  1000ms    30hz 
		data = natnetclient.getFrame; % method to get current frame
		
		if (isempty(data.RigidBody(1)))
			fprintf( '\tPacket is empty/stale\n' )
			fprintf( '\tMake sure the server is in Live mode or playing in playback\n\n')
			return
		end
		fprintf( 'Frame:%6d  ' , data.Frame )
		fprintf( 'Time:%0.2f\n' , data.Timestamp )
        pos = [];
		for i = 1:model.RigidBodyCount
			fprintf( 'Name:"%s"  ', model.RigidBody( i ).Name )
            x = data.RigidBody( i ).x * 1000;
            y = data.RigidBody( i ).y * 1000;
            z = data.RigidBody( i ).z * 1000;
            qx = data.RigidBody( i ).qx * 1000;
            qy = data.RigidBody( i ).qy * 1000;
            qz = data.RigidBody( i ).qz * 1000;
            qw = data.RigidBody( i ).qw * 1000;
            
			fprintf( 'X:%0.1fmm  ', x )
			fprintf( 'Y:%0.1fmm  ', y )
			fprintf( 'Z:%0.1fmm\n', z )
            r=[];
            t = datetime("now","TimeZone","Asia/Seoul");
            t = posixtime(t)
            quat = [qw qx qy qz];
            rotm = q2r(quat);
            rotx = rotm(1,:);
            roty = rotm(2,:);
            rotz = rotm(3,:);
            r = [rotx x roty y rotz z];
            r = cast(r,"double");
            
            
            m = [t r];
            pos = horzcat(pos, m)
            f = fopen("position_z.txt","a");
            textfile = fprintf(f, "%.3f %.6f %.6f %.6f %.6f %.6f %.6f %.6f %.6f %.6f %.6f %.6f %.6f\n",pos)
            fclose(f);
        end
        all_pos = vertcat(all_pos, pos);
    end
%   fname = 'postion_xyz' + '' + '.txt'
    %csvwrite('postion_xyz.txt',all_pos)
    %writematrix(all_pos, "position_xyz_test2","delimiter"," ")
	disp('NatNet Polling Sample End' )
end
