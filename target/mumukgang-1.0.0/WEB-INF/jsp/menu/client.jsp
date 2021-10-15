<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<script>

	var ws;
	
	$(document).ready(function(){
		$("#enterBtn").click(function(){
			ws = new WebSocket("ws://localhost/ws");
		
			ws.onerror = onError;
			ws.onmessage = onMessage;
			ws.onopen = onOpen;
			ws.onclose = onClose;
		});
		
		$("#exitBtn").click(function(){
			ws.close();
		});
		
		$("#sendBtn").click(function(){
			sendMessage();
		});
	});
	
	function sendMessage(){
		ws.send(
				$("#message").val()
			);
	}
	
	function onMessage(event){
		var data = event.data;
		$("#data").append(data + "<br>");
	}
	
	function onOpen(event){
		$("#data").append("클라측 onOpen() : Connection Opened!<br>");
	}
	
	function onClose(event){
		$("#data").append("클라측 onClose() : Connection Closed!<br>");
	}
	
	function onError(event){
		$("#data").append("클라측 onError() : Connection error!<br>");
	}
	

</script>

<input type="button" id="enterBtn" value="ENTER"/>
<input type="button" id="exitBtn" value="EXIT"/>
<p>
session ID : <input type="text" id="sessionid" value="" size="50"/>
<p>
<input type="text" id="message" size="50"/>
<input type="button" id="sendBtn" value="SEND"/>
<div id="data"></div>
</body>
</html>