<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<!-- <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css">-->
<meta charset="UTF-8">
 <meta name="viewport" content="width=device-width, initial-scale=1.0">
<link href="/css/egovframework/styles.css" rel="stylesheet">
<title>Insert title here</title>
</head>

<script type="text/javascript">
	function gotoMyPage(){
		var link = "/confirmmypage";
		location.href = link;
	}

	function gotoFindChannel() {
		var link = "/findchannel";
		location.href = link;
	}

	function gotoFriendsList() {
		var link = "/friendslist"
		location.href = link;
	}
	
	function gotoFindFriends() {
		var link = "/findfriends"
		location.href = link;
	}
	
	function gotoChannel() {
		var link = "/channel"
		location.href = link;
	}
	
	function gotoLogout(){
		var link = "/logout";
		location.href = link;
	}
	
	
</script>
<body id="body-pd">
    <div class="l-navbar" id="navbar">
        <nav class="nav">
            <div>
                <div class="nav__brand">
                    <ion-icon name="menu-outline" class="nav__toggle" id="nav-toggle"></ion-icon>
                    <span href="#" class="nav__logo"  onclick="gotoMyPage()">${nickname }</a>
                </div>
                <div class="nav__list">
                    <a href="#" class="nav__link active" id="findchannel" onclick="gotoFindChannel()">
                        <ion-icon name="home-outline" class="nav__icon"></ion-icon>
                        <span class="nav_name">채널찾기</span>
                    </a>
                    <a href="#" class="nav__link"  id="friendlist" onclick="gotoFriendsList()">
                        <ion-icon name="people-outline" class="nav__icon"></ion-icon>
                        <span class="nav_name">친구목록</span>
                    </a>
                     <a href="#"class="nav__link" id="findfriend" onclick="gotoFindFriends()">
                        <ion-icon name="search-outline" class="nav__icon"></ion-icon>
                        <span class="nav_name">친구찾기</span>
                    </a>
                     <a class="nav__link" id="channel"  onclick="gotoChannel()" >
                        <ion-icon name="chatbubble-outline" class="nav__icon"></ion-icon>
                        <span class="nav_name">채널</span>
                    </a>
                
                <a href="#" class="nav__link" onclick="gotoLogout()">
                    <ion-icon name="log-out-outline" class="nav__icon"></ion-icon>
                    <span class="nav_name">로그아웃</span>
                </a>
                </div>
            </div>
        </nav>
    </div>

    <!-- IONICONS -->
    <script src="https://unpkg.com/ionicons@5.5.2/dist/ionicons/ionicons.js"></script>
    <!-- JS -->
    <script src="../../js/main.js"></script>
    <script src="../../js/jquery-3.6.0.js"></script>
</body>
</html>