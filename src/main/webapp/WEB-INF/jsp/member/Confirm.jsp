<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
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

.info {
	margin-left: 50px;
	margin-bottom: 50px;
	margin-right: 300px;
}

.flexitem {
	margin-bottom: 7px;
}

span {
	margin-left: 5px;
}

.confirmdiv {
	display: flex;
	flex-direction: column;
	align-items: center;
	margin-top: 20%;
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
			<div class='confirmdiv'>
					<div class="form-group">
						<div class="flexitem"></div>
						<label>비밀번호</label>
						<div style="display: flex;">
							<input name="password" type="password" id="pw" class="form-control" />
							<button class="btn btn-secondary" style="width: 70px;">확인</button>
						</div>

					</div>
			</div>
		</div>
	</div>
</body>
<script type="text/javascript">
function gotomypage() {
	var link = "/mypage";
	location.href = link;
}
function confirmpw() {
	var pw = $('#pw').val();
	if(pw == ''){
		alert('비밀번호를 입력해주세요.');
	}
	else {
	$.ajax({
        url         :   "/mypagegate",
        dataType    :   "json",
        contentType :   "application/x-www-form-urlencoded; charset=UTF-8",
        type        :   "post",
        data        :   {"password" : pw},
        success     :   function(retVal){
            if(retVal.code == 'OK') {
            	gotomypage();
            } else {
            	 alert(retVal.message);
            }
             
        },
        error       :   function(request, status, error){
            console.log("AJAX_ERROR");
        }
    });
	}
}
$(document).ready(function() {
	$('#pw').keypress(function(event) {
		var keycode = (event.keyCode ? event.keyCode : event.which);
		if (keycode == '13') {
			confirmpw();
		}
		event.stopPropagation();
	});
})
</script>
</html>