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
	var roomNo = "${roomNo}";
	var messageInput = $("#message").val();
	var sock = new SockJS(
				"${pageContext.request.contextPath}/endpoint");
	var client = Stomp.over(sock);
    
    	client.connect({},function() {
    		alert("connect");
			//메세지 들어오는곳 == 구독한 채팅 채널
            //roomNo는 채팅창 접속하는 url에 get방식의 값으로 연결해줌
            //ex)채팅url?roomNo=13 이면 jsp el태그로 ${roomNo}로 가져와서 사용
			client.subscribe('/subscribe/chat/'+ roomNo,function(chat) {
			
			//받은 데이터
			var content = JSON.parse(chat.body);
			 alert(content.chatContent);
			 appendMessage(content.chatContent);
			});
                            
       });
       
    	function appendMessage(msg) {
    		$("#chatMessageArea").append(msg + "<br>");
    		var chatAreaHeight = $("#chatArea").height();
    		var maxScroll = $("#chatMessageArea").height() - chatAreaHeight;
    		$("#chatArea").scrollTop(maxScroll);
    	}
    	
       function sendmsg() {
    	   var message =  $("#message").val();
    	   client.send('/app/hello/' + roomNo, {}, JSON
       			.stringify({
       				chatContent : message,
       				memberId : "${loginMember.memberId}"

       	}));
    	   $("#message").val("");
	}
    	
       $(document).ready(function() {
    		$('#message').keypress(function(event) {
    			var keycode = (event.keyCode ? event.keyCode : event.which);
    			if (keycode == '13') {
    				send();
    			}
    			event.stopPropagation();
    		});
    		$('#sendBtn').click(function() {
    			sendmsg();
    		});
    		$('#enterBtn').click(function() {
    			connect();
    		});
    		$('#exitBtn').click(function() {
    			disconnect();
    		});
    	});
});


</script>
<style>
#chatArea {
	width: 200px;
	height: 100px;
	overflow-y: auto;
	border: 1px solid black;
}
</style>
<body>
	이름:
	<input type="text" id="nickname">
	<input type="button" id="enterBtn" value="입장">
	<input type="button" id="exitBtn" value="나가기">

	<h1>대화 영역</h1>
	<div id="chatArea">
		<div id="chatMessageArea"></div>
	</div>
	<br />
	<input type="text" id="message">
	<input type="button" id="sendBtn" value="전송">
	<br>
	<button class="btn btn-secondary">123</button>

	<button class="btn btn-primary" id="onDisplay">양식</button>
	<div class="col-md-5" id="onDisplayDiv" style="display: none;">
		<button class="btn btn-secondary">크림스파게티</button>
		<button class="btn btn-secondary">토마토스파게티</button>
		
		<button class="btn btn-primary" id="onDisplay2">피자</button>
		<div class="col-md-5" id="onDisplay2Div" style="display: none;">
			<button class="btn btn-secondary">고구마피자</button>
			<button class="btn btn-secondary">포테이토피자</button>
		</div>
		
	</div>
</body>
</html>