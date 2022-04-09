# OptiTrack_DataStreaming

## 관련 사이트 모음
:heavy_check_mark: [NatNet SDK](https://optitrack.com/software/natnet-sdk/)

:heavy_check_mark: [NatNet SDK 3.1 Doc](https://v30.wiki.optitrack.com/index.php?title=NatNet_SDK_3.1/)

:heavy_check_mark: [NatNet sample 파일 설명](https://v30.wiki.optitrack.com/index.php?title=NatNet:_Sample_Projects#Running_the_Console_Output_Sample_.28Sample_Client.29)

:heavy_check_mark: [Optitrack 질문 사이트](https://forums.naturalpoint.com/viewforum.php?f=78)


## Optitrack Data Streaming 방법(Matlab 기준)
[Matlab 설정]
1. [NatNet SDK](https://optitrack.com/software/natnet-sdk/) 3.1 version 다운로드
2. Matalb에서 `\NatNet_SDK_3.1\NatNetSDK\Samples\Matlab` 에 있는 `NatNetPollingSample.m`, `NatNetEventHandlerSample.m` 파일 open, `.dll` 종속 파일 추가
3. Server computer, Client(노트북) 의 ip 주소 확인 - ipconfig 명령어 통해
4.  `NatNetPollingSample.m` 에서 ip 주소 변경 후 실행. 

      초당 x,y,z 데이터가 한줄에 저장됨. 
      
      스트리밍 시간 time 변수 값으로 조절
      
position 이외에 rotation 값 저장 필요시 `NatNetEventHandlerSample.m` 파일 참고해 코드 수정

[Optitrack 설정]
1. [Motive] Start a NatNet server application (e.g. Motive).

2. [Motive] Enable NatNet streaming from the Server application.
3. 3개 이상 마커 부착 후 드레그 해 하나의 rigidbody로 등록(rigidbody로 등록해야함. matlab 코드가 rigidbody 기준으로 작성되어 있음.)

c++,python 등으로도 가능 [NatNet smaple project](https://v30.wiki.optitrack.com/index.php?title=NatNet:_Sample_Projects#Running_the_Console_Output_Sample_.28Sample_Client.29) 페이지 하단 참고.
