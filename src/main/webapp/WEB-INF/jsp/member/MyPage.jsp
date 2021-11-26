<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
      <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="../../js/jquery-3.6.0.js"></script>

<link href="../../css/egovframework/bootstrap.css" rel="stylesheet">
</head>


<style>
.thirddiv {
	display: grid;
	grid-template-columns: 1fr;
	grid-column-gap: 10px;
	margin-left: 50px;
	margin-top: 20px;
	margin-right: 100px;
}

.item:nth-child(1) {
	grid-column: 1/3;
	grid-row: 1/2;
	margin-bottom: 20px;
}

.info{
	margin-left: 50px;
	margin-bottom: 50px;
	margin-right : 300px;
}
.flexitem{
	margin-bottom: 7px;
}

</style>
<body>
	<jsp:include page="../home/Home.jsp" flush="true"></jsp:include>


	<div class="thirddiv">
		<div class="item">
			<h3>마이페이지</h3>
			<hr>
		</div>
		<div class="item">
		 <div class="form-group info" >
		 	<div class="flexitem">
			 	<label>이메일</label><br>
            	<span>${info.email}</span>
            	<br><br>
            </div>
				<label>비밀번호</label>
            	<input name="password" type="password" id="pw" class="form-control" />
            	<br>
          
		 		<label>비밀번호확인</label>            
            		<input name="pwconfirm" type="password" id="pwconfirm" class="form-control"/>
            		<div id="pw_confirm" style="text-align: left; font-size: 13px; margin-bottom: 4px; margin-top: 2px;">&nbsp;</div>
           
		 		<label>닉네임</label><br>
            		<span>${info.nickname}</span>
           			<br><br>
            
		 			<label>회사명</label>            
            		<input name="comp_name" id="comp_name" type="text" class="form-control" value="${info.comp_name }"/>
           
  			<button id="modify" class="btn btn-light" style="margin-top: 15px; float: right;">변경</button>
        </div>
		
	</div>
		<c:choose>
			<c:when test="${joinmsg eq'success'}">
				<script type="text/javascript">
    				alert('가입되었습니다.');
    				location.href="/intro";
    			</script>
			</c:when>
			
			<c:when test="${joinmsg eq'failed'}">
				<script type="text/javascript">
    				alert('가입에 실패하였습니다.');
    				location.href="/joinview";
    			</script>
			</c:when>
		</c:choose> 
	
</div>
</body>
<script type="text/javascript">
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
	 
	 $("#modify").click(function () {
		if (checkPw()) {
			$.ajax({
		        url         :   "/modify",
		        dataType    :   "json",
		        contentType :   "application/x-www-form-urlencoded; charset=UTF-8",
		        type        :   "post",
		        data        :   {"pw" : $('#pw').val(),
		        				  "comp_name" : $('#comp_name').val()},
		        success     :   function(retVal){
		            if(retVal.code == 'OK') {
		            	alert(retVal.message);
		            	var link = "/";
		            	location.href = link;
		            } else {
		            	 alert("수정에 실패하였습니다.");
		            }
		             
		        },
		        error       :   function(request, status, error){
		            console.log("AJAX_ERROR");
		        }
		    });
		}
		else{
			alert('비밀번호가 일치하지 않습니다.');
		}
	})
	 
});

function checkPw() {
	 var pwconfirm = $('#pw_confirm').text();
	 console.log(pwconfirm);
	 if(pwconfirm == "비밀번호가 일치합니다."){
		 return true;
	 } else {
		 
		 return false;
	 }
}
</script>
</html>