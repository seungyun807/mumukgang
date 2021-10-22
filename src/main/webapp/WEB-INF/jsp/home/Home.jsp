<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<!-- <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css">-->
<meta charset="UTF-8">
 <meta name="viewport" content="width=device-width, initial-scale=1.0">
<script src="../../js/jquery-3.6.0.js"></script>
<link href="/css/egovframework/styles.css" rel="stylesheet">
<title>Insert title here</title>
</head>

<script type="text/javascript">
	function gotoLogout(){
		var link = "/logout";
		location.href = link;
	}
	
	function gotoFriendsList() {
		var link = "/friendslist"
		location.href = link;
		
	}
</script>
<body id="body-pd">
    <div class="l-navbar" id="navbar">
        <nav class="nav">
            <div>
                <div class="nav__brand">
                    <ion-icon name="menu-outline" class="nav__toggle" id="nav-toggle"></ion-icon>
                    <a href="/home" class="nav__logo">머먹겡</a>
                </div>
                <div class="nav__list">
                    <a href="/menupick/1" class="nav__link active">
                        <ion-icon name="home-outline" class="nav__icon"></ion-icon>
                        <span class="nav_name">menupick test</span>
                    </a>
                    <a class="nav__link" onclick="gotoFriendsList()">
                        <ion-icon name="people-outline" class="nav__icon"></ion-icon>
                        <span class="nav_name">친구목록</span>
                    </a>
                     <a class="nav__link" onclick="gotoFriendsList()">
                        <ion-icon name="search-outline" class="nav__icon"></ion-icon>
                        <span class="nav_name">친구찾기</span>
                    </a>
                     <a class="nav__link" onclick="gotoFriendsList()">
                        <ion-icon name="chatbubble-outline" class="nav__icon"></ion-icon>
                        <span class="nav_name">채널</span>
                    </a>

                    <div href="#" class="nav__link collapse">
                        <ion-icon name="folder-outline" class="nav__icon"></ion-icon>
                        <span class="nav_name">Projects</span>

                        <ion-icon name="chevron-down-outline" class="collapse__link"></ion-icon>

                        <ul class="collapse__menu">
                            <a href="#" class="collapse__sublink">Data</a>
                            <a href="#" class="collapse__sublink">Group</a>
                            <a href="#" class="collapse__sublink">Members</a>
                        </ul>
                    </div>

                   

                    <div href="#" class="nav__link collapse">
                        <ion-icon name="people-outline" class="nav__icon"></ion-icon>
                        <span class="nav_name">Team</span>

                        <ion-icon name="chevron-down-outline" class="collapse__link"></ion-icon>

                        <ul class="collapse__menu">
                            <a href="#" class="collapse__sublink">Data</a>
                            <a href="#" class="collapse__sublink">Group</a>
                            <a href="#" class="collapse__sublink">Members</a>
                        </ul>
                    </div>

                    <a href="#" class="nav__link">
                        <ion-icon name="settings-outline" class="nav__icon"></ion-icon>
                        <span class="nav_name">Settings</span>
                    </a>
                </div>
                <a href="#" class="nav__link">
                    <ion-icon name="log-out-outline" class="nav__icon"></ion-icon>
                    <span class="nav_name">로그아웃</span>
                </a>
            </div>
        </nav>
    </div>

    <!-- IONICONS -->
    <script src="https://unpkg.com/ionicons@5.5.2/dist/ionicons/ionicons.js"></script>
    <!-- JS -->
    <script src="../../js/main.js"></script>
</body>
</html>