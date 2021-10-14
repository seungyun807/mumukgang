<%@ page contentType="text/html; charset=UTF-8" trimDirectiveWhitespaces="true"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>채팅</title>
<link href="/css/egovframework/bootstrap.css" rel="stylesheet">
<script type="text/javascript" src="js/jquery-1.11.0.min.js"></script>
<script type="text/javascript">
	var wsocket;
	var nowDiv;
	function connect() {
		
		wsocket = new WebSocket("ws://" + location.host + "/chat-ws");
		wsocket.onopen = onOpen;
		wsocket.onmessage = onMessage;
		wsocket.onclose = onClose;
		alert(wsocket.url);
	}

	function disconnect() {
		wsocket.close();
	}
	function onOpen(evt) {
		appendMessage("연결되었습니다.");
	}
	function onMessage(evt) {
		var data = evt.data;
		
		if (data.substring(0, 4) == "msg:") {
			appendMessage(data.substring(4));
		}
		
		else if (data.substring(0, 4) == "div:") {
			nowDiv = data.substring(4);
		}
		else if (data.substring(0, 8) == "display:" ) {
			var display = data.substring(8);
			if (display == "inline") {
				$(nowDiv).css("display", "inline");
			} else {
				$(nowDiv).css("display", "none");
			}
		}
		
	}
	function onClose(evt) {
		appendMessage("연결을 끊었습니다.");
	}

	function send() {
		var nickname = $("#nickname").val();
		var msg = $("#message").val();

		wsocket.send("msg:" + nickname + ":" + msg);

		$("#message").val("");
	}

	function sendDiv(nowDiv) {
		var noneDiv = $(nowDiv).css("display");
		wsocket.send("div:" + nowDiv);
		wsocket.send("display:" + noneDiv);

	}

	function appendMessage(msg) {
		$("#chatMessageArea").append(msg + "<br>");
		var chatAreaHeight = $("#chatArea").height();
		var maxScroll = $("#chatMessageArea").height() - chatAreaHeight;
		$("#chatArea").scrollTop(maxScroll);
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
			send();
		});
		$('#enterBtn').click(function() {
			connect();
		});
		$('#exitBtn').click(function() {
			disconnect();
		});
	});
	
	$(document).ready(function() {
		$('button').click(function() {
			nowDiv = '#'+$(this).attr("id")+'Div';
			if ($(nowDiv).css("display") == "none") {
				$(nowDiv).css("display", "inline");
			} else {
				$(nowDiv).css("display", "none");
			}
			sendDiv(nowDiv);
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
</head>
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