# 머먹GANG
![logo](https://user-images.githubusercontent.com/76242399/145909545-6c99c6a8-7340-435c-a780-e0378cb8255c.png)
<br><br>
## 📌개요
직장인들의 점심 메뉴 선택과 위치 정보<br>
점심 시간을 위한 커뮤니티 웹 서비스
<br><br>

## 📌배경
직장인들은 항상 메뉴를 고민한다 그리고 메뉴 선택에 어려움을 겪을 때가 종종 있다. 또 서로 의견이 안 맞아 뭘 먹어야 할지 고민한다. 이런 부분을 해소시키고 메뉴 선택에 있어서 좀 더 쉽고 재미있게 하기 위해서이다. 또 사내 친목 그룹이 이미 존재해 다른 인원들과 점심을 잘 먹지 않게 되어 사내 소통이 단절되는 경우도 있다. 이러한 복합적인 점심 문화의 문제점에 해결 방안을 제시하고자 한다.

다음과 같이 문제점을 나열할 수 있다.
1. 메뉴 선택에 대한 고충
2. 메뉴 의견에 대한 고충
3. 사내 친목그룹 형성으로 인한 소통 단절
<br><br>

## 📌기대효과
점심메뉴 선택을 좀 더 재밌고 쉽게 소통하며 정할 수 있다. 그 외에 사내 또는 사외를 통해 같은메뉴 또는 함께 먹을 사람을 구하여 사내에는 좀 더 활발한 소통을 유도하고 사외에는 같은 메뉴를 먹고 싶은 사람을 구하여 먹고싶은 메뉴를 먹을 수 있다.
<br><br>

## 📌개발환경
![image](https://user-images.githubusercontent.com/76242399/146853743-62c8f2bc-458c-4601-a131-ae10647ac064.png)

* Java
* 전자정부프레임워크
* 스프링
* Stomp
* MyBatis
* MariaDB
* jQuery
* 톰캣
<br><br>

## 📌구조도
![image](https://user-images.githubusercontent.com/76242399/146853732-bf8687a7-7d39-4987-9e70-ff8bc3bc5ba5.png)

## 📌기능
- [로그인](#로그인)
- [마이페이지](#마이페이지)
- [채널찾기](#채널찾기)
- [채널목록](#채널목록)
- [채널](#채널)
- [친구목록](#친구목록)
- [친구찾기](#친구찾기)
<br>

### 로그인
<div>
<img src="https://user-images.githubusercontent.com/76242399/145936008-0a5ffb9d-1fff-4126-8e38-8367004f7310.png" width="30%"/>
<img src="https://user-images.githubusercontent.com/76242399/145936012-583d9162-907a-43fc-a198-001e04749c8d.png" width="30%"/>
</div>
<br>
- 이메일과 비밀번호로 로그인 가능하다.<br>
- 카카오톡으로 로그인 및 가입 가능하다.<br>
- 회원가입 항목으로는 이메일(중복불가), 비밀번호, 닉네임(중복불가), 회사명이 존재한다.
<br><br>

### 마이페이지
<img src="https://user-images.githubusercontent.com/76242399/145936067-828f4116-6609-4051-9971-df6d595aaeb3.png" width="30%"/>
- 마이페이지를 통해 비밀번호와 회사명을 바꿀 수 있다.
<br><br>

### 채널찾기
<img src="https://user-images.githubusercontent.com/76242399/145915508-2a87aeb3-ea45-460d-85da-6f7b437a463f.png" width="60%"/>
공개된 채널을 찾는 메뉴이다.<br>
- 공개된 채널은 모두가 입장이 가능하다.<br>
- 같은 메뉴가 먹고 싶은 사내 직원 또는 주변 회사 직원을 찾을 수 있다.<br>
- 같이 먹고 싶은 사람을 구하여 메뉴를 같이 정할 수도 있다.
<br><br>

### 채널목록
<img src="https://user-images.githubusercontent.com/76242399/145916211-297f6756-1a85-41a2-b27e-a427766d594b.png" width="60%"/>
로그인한 계정이 참여중인 비공개 채널과 방장인 채널의 목록이다.<br>
- 채널의 목록을 볼 수 있다.<br>
- 채널을 만들 수 있다.<br>
- 초대된 채널을 볼 수 있다.
<br><br>

### 채널
<img src="https://user-images.githubusercontent.com/76242399/145916236-62c6d8e2-e1f9-4d74-b954-380de5528f1c.png" width="60%"/>
전체적인 채널의 모습이다.<br>
- 우측에 채팅창이 존재하고 모든 내역이 저장된다. (stomp)<br>
- 메뉴 버튼으로 메뉴를 선택 할 수 있고 선택된 메뉴는 하단의 박스에 추가된다. (stomp)<br>
- 선택된 메뉴들을 랜덤뽑기 할 수 있다. (stomp)<br>
- 랜덤뽑기 결과 키워드를 통해 2km내의 음식점 위치를 찾을 수 있다. (카카오API)<br>
- 메뉴목록을 비울 수 있다. (stomp)<br>
- 채널삭제 또는 채널을 나갈 수 있다. (stomp)
<br><br>

### 친구찾기
<img src="https://user-images.githubusercontent.com/76242399/145916253-5d515444-1666-4dec-968c-c22e5f514ddb.png" width="60%"/>
- 이메일 또는 닉네임으로 검색 할 수 있다.<br>
- 받은 친구요청을 통해 수락 또는 거절 할 수 있다.<br>
- 요청한 친구를 통해 확인 및 요청 취소를 할 수 있다.
<br><br>

### 친구목록
<img src="https://user-images.githubusercontent.com/76242399/145916271-1c96514b-4e0a-4efc-99cb-60133b7b36a7.png" width="60%"/>
- 친구 목록을 확인 할 수 있다.<br>
- 휴지통버튼을 통해 친구 삭제를 할 수 있다.
<br><br>



