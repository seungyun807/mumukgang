<%@page import="java.util.Random"%>
<%@ page contentType="text/html; charset=UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
	String roomNo = request.getAttribute("roomNo").toString();
	int agreecount = 0;
	session.setAttribute(roomNo, 0);
%>
<style>
#pickBox{
	width: 80%;
	height: 80%;
		overflow: auto;
	overflow-x: hidden;
}
#resultBox{
	width: 80%;
	height: 30%;
	margin: 5px;
}
#chatArea {
	width: 100%;
	height: 80%;
	overflow: auto;
	overflow-x: hidden;
	
}
#sendBtn{
	width: 32px;
    height: 32px;
}

.mydiv {
	display: grid;
	grid-template-columns: 3.5fr 1fr;
	grid-template-rows: 100px 500px 100px;
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
	overflow: auto;
	overflow-x: hidden;
	
}
.item:nth-child(5) {
	align-items: center;
    justify-content: center;
	
}
input{
	width: 80%;
	height: 30px;
}
.inputdiv{
	display: flex;
}
.pickdiv {white-space: nowrap;}
.location{
	width: 15px;
 	cursor: pointer;
	margin-left: 6px;
	margin-bottom: 3px;
}
</style>
<body>
	<jsp:include page="../home/Home.jsp" flush="true"></jsp:include>
	<div class="mydiv">
		<div class="item">
			<h3>채널</h3>
			<h6>${chname}</h6>
		</div>

		<div class="item"></div>

		<div class="item">
			<div id="page-content-wrapper">
				<div class="container-fluid">
					<div class="col-md-5" id="noneDiv" style="display: none;">
						<button class="btn btn-secondary">숨은버튼</button>
					</div>
					<c:forEach var="foodlist" items="${foodlist}" varStatus="status">
								
							
						<button class="btn btn-secondary foodbtn" id="onDisplay" style="margin: 2px;">${foodlist.foodName}</button>
					</c:forEach>
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
			</div>
			<div class="form-control" id="resultBox">
				
			</div>
			<button class="btn btn-primary"  id="randomstart">랜덤뽑기</button>
			<button class="btn btn-info"  id="findplace">주변음식점찾기</button>
		</div>
		<div class="item">
				<c:set var = "roomNo" scope = "session" value = "${roomNo}"/>
					<c:forEach var="chcreater" items="${chcreater}" varStatus="status">
			 			<c:set var = "chcreaternum" scope = "session" value = "${chcreater.chNum}"/>
							<c:if test= "${chcreaternum eq roomNo}">
								<button class="btn btn-primary" id="delchannelbtn" >채널삭제</button>
							</c:if>
					</c:forEach>
			
		</div>
	</div>
	
	<!-- Modal -->
	<div class="modal-wrapper">
		<div class="modal">
			<div class="head">
				<a class="btn-close trigger" href="#"> <i class="fa fa-times" aria-hidden="true"></i>
				</a>

			</div>
			<div class="content">
				<div class="good-job">
					<i class="fa fa-thumbs-o-up" aria-hidden="true"></i>

					<div class="form-group" id="findplacebox">
						
						
					</div>
				</div>
				
			</div>
		</div>
	</div>
	
	<!-- Modal2 -->
	<div class="modal-wrapper2">
		<div class="modal2">
			<div class="head">
				<a class="btn-close trigger2" href="#"> <i class="fa fa-times" aria-hidden="true"></i>
				</a>
			</div>
			
					<i class="fa fa-thumbs-o-up" aria-hidden="true"></i>
					<div id="map" style="width:500px;height:400px;"></div>
				
	
		</div>
	</div>
	
</body>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=2eebb72cbf45a61d75d2efc7638259a2"></script>
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
	


	
	$('.trigger2').on('click', function() {
		$('.modal-wrapper2').toggleClass('open');
	});
	
});
function locationclick(x, y) {
	$('.modal-wrapper2').toggleClass('open');
	console.log(x);
	console.log(y);
	var mapContainer = document.getElementById('map'),
    mapOption = { 
        center: new kakao.maps.LatLng(y, x), 
        level: 3 
    };

	var map = new kakao.maps.Map(mapContainer, mapOption); 


	var markerPosition  = new kakao.maps.LatLng(y, x); 
	var marker = new kakao.maps.Marker({
    	position: markerPosition
	});

	marker.setMap(map);
		
}
	$(function() {
		$("#findchannel").removeClass("active");
		$("#friendlist").removeClass("active");
		$("#findfriend").removeClass("active");
		$("#channel").addClass("active");
		var nickname = "<%=nickname%>";
		var roomNo = "${roomNo}";
		var ispick = "";
		var pickid = "";
		var result = "";
		var agree = null;

		
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
				if(content.agree != null){
					doagree(content);
				}
				else if(content.result != null){
					doresult(content);
				}
				else{
					appendMessage(content);
				}
				
			});

		});

		function appendMessage(msg) {
			if(msg.ispick != ""){
				
				$("#pickBox").append(msg.ispick);
				//ispick = "";
			}
			else{
			$("#chatMessageArea").append(
					msg.memberId + ": " + msg.chatContent + "<br>");
			var chatAreaHeight = $("#chatArea").height();
			var maxScroll = $("#chatMessageArea").height() - chatAreaHeight;
			$("#chatArea").scrollTop(maxScroll);
			}
		}
		
		function doagree(msg) {
			$('.modal-wrapper').toggleClass('open');
			var str = "";
			str += "<br>";
			str += msg.memberId;
			str += "님이 랜덤뽑기를 진행하고자 합니다.";
			str += "<br>";
			str += "<br>";
			str += "동의하십니까?";
			str += "<button class='btn btn-primary' id='agree' onclick='agree()'>예</button>&nbsp;<button class='btn btn-secondary' id='disagree'>아니요</button>";
			
			$("#str").empty();
			$("#str").append(str);
		}

		function doresult(msg) {
			$('#resultBox').text(msg.result);
		}
		function sendmsg() {
			var message = $("#message").val();
			client.send('/app/hello/' + roomNo, {}, JSON.stringify({
				chatContent : message,
				ispick : ispick,
				pickid : pickid,
				memberId : nickname

			}));
			$("#message").val("");
		}
		
		function sendagree() {
			client.send('/app/hello/' + roomNo, {}, JSON.stringify({
				agree : agree,
				memberId : nickname
			}));
		}
		
		function sendresult() {
			client.send('/app/hello/' + roomNo, {}, JSON.stringify({
				result : result
			}));
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
			$('.foodbtn').click(function() {
				if($("#pickBox [id="+$(this).text()+"]").text() != ""){
					alert("중복된 메뉴입니다.");
				}
				else {
					ispick = "<span id='" + $(this).text()+"'>"+ $(this).text()+" </span>";
					pickid = $(this).text();
					sendmsg();
				}
				
				setTimeout(function() {
					ispick = "";
	  			}, 500);
				
			});
			
			$('#randomstart').click(function() {
				//$('.modal-wrapper').toggleClass('open');
				var ele = document.getElementById('pickBox');
				var eleCount = ele.childElementCount;
				var list = [];
				for(var i = 0; i < eleCount; i++){
					list.push($('#pickBox').children().eq(i).attr('id'));
				}
				result = list[Math.floor(Math.random() * list.length)];
				sendresult();
				
			});
			
			$('#findplace').click(function() {
				$('.modal-wrapper').toggleClass('open');
				console.log( $('#resultBox').text());
				$.ajax({
				    url: 'https://dapi.kakao.com/v2/local/search/keyword.json?y=35.142432279851256&x=126.83601844546476&radius=2000',
				    data: { query: $('#resultBox').text(), page: 1},
				    headers: { 'Authorization': 'KakaoAK c602ea38330a8ae2bae8e53d2d5bb2b1'},
				    type: 'GET'
				}).done(function(data) {
					 console.log(data);
					console.log(data.documents);
				    console.log(data.documents[0].address_name);
				    console.log(data.documents.length);
				    $('#findplacebox').empty();
				    for(var i = 0; i < data.documents.length; i++){
				    	
				    	var str = "";
				    	str += data.documents[i].place_name + "<br>";
				    	str += data.documents[i].address_name + "<img class='location' onclick='locationclick("+data.documents[i].x+", "+data.documents[i].y+")' title='위치보기' src='/images/egovframework/location.png'/>" + "<br>" ;
				    	str += data.documents[i].category_name + "<br>";
				    	str += data.documents[i].phone + "<br><br>";
				    	
				    	 $('#findplacebox').append(str);
				    	
					}
				    
				   
				});
			});
			
		
			
			$('.trigger').click(function() {
				$('.modal-wrapper').toggleClass('open');
			});
			
			
			
			// 동의 투표 송신
			$('#doagree').click(function() {
					agree = "1";
					sendagree();
					$('.modal-wrapper').toggleClass('open');
			});
			
			
			$('#delchannelbtn').click(function() {
				if (confirm("채널을 삭제하시겠습니까?")) {
					
				
				$.ajax({
	                url         :   "/deletechannel",
	                dataType    :   "json",
	                contentType :   "application/x-www-form-urlencoded; charset=UTF-8",
	                type        :   "post",
	                data        :   {"roomNo" : roomNo},
	                success     :   function(retVal){

	                    if(retVal.code == "OK") {
	                        alert(retVal.message);
	                        var link = "/channel";
	                        location.href = link;
	                    } else {
	                        alert(retVal.message);
	                    }
	                     
	                },
	                error       :   function(request, status, error){
	                    console.log("AJAX_ERROR");
	                }
	            });
				}
			});
			
		});

	});
	//수신자 동의
	function agree() {
			alert("수신자동의");
		<%
		session.setAttribute("roomNo", ++agreecount);
		%>
		
		var agreecount = "<%=session.getAttribute("roomNo")%>";

		alert(agreecount);
		if (agreecount == "${countchmem}" ) {
			alert("모두동의");
		}
		$('.modal-wrapper').toggleClass('open');
		
		
	}
	


	
</script>
</html>