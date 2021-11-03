<%@ page contentType="text/html; charset=UTF-8" trimDirectiveWhitespaces="true"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>채팅</title>
<link href="../../css/egovframework/bootstrap.css" rel="stylesheet">
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script src="../../js/sockjs-0.3.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/stomp.js/2.3.3/stomp.min.js"></script>

<script>
$(function() {
		alert("채널 접근 권한이 없습니다.");
		var link="/"
		location.href=link;
});


</script>
<body>
<jsp:include page="../home/Home.jsp" flush="true"></jsp:include>
	
</body>
</html>