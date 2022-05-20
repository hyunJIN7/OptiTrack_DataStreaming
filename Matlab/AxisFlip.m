function pose_new = AxisFlip(axis,pose_b)
%AXISFLIP 축 뒤집기 python 코드 디버그 하면서 체크 사이즈랑 어디어디 뒤집어야하나...
% 3x4 받는건가?? R에만 곱하나 아니면 t에도????
%   pose (3,4)
%   axis 
%        [x y z]
%        input aixs 값이 [-1,1,-1] 이라면 x,z aixs flip
pose_a = [diag(axis), [0; 0; 0]] ;
R_a = pose_a(:,1:3); 
t_a = pose_a(:,4);
R_b = pose_b(:,1:3); 
t_b = pose_b(:,4);
R_new = R_b*R_a;
t_new = R_b*t_a+t_b;
pose_new = zeros(3,4);
pose_new(:,1:3)= R_new;
pose_new(:,4) = t_new
end

