# Optitrack Data Streaming  - Matlab


## NatNetPollingSample.m 실행 후 txt format
timestamp px py pz qx qy qz qw
rot으로 바꾼 버전도 저장하자

- timestamp : ms 단위, 유닉스 포맷
- position : mm 단위
- model.RigidBodyCount : 하나의 rigidbody에서 설정한 중심 position(마커당 포지션 아님.)


optitrack inertial frame [left up forward]
iphone inertial frame 확인해보니
[left,up,forward] (data streaming option에서 up axis를 y로 설정)
다음과 같이 나와

실험에선 ios_logger와 frame 맞춰야하기 때문에  x,z 축을 flip 시켜 저장하도록 코드 수정

따라서 최종적으로
[right,up,backward]의 m 단위로 txt 파일 저장됨


