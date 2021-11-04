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
<%
	String loginid = (String) session.getAttribute("email");
	String nickname = (String) session.getAttribute("nickname");
%>
<style>
#pickBox{
	width: 80%;
	height: 80%;
}
#chatArea {
	width: 100%;
	height: 80%;
	
}
#sendBtn{
	width: 32px;
    height: 32px;
}

.mydiv {
	display: grid;
	grid-template-columns: 3.5fr 1fr;
	grid-template-rows: 1fr 6fr 1fr;
	grid-column-gap: 10px;
	margin-left: 50px;
	margin-top: 20px;
	margin-right: 50px;
}

.item:nth-child(1) {
	margin-bottom : 40px;
	
}
.item:nth-child(3) {
	margin : 10px;
	
}
input{
	width: 80%;
	height: 30px;
}
.inputdiv{
	display: flex;
}

</style>
<body>
	<jsp:include page="../home/Home.jsp" flush="true"></jsp:include>
	<div class="mydiv">
		<div class="item">
			<h3>채널</h3>
		</div>

		<div class="item"></div>

		<div class="item">
			<div id="page-content-wrapper">
				<div class="container-fluid">
					<button class="btn btn-secondary">123</button>
					<div class="col-md-5" id="noneDiv" style="display: none;">
						<button class="btn btn-secondary">숨은버튼</button>
					</div>
					<button class="btn btn-secondary" id="onDisplay">숨은 DIV보이기</button>
				</div>
			</div>
		</div>
		<div class="item">

			<div id="chatArea" class="form-control">
				<div id="chatMessageArea"></div>
			</div>
			<br>
			<div class="inputdiv">
			 <input type="text" id="message" class="form-control"/>
			 <button class="btn btn-warning" id="sendBtn" ><ion-icon name="send-outline"></ion-icon></button>
			</div> <br>

		</div>
		<div class="item">
			<div id="pickBox" class="form-control">
				<div id="pickArea"></div>
			</div>
		</div>
		<div class="item">

			<button class="btn btn-primary" id="delchannelbtn">채널삭제</button>
		</div>


	</div>



</body>

<script type="text/javascript">

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

	$(function() {
		$("#menupick").removeClass("active");
		$("#friendlist").removeClass("active");
		$("#findfriend").removeClass("active");
		$("#channel").addClass("active");
		var nickname = "<%=nickname%>";
		var roomNo = "${roomNo}";

		var messageInput = $("#message").val();
		var sock = new SockJS("${pageContext.request.contextPath}/endpoint");
		var client = Stomp.over(sock);

		client.connect({}, function() {
			//alert("connect");

			//메세지 들어오는곳 == 구독한 채팅 채널
			//roomNo는 채팅창 접속하는 url에 get방식의 값으로 연결해줌
			//ex)채팅url?roomNo=13 이면 jsp el태그로 ${roomNo}로 가져와서 사용

			client.subscribe('/subscribe/chat/' + roomNo, function(chat) {

				//받은 데이터
				var content = JSON.parse(chat.body);
				//appendMessage(content.chatContent);
				appendMessage(content);
			});

		});

		function appendMessage(msg) {
			$("#chatMessageArea").append(
					msg.memberId + ": " + msg.chatContent + "<br>");
			var chatAreaHeight = $("#chatArea").height();
			var maxScroll = $("#chatMessageArea").height() - chatAreaHeight;
			$("#chatArea").scrollTop(maxScroll);
		}

		function sendmsg() {
			var message = $("#message").val();
			client.send('/app/hello/' + roomNo, {}, JSON.stringify({
				chatContent : message,
				memberId : nickname

			}));
			$("#message").val("");
		}

		$(document).ready(function() {
			$('#message').keypress(function(event) {
				var keycode = (event.keyCode ? event.keyCode : event.which);
				if (keycode == '13') {
					sendmsg();
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
</html>