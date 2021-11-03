<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ include file="../home/Home.jsp" %>
<!DOCTYPE html>
<html>
<head>
<script src="http://code.jquery.com/jquery-latest.js"></script>

<link href="/css/egovframework/bootstrap.css" rel="stylesheet">
<link href="/css/egovframework/styles.css" rel="stylesheet">
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<script>
$( document ).ready(function() {
	$("#menupick").addClass("active");
	$("#friendlist").removeClass("active");
	$("#findfriend").removeClass("active");
});


$(function(){
	
	$('#onDisplay').click(function(){
		if($("#noneDiv").css("display") == "none"){
			$('#noneDiv').css("display", "inline");
		}
		else{
			$('#noneDiv').css("display", "none");
		}
	});
});
</script>
<style>
.container{
	display: flex;
}
</style>


<!-- 본문 -->
  <div id="page-content-wrapper">
    <div class="container-fluid">
      <button class="btn btn-secondary">123</button>
      <div class="col-md-5" id="noneDiv" style="display: none;"> <button class="btn btn-secondary">숨은버튼</button></div>
      <button class="btn btn-secondary" id="onDisplay">숨은 DIV보이기</button>
    </div>
  </div>
  <h2>메뉴선정</h2>
  <!-- /본문 -->

</html>