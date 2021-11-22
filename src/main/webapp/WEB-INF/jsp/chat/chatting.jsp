<%@page import="java.util.Random"%>
<%@ page contentType="text/html; charset=UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-Frame-Options" content="sameorigin" />
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
	width: 90%;
	height: 80px;
	overflow: auto;
	overflow-x: hidden;
	margin-bottom: 15px;
}
#resultBox{
	width: 200px;
	height: 35px;
	margin-bottom: 15px;
	text-align: center;
}
#chatArea {
	width: 100%;
	height: 400px;
	overflow: auto;
	overflow-x: hidden;
	
}
#sendBtn{
	width: 60px;
    height: 30px;
	font-size: 12px;
	margin-left : 1px;
	border-color: transparent !important;
	 white-space: nowrap;
}

.mydiv {
	display: grid;
	grid-template-columns: 3.5fr 1fr;
	grid-template-rows: 100px 460px 45px 250px;
	grid-column-gap: 10px;
	margin-left: 50px;
	margin-top: 20px;
	margin-right: 50px;
	width: 90%;
    min-width: 870px;
}

.item:nth-child(1) {
	margin-bottom : 40px;
	
}
.item:nth-child(3) {
	margin : 10px;
	overflow: auto;
	overflow-x: hidden;
	
}
.item:nth-child(4) {
	grid-row: 2/4;
	grid-column: 2/3;

}
.item:nth-child(7) {
	display: flex;
    flex-direction: column;
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
.boxDiv{
	display: flex;
	flex-direction: column;
	background-color: #f0f0f0;
	border-radius: 15px;
	margin: 10px;
	margin-right: 50px;
	align-items: center;
	padding: 20px;
}
#inputmenu{
	width: 200px;
}
.inputDiv{
	display: flex;
	justify-content: center;
	margin-right: 50px;
	margin-top: 15px;
}
#onlineDiv{
	margin-top:5px;
	height: 180px;
}
#delchannelbtn{
	font-size: 12px;
	margin-top: 10px;
	margin-left: auto;
}
.jbul{
	display: flex;
	list-style: none;
	flex-wrap: wrap;
}
.jbli {
	border-radius: 40px 80px / 80px 40px;
	background-color: #f5f5dc;
	font-size: 15px;
	padding: 5px;
	margin-bottom: 10px
}
.pickdel{
	margin-left: -6px;
	color: #cc0000 !important;
	margin-right: 5px;
	cursor: pointer;
}
</style>
<body>
	<jsp:include page="../home/Home.jsp" flush="true"></jsp:include>
	<div class="mydiv">
		<div class="item">
			<h3>채널</h3>
			<h6>${chname}&nbsp;
			<c:choose>
				<c:when test="${chtype eq '0'}"><span title="비공개방"><ion-icon name="lock-closed-outline"></ion-icon></span></c:when>
				<c:otherwise><span title="공개방"><ion-icon name="lock-open-outline"></ion-icon></span></c:otherwise>
			</c:choose>
			
			<c:if test=""></c:if>
			
			</h6>
			
		</div>

		<div class="item"></div>

		<div class="item">
			<div id="page-content-wrapper">
				<div class="container-fluid">
					
						<button class="btn btn-warning" id="korean">한식</button>
							<div class="col-md-5" id="koreanDiv" style="display: none;">
								<div id="koreanDiv"  style="display: inline">
								<c:forEach var="korean" items="${korean}" varStatus="status">
									<button class="btn btn-secondary foodbtn" style="margin: 2px;">${korean.foodName}</button>
								</c:forEach>
								</div>
							</div>
						<button class="btn btn-warning" id="bunsick">분식</button>
							<div class="col-md-5" id="bunsickDiv" style="display: none;">
								<c:forEach var="bunsick" items="${bunsick}" varStatus="status">
									<button class="btn btn-secondary foodbtn" style="margin: 2px;">${bunsick.foodName}</button>
								</c:forEach>
							</div>
						<button class="btn btn-warning" id="japan">일식</button>
							<div class="col-md-5" id="japanDiv" style="display: none;">
								<c:forEach var="japan" items="${japan}" varStatus="status">
									<button class="btn btn-secondary foodbtn" style="margin: 2px;">${japan.foodName}</button>
								</c:forEach>
							</div>
						<button class="btn btn-warning" id="asianweston">아시안·양식</button>
							<div class="col-md-5" id="asianwestonDiv" style="display: none;">
								<c:forEach var="asianweston" items="${asianweston}" varStatus="status">
									<button class="btn btn-secondary foodbtn" style="margin: 2px;">${asianweston.foodName}</button>
								</c:forEach>
							</div>
						<button class="btn btn-warning" id="china">중국집</button>
							<div class="col-md-5" id="chinaDiv" style="display: none;">
								<c:forEach var="china" items="${china}" varStatus="status">
									<button class="btn btn-secondary foodbtn" style="margin: 2px;">${china.foodName}</button>
								</c:forEach>
							</div>
						<button class="btn btn-warning" id="fastfood">패스트푸드</button>
							<div class="col-md-5" id="fastfoodDiv" style="display: none;">
								<c:forEach var="fastfood" items="${fastfood}" varStatus="status">
									<button class="btn btn-secondary foodbtn" style="margin: 2px;">${fastfood.foodName}</button>
								</c:forEach>
							</div>
						<button class="btn btn-warning" id="convenience">간편식</button>
							<div class="col-md-5" id="convenienceDiv" style="display: none;">
								<c:forEach var="convenience" items="${convenience}" varStatus="status">
									<button class="btn btn-secondary foodbtn" style="margin: 2px;">${convenience.foodName}</button>
								</c:forEach>
							</div>
					
						
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
			 <button class="btn btn-secondary" id="sendBtn" >전송</button>
			</div> <br>

		</div>
		<div class="item">
		<div class="inputDiv">
			<input class="form-control" id="inputmenu" placeholder="음식직접입력" onkeyup="if(window.event.keyCode==13){inputmenu()}"/>
			<button class="btn btn btn-secondary inputmenu" id="sendBtn">입력</button>
		</div>
		</div>
		<div class="item">
			<div class="boxDiv">
			<div id="pickBox">
				
				<ul class="jbul">
				<c:forEach  var="pickmenu" items="${pickmenu}" varStatus="status">
  					<li id='${pickmenu.foodName}' class="jbli">${pickmenu.foodName}</li>
					<a class="pickdel" name='${pickmenu.foodName}'><ion-icon name="close-outline"></ion-icon></a>
				</c:forEach>
  				
					</ul>

					
			</div>
			
			<span>오늘의 메뉴는?</span>
			<div class="form-control" id="resultBox">
				
			</div>
			
			<div class = "btn-group" role="group">
					<button class="btn btn-primary"  id="randomstart">랜덤뽑기</button>
					<button class="btn btn-info"  id="findplace">주변음식점찾기</button>
			</div>
			</div>
		</div>
		<div class="item">
		<span>온라인 친구</span>
		<div class="form-control" id="onlineDiv"></div>
				<c:set var = "roomNo" scope = "session" value = "${roomNo}"/>
					<c:forEach var="chcreater" items="${chcreater}" varStatus="status">
			 			<c:set var = "chcreaternum" scope = "session" value = "${chcreater.chNum}"/>
							<c:if test= "${chcreaternum eq roomNo}">
								<button class="btn btn-danger" id="delchannelbtn"  >채널삭제</button>
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
	
	$('.btn-warning').click(function(){
		
		var clicked = "#"+$(this).attr('id')+"Div";
		console.log(clicked);
		
		if($(clicked).css("display") == "none"){
			$(clicked).css("display", "inline");
			$(clicked).slideDown(2000);
		}
		else{
			$(clicked).css("display", "none");
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

function savepick(roomNo, pickid, del) {
		console.log(pickid);
		$.ajax({
            url         :   "/pickmenu",
            dataType    :   "json",
            contentType :   "application/x-www-form-urlencoded; charset=UTF-8",
            type        :   "post",
            data        :   {"pickid" : pickid,
            				 "roomNo" : roomNo,
            				 "del" : del},
            success     :   function(retVal){

                if(retVal.code == "OK") {
                  
                } else {
                 
                }
                 
            },
            error       :   function(request, status, error){
                console.log("AJAX_ERROR");
            }
        });
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
			
			client.subscribe('/subscribe/chat', function(chat) {

				alert("hi");
				
			});

		});

		function appendMessage(msg) {
			if(msg.ispick != ""){
				
				$(".jbul").append(msg.ispick);
				
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
			$('#resultBox').text(msg.result+"👀");
			$('#resultBox').css("background-color", "lightyellow");
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
			$('.pickdel').click(function() {
				savepick(roomNo, $(this).attr("name"), true);
				$(this).remove();
				$('#'+$(this).attr('name')).remove();
			})
			
			//메뉴 pick
			$('.foodbtn').click(function() {
				if($("#pickBox [id="+$(this).text()+"]").text() != ""){
					alert("중복된 메뉴입니다.");
				}
				else {
					ispick = "<li id='" + $(this).text()+"' class='jbli'>"+ $(this).text()+" </li><a class='pickdel'><ion-icon name='close-outline'></ion-icon></a>";
					pickid = $(this).text();
					sendmsg();
				}
				savepick(roomNo, pickid, false);
				setTimeout(function() {
					ispick = "";
	  			}, 500);
				
			});
			
			
			
			
			
			//랜덤뽑기
			$('#randomstart').click(function() {
				//$('.modal-wrapper').toggleClass('open');
				$('#resultBox').css("background-color", "transparent");
				var ele = document.getElementsByTagName('ul')[0];
				var eleCount = ele.childElementCount;
				var list = [];
				for(var i = 0; i < eleCount; i++){
					list.push($('.jbul').children().eq(i).attr('id'));
				}
				result = list[Math.floor(Math.random() * list.length)];
				
					for (var i = 0; i < eleCount; i++) {
						(function(x) {
							setTimeout(function() {
								console.log(x);
								$('#resultBox').text(list[x]);
									}, 90*x);
							})(i);
						}
					
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
			
			//메뉴 직접입력
			function inputmenu() {
				ispick = "<span id='" + $('#inputmenu').val()+"'>"+ $('#inputmenu').val()+" </span>";
				pickid = $('#inputmenu').text();
				sendmsg();
				$('#inputmenu').val('');
			setTimeout(function() {
					ispick = "";
				}, 500);
			}
			
			
			 $("#inputmenu").keyup(function(key) { 
				 if(key.keyCode==13) {
						inputmenu();
			        }
			});
			
			$('.inputmenu').click(function () {
				inputmenu();
			})
			 
			 
			
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