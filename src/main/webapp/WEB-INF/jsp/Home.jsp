<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
      <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>머먹겡</title>
</head>
<script src="../../js/jquery-3.6.0.js"></script>
<link rel="shortcut icon" href="#">
<!-- Bootstrap CSS -->
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css">
<!-- 카카오 로그인 -->
<script type="text/javascript" src="https://developers.kakao.com/sdk/js/kakao.min.js" charset="utf-8"></script>
<script type="text/javascript">
$(document).ready(function(){
		Kakao.init('2eebb72cbf45a61d75d2efc7638259a2'); 
		Kakao.isInitialized();
	});

function gotoLogin() {
	Kakao.Auth.authorize({
		redirectUri: 'http://localhost/user/loginpage_kakao_callback'
		}); 
}

function gotoJoin() {
	var link = "/join";
	location.href = link;
	
}

function loginWithKakao() {
    Kakao.Auth.login({
      success: function(authObj) {
    	
        alert("성공 = "+JSON.stringify(authObj))
      },
      fail: function(err) {
        alert(JSON.stringify(err))
      },
    })
  }
  
</script>
<style>

.intro {
	display:flex;
	justify-content:center;
	flex-direction: row;
	align-items: center;
	position:fixed;
	height: 100%;
	width: 100%;
	z-index: 1;
}
.intro::after{
	height: 100%;
	width: 100%;
	 content: "";
	  position: absolute;
	  opacity:0.3;
  background: url("/images/egovframework/intro/intro.png");
  z-index: -1;
}
.form-group{
	display: inline-block;
	width: 70%;
}
.firstdiv{
	height: 380px;
	width: 400px;
	text-align: center;
	border: 1px solid gray;
	border-radius: 2em;
	background-color: white;
	padding: 20px;
}
</style>

<body>
<div class="intro">

	<div class="firstdiv">
		<h1>머먹겡</h1>
		<br>
		 <div class="form-group">
            <input name="user_id" type="text" class="form-control" placeholder="아이디" />
            <br>
            <input name="password" type="password" class="form-control" placeholder="비밀번호"/>
        </div>
        <br>
		<button class="btn btn-primary" onclick="gotoLogin()" style="margin-bottom: 5px;">로그인</button><br>
		<p>or</p>
		<a id="custom-login-btn" href="javascript:loginWithKakao()">
  		<img src="/images/egovframework/intro/kakaolink_btn_small.png" width="20px"/>
  		카카오톡으로 시작하기</a>
		<br>
		 <hr class="my-2" style="width: 90%">
		 <p>계정이 없으신가요?</p>
		<button class="btn" onclick="gotoJoin()">회원가입</button>
	</div>

	
</div>

</body>
</html>