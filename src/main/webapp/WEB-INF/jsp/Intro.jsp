<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
      <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>머먹GANG</title>
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
		redirectUri: 'http://192.168.33.91/loginpage_kakao_callback'
		}); 
}

function gotoJoin() {
	var link = "/joinview";
	location.href = link;
	
}

function loginWithKakao() {
    Kakao.Auth.login({
      success: function(authObj) {
    	  Kakao.API.request({
    		  url: '/v2/user/me',
    		  success: function(result) {
				var id = result.id;
				var kakao_account = result.kakao_account
				var email = kakao_account.email;
				console.log("email = "+kakao_account.email +", gender = "+kakao_account.gender + ", age_range"+kakao_account.age_range);
				
				fetch('/idcheck?checkId='+email)
				.then(function(response){
					return response.json();
				})
				.then(function(myJson) {
					console.log(JSON.stringify(myJson));
					if(myJson.usedCnt > 0){ //존재하는 이메일 로그인 성공
						$.ajax({
							url :'/kakaologin',
							type : 'post',
							dataType : 'json',
							data : { "email" : email, 
									"kakao" : true
								},
								success: function(data){
									location.href=data;
									} 
								});

					}
					else { // 존재하지 않는 이메일 가입 페이지로 이동
						var cast = { "email" : email };
						sessionStorage.setItem("cast", JSON.stringify(cast));
						var link = "/joinview";
						location.href = link;
					}
				});
			}
    	  })
        
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
	flex-direction: column;
	align-items: center;
	position:fixed;
	height: 100%;
	width: 100%;
	z-index: 1;
}

.intro2 {
	display:flex;
	flex-wrap:wrap;
	justify-content:center;
	align-items: center;
	position:fixed;
	width: 40%;
}

.intro::after{
	height: 100%;
	width: 100%;
	 content: "";
	  position: absolute;
	  opacity:0.35;
  background: url("/images/egovframework/intro/intro.png");
  z-index: -1;
}
.form-group{
	display: inline-block;
	width: 70%;
}
.firstdiv{
	height: 320px;
	width: 400px;
	text-align: center;
	border: 1px solid gray;
	border-radius: 2em;
	background-color: white;
	padding: 20px;
	margin-bottom: 20px;
}
.seconddiv{
	height: 120px;
	width: 400px;
	text-align: center;
	border: 1px solid gray;
	border-radius: 2em;
	background-color: white;
	padding: 20px;
}
a {
 	text-decoration:none;
	color: black;
  }
 a:hover {
  	text-decoration:none;
  	color: black;
  	}
  	.hr-sect {
        display: flex;
        flex-basis: 100%;
        align-items: center;
        color: rgba(0, 0, 0, 0.35);
        font-size: 13px;
        margin: 8px 0px;
      }
      .hr-sect::before,
      .hr-sect::after {
        content: "";
        flex-grow: 1;
        background: rgba(0, 0, 0, 0.35);
        height: 1px;
        font-size: 0px;
        line-height: 0px;
        margin: 0px 16px;
      }
</style>

<body>

<div class="intro">
<img alt="" src="../../images/egovframework/logo.png" style="background-color: white; padding: 10px; padding-top: 30px;">
	<form action="/login" method="post">
	<div class="firstdiv">
		<h5>로그인</h5>
		<br>
		 <div class="form-group">
            <input name="email" type="text" class="form-control" placeholder="이메일" />
            <br>
            <input name="password" type="password" class="form-control" placeholder="비밀번호"/>
        </div>
        <br>
		<button class="btn btn-primary" type="submit" style="margin-bottom: 5px;">로그인</button><br>
		<div class="hr-sect">또는</div>
		<a id="custom-login-btn" href="javascript:loginWithKakao()">
  		<img src="/images/egovframework/intro/kakaolink_btn_small.png" width="20px"/>
  		카카오톡으로 시작하기</a>
	</div>
    	
	</form>
	
    	<c:if test="${map.msg == 'failure'}">
    		<script type="text/javascript">
    			alert('이메일 또는 비밀번호가 일치하지 않습니다.');
    		</script>
    	</c:if>
	<div class="seconddiv">
		<p>계정이 없으신가요?</p>
		<button class="btn" onclick="gotoJoin()">회원가입</button>
	</div>
	
		
</div>
	
	
</body>
</html>