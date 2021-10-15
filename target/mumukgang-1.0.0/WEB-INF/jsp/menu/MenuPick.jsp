<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<!DOCTYPE html>
<html>
<head>
<script src="http://code.jquery.com/jquery-latest.js"></script>
<link href="/css/egovframework/bootstrap.css" rel="stylesheet">
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<script>
$(function(){
	$('#onDisplay').click(function(){
		if($("#noneDiv").css("display") == "none"){
			$('#noneDiv').show();
		}
		else{
			$('#noneDiv').hide();
		}
	});
});
</script>
<body class = "container">
 <button class="btn btn-secondary">123</button>
<div class="col-md-5" id="noneDiv" style="display: none;"> <button class="btn btn-secondary">숨은버튼</button></div>
 <button class="btn btn-secondary" id="onDisplay">숨은 DIV보이기</button>
</body>
</html>