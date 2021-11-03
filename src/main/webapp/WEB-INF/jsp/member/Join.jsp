<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
      <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Join · 머먹겡</title>
</head>
<script src="../../js/jquery-3.6.0.js"></script>
<link rel="shortcut icon" href="#">
<!-- Bootstrap CSS -->
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css">
<script type="text/javascript">
var kakaojoin = false;
var json = "";

$(function() {
	json = JSON.parse(sessionStorage.getItem("cast"));
	if(json != null){
		$('#email').val(json.email);
	
		$('#email').attr("readonly", true);
		
		sessionStorage.removeItem("cast");
		kakaojoin = true;
	}
    $("#email").keyup(function() {
    
        //userid 를 param.
        var userid =  $("#email").val();
        if (userid == "") {
        	$("#id_check").text("\u00a0");
		}
        else if(userid.includes("@")){
        $.ajax({
            type : 'GET',
            data : {
    			"checkId": $("#email").val()			
    		},
            url : "<c:url value='idcheck'/>",
            dataType : 'json',
            contentType: "application/json; charset=UTF-8",
            success : function(returnData, status) {
            	console.log(returnData);
            	if(status == "success") {
    				if(returnData.usedCnt > 0 ){
    					$("#id_check").css("color", "red");
    					$("#id_check").text("사용할수 없는 아이디입니다.");
    				}else{
    					$("#id_check").css("color", "blue");
    					$("#id_check").text("사용가능한 아이디입니다.");
    				}
    			}else{ alert("ERROR!" + error);return;} 
            }
        });
        }
    });
    
    $("#nickname").keyup(function() {
        
        //userid 를 param.
        var nickname =  $("#nickname").val();
        if (nickname == "") {
        	$("#nickname_check").text("\u00a0");
		}
        else{
        $.ajax({
            type : 'GET',
            data : {
    			"checkNick": nickname	
    		},
            url : "<c:url value='nickcheck'/>",
            dataType : 'json',
            contentType: "application/json; charset=UTF-8",
            success : function(returnData, status) {
            	console.log(returnData);
            	if(status == "success") {
    				if(returnData.usedCnt > 0 ){
    					$("#nickname_check").css("color", "red");
    					$("#nickname_check").text("사용할수 없는 닉네임입니다.");
    				}else{
    					$("#nickname_check").css("color", "blue");
    					$("#nickname_check").text("사용가능한 닉네임입니다.");
    				}
    			}else{ alert("ERROR!" + error);return;} 
            }
        });
        }
    });
    
});

$(function() {
	 $("#pwconfirm").keyup(function() {
		
		 var pw =  $("#pw").val();
		 var pwconfirm =  $("#pwconfirm").val();
		 if (pw == "" || pwconfirm == "" ) {
			 $("#pw_confirm").text("\u00a0");
			}		 
		 else if(pw != pwconfirm){
	 		$("#pw_confirm").css("color", "red");
	 		$("#pw_confirm").text("비밀번호가 일치하지 않습니다.");		
	 	} else{
	 		$("#pw_confirm").css("color", "blue");
	 		$("#pw_confirm").text("비밀번호가 일치합니다.");
	 	}
	 });
	 $("#pw").keyup(function() {
		 var pw =  $("#pw").val();
		 var pwconfirm =  $("#pwconfirm").val();
		 if (pw == "" || pwconfirm == "" ) {
			 $("#pw_confirm").text("\u00a0");
			}		
		 else if(pw != pwconfirm){
	 		$("#pw_confirm").css("color", "red");
	 		$("#pw_confirm").text("비밀번호가 일치하지 않습니다.");		
	 	} else{
	 		$("#pw_confirm").css("color", "blue");
	 		$("#pw_confirm").text("비밀번호가 일치합니다.");
	 	}
	 });
});

function checkId() {
	 var idcheck = $('#id_check').text();
	 if((idcheck == "사용가능한 아이디입니다.") || kakaojoin){
		 return true;
	 } else {
		 alert('사용할수 없는 아이디입니다.')
		 return false;
	 }
}

function checkNickName() {
	 var nickname = $('#nickname_check').text();
	 if(nickname == "사용가능한 닉네임입니다."){
		 return true;
	 } else {
		 alert('사용할수 없는 닉네임입니다.')
		 return false;
	 }
}

function checkPw() {
	 var pwconfirm = $('#pw_confirm').text();
	 if(pwconfirm == "비밀번호가 일치합니다."){
		 return true;
	 } else {
		 alert('비밀번호가 일치하지 않습니다.')
		 return false;
	 }
}

function checkIdPw(){
	 console.log(checkIdPw);
	 if((checkId()&& checkPw()) && checkNickName()){
		 console.log(true);
		 return true;
	 }else{
		 console.log(false);
		 return false
	 }
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
	height: 490px;
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

	<form action="/join" onsubmit="return checkIdPw();" method="post">
	<div class="firstdiv">
		<h1>머먹겡</h1>
		<br>
		
		 <div class="form-group" >
            <input name="email" id="email" type="email" class="form-control" placeholder="이메일"  />
             <div id="id_check" style="text-align: left; font-size: 13px; margin-bottom: 4px; margin-top: 2px;">&nbsp;</div>

            <input name="password" type="password" id="pw" class="form-control" placeholder="비밀번호"/>
            <br>
            <input name="pwconfirm" type="password" id="pwconfirm" class="form-control" placeholder="비밀번호 확인"/>
            <div id="pw_confirm" style="text-align: left; font-size: 13px; margin-bottom: 4px; margin-top: 2px;">&nbsp;</div>
        	
            <input name="nickname" id="nickname" type="text" class="form-control" placeholder="닉네임"/>
            <div id="nickname_check" style="text-align: left; font-size: 13px; margin-bottom: 4px; margin-top: 2px;">&nbsp;</div>
            
            <input name="comp_name" id="comp_name" type="text" class="form-control" placeholder="회사명" />
  		
        </div>
        
		 <hr class="my-2" style="width: 90%">
		
		<button type="submit" class="btn" style="margin-top: 5px;">회원가입</button>
	</div>
</form>
	
</div>

</body>
</html>