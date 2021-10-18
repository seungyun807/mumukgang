<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
      <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Join · 머먹겡</title>
</head>
<script src="../../js/jquery-3.6.0.js"></script>
<link rel="shortcut icon" href="#">
<!-- Bootstrap CSS -->
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css">
<script type="text/javascript">

function gotoLogin() {
	var link = "/login";
	location.href = link;
}

function gotoJoin() {
	var link = "/Join";
	location.href = link;
	
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
	width:70%;
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
            <br>
            <input name="password" type="password" class="form-control" placeholder="비밀번호확인"/>
        </div>
		 <hr class="my-2" style="width: 90%">
		
		<button class="btn" onclick="gotoJoin()" style="margin-top: 5px;">회원가입</button>
	</div>

	
</div>

</body>
</html>