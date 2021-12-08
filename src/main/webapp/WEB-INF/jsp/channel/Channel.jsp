<%@page import="java.util.HashMap"%>
<%@page import="javax.annotation.Resource"%>
<%@page import="egovframework.mumukgang.cmmn.web.mapper.ChannelMapper"%>
<%@page import="java.util.Random"%>
<%@ page contentType="text/html; charset=UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-Frame-Options" content="sameorigin" />
<title>머먹GANG · ${chname}</title>
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
	margin-top: 220px;
	float: right;
}
#outbtn{
font-size: 12px;
	margin-top: 220px;
	float: right;
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
.btngroup{
	font-size: 14px;
}
.emoji{
	font-weight: 1 !important;
}
.foodbtn{
	margin: 2px;
}
.menu{
	margin: 2px;
}
.modal{
	height: 565px !important;
	top: 38% !important;
}
.modal2{
	top: 43.9% !important;
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
					
						<button class="btn btn-warning menu" id="korean"><span class="emoji">🍚 </span>한식</button>
							<div class="col-md-5" id="koreanDiv" style="display: none;">
								<button class="btn btn-dark menu" id="jjim" >찜</button>
									<div id="jjimDiv" class="col-md-5" style="display: none;">
										<c:forEach var="jjim" items="${jjim}" varStatus="status">
											<button class="btn btn-secondary foodbtn">${jjim.foodName}</button>
										</c:forEach>
									</div>
								<button class="btn btn-dark menu" id="guktang">국/탕</button>
									<div id="guktangDiv" class="col-md-5" style="display: none;" onclick="inline()">
										<c:forEach var="guktang" items="${guktang}" varStatus="status">
											<button class="btn btn-secondary foodbtn">${guktang.foodName}</button>
										</c:forEach>
									</div>
								<button class="btn btn-dark menu" id="jjigae">찌개</button>
									<div id="jjigaeDiv" class="col-md-5" style="display: none;" onclick="inline()">
										<c:forEach var="jjigae" items="${jjigae}" varStatus="status">
											<button class="btn btn-secondary foodbtn">${jjigae.foodName}</button>
										</c:forEach>
									</div>
								<button class="btn btn-dark menu" id="myeon">면</button>
									<div id="myeonDiv" class="col-md-5" style="display: none;" onclick="inline()">
										<c:forEach var="myeon" items="${myeon}" varStatus="status">
											<button class="btn btn-secondary foodbtn">${myeon.foodName}</button>
										</c:forEach>
									</div>
								<button class="btn btn-dark menu" id="haejang">해장</button>
									<div id="haejangDiv" class="col-md-5" style="display: none;" onclick="inline()">
										<c:forEach var="haejang" items="${haejang}" varStatus="status">
											<button class="btn btn-secondary foodbtn">${haejang.foodName}</button>
										</c:forEach>
									</div>
							</div>
									
							
						<button class="btn btn-warning menu" id="bunsick"><span class="emoji">🍤 </span>분식</button>
							<div class="col-md-5" id="bunsickDiv" style="display: none;">
								<c:forEach var="bunsick" items="${bunsick}" varStatus="status">
									<button class="btn btn-secondary foodbtn" style="margin: 2px;">${bunsick.foodName}</button>
								</c:forEach>
							</div>
						<button class="btn btn-warning menu" id="japan"><span class="emoji">🍣 </span>일식</button>
							<div class="col-md-5" id="japanDiv" style="display: none;">
								<c:forEach var="japan" items="${japan}" varStatus="status">
									<button class="btn btn-secondary foodbtn" style="margin: 2px;">${japan.foodName}</button>
								</c:forEach>
							</div>
						<button class="btn btn-warning menu" id="asianweston"><span class="emoji">🍝 </span>아시안·양식</button>
							<div class="col-md-5" id="asianwestonDiv" style="display: none;">
								<c:forEach var="asianweston" items="${asianweston}" varStatus="status">
									<button class="btn btn-secondary foodbtn" style="margin: 2px;">${asianweston.foodName}</button>
								</c:forEach>
							</div>
						<button class="btn btn-warning menu" id="china"><span class="emoji">🍜 </span>중국집</button>
							<div class="col-md-5" id="chinaDiv" style="display: none;">
								<c:forEach var="china" items="${china}" varStatus="status">
									<button class="btn btn-secondary foodbtn" style="margin: 2px;">${china.foodName}</button>
								</c:forEach>
							</div>
						<button class="btn btn-warning menu" id="fastfood"><span class="emoji">🍔 </span>패스트푸드</button>
							<div class="col-md-5" id="fastfoodDiv" style="display: none;">
								<c:forEach var="fastfood" items="${fastfood}" varStatus="status">
									<button class="btn btn-secondary foodbtn" style="margin: 2px;">${fastfood.foodName}</button>
								</c:forEach>
							</div>
						<button class="btn btn-warning menu" id="convenience"><span class="emoji">🥡 </span>간편식</button>
							<div class="col-md-5" id="convenienceDiv" style="display: none;">
								<c:forEach var="convenience" items="${convenience}" varStatus="status">
									<button class="btn btn-secondary foodbtn" style="margin: 2px;">${convenience.foodName}</button>
								</c:forEach>
							</div>
						<button class="btn btn-warning menu" id="dessert"><span class="emoji">🍰</span>카페·디저트</button>
							<div class="col-md-5" id="dessertDiv" style="display: none;">
								<button class="btn btn-dark menu" id="dstbrand" >프랜차이즈</button>
									<div id="dstbrandDiv" class="col-md-5" style="display: none;" onclick="inline()">
										<c:forEach var="dessertbrand" items="${dessertbrand}" varStatus="status">
											<button class="btn btn-secondary foodbtn">${dessertbrand.foodName}</button>
										</c:forEach>
									</div>
							 	<c:forEach var="dessert" items="${dessert}" varStatus="status">
									<button class="btn btn-secondary foodbtn" style="margin: 2px;">${dessert.foodName}</button>
								</c:forEach>
							 
							</div>
					
					
				</div>
			</div>
			
		</div>
		<div class="item">

			<div id="chatArea" class="form-control">
				<div id="chatMessageArea">
					<c:forEach  var="chatlist" items="${chatcontentlist}" varStatus="status">
						${chatlist.nickname}: ${chatlist.content}<br>
					</c:forEach>
				</div>
			</div>
			<br>
			<div class="inputdiv">
			 <input type="text" id="message" class="form-control"/>
			 <button class="btn btn-secondary" id="sendBtn" >전송</button>
			</div> <br>

		</div>
		<div class="item">
		<div class="inputDiv">
			<input class="form-control" id="inputmenu" placeholder="음식직접입력"/>
			<button class="btn btn btn-secondary inputmenu" id="sendBtn">입력</button>
		</div>
		</div>
		<div class="item">
			<div class="boxDiv">
			<div id="pickBox">
				
				<ul class="jbul">
				<c:forEach  var="pickmenu" items="${pickmenu}" varStatus="status">
  					<li id='${pickmenu.foodName}' class="jbli">${pickmenu.foodName}</li>
					<a class="pickdel" name='${pickmenu.foodName}' id='${pickmenu.foodName}a'><ion-icon name="close-outline"></ion-icon></a>
				</c:forEach>
  				
					</ul>

					
			</div>
			
			<span>오늘의 메뉴는?</span>
			<div class="form-control" id="resultBox"></div>
			
					<div class = "btn-group" role="group">	
						
						<button class="btn btn-info btngroup"  id="findplace">음식점찾기</button>
						<button class="btn btn-primary btngroup"  id="randomstart">랜덤뽑기</button>
						<button class="btn btn-secondary btngroup"  id="clearpick">목록비우기</button>
					</div>
					
			</div>
		</div>
		<div class="item">
	<!-- 	<span>온라인 친구</span>
		<div class="form-control" id="onlineDiv"></div> -->
				<c:set var = "roomNo" scope = "session" value = "${roomNo}"/>
					<c:forEach var="chcreater" items="${chcreater}" varStatus="status">
			 			<c:set var = "chcreaternum" scope = "session" value = "${chcreater.chNum}"/>
							<c:if test= "${chcreaternum eq roomNo}">
								<button class="btn btn-danger" id="delchannelbtn"  >채널삭제</button>
							</c:if>
					</c:forEach>
					<div id='outbtndiv'></div>
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
	
	$('.btn-warning, .btn-dark').click(function(){
		
		var clicked = "#"+$(this).attr('id')+"Div";
		
		if($(clicked).css("display") == "none"){
			$(clicked).css("display", "inline");
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

function savepick(roomNo, pickid, del, empty) {
	console.log('pickmenu');
		$.ajax({
            url         :   "/pickmenu",
            dataType    :   "json",
            contentType :   "application/x-www-form-urlencoded; charset=UTF-8",
            type        :   "post",
            data        :   {"pickid" : pickid,
            				 "roomNo" : roomNo,
            				 "del" : del,
            				 "empty" : empty},
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
		$("#chatArea").scrollTop($("#chatArea")[0].scrollHeight);
		var nickname = "<%=nickname%>";
		var roomNo = "${roomNo}";
		var ispick = "";
		var pickid = "";
		var result = "";
		var list = [];
		var agree = null;
		var empty = false;
		var del = false;
		
		var messageInput = $("#message").val();	
		var sock = new SockJS("${pageContext.request.contextPath}/endpoint");
		var client = Stomp.over(sock);
		
		client.connect({}, function() {
			//alert("connect");
			
			//메세지 들어오는곳 == 구독한 채팅 채널
			//roomNo는 채팅창 접속하는 url에 get방식의 값으로 연결해줌
			//ex)채팅url?roomNo=13 이면 jsp el태그로 ${roomNo}로 가져와서 사용
			
			client.subscribe('/subscribe/chat/' + roomNo, function(chat) {
				console.log("subscribe");
				//받은 데이터
				var content = JSON.parse(chat.body);
				console.log(content);
				if(content.agree != null){
					doagree(content);
				}
				else if(content.result != null){
					doresult(content);
				}
				else if (content.empty == true) {
					doempty();
				}
				else if (content.del == true){
					dodel();
				}
				else if (content.out == true){
					doout(content);
				}
				else{
					appendMessage(content);
				}
				
			});
			
		

		});

		function appendMessage(msg) {
			if(msg.ispick != ""){
				console.log("ispick");
				console.log(msg.pickid);
				if($("#pickBox [id="+msg.pickid+"]").text() != ""){
					console.log("test");
					$('#'+msg.pickid + "a").remove();
					$('#'+msg.pickid).remove();
				}
				else{
					$(".jbul").append(msg.ispick);
				}
			}
			else{
			$("#chatMessageArea").append(
					msg.memberId + ": " + msg.chatContent + "<br>");
			var chatAreaHeight = $("#chatArea").height();
			var maxScroll = $("#chatMessageArea").height() - chatAreaHeight;
			$("#chatArea").scrollTop(maxScroll);
			}
		}
		
		
		function doempty() {
			$('.jbul').empty();
			$('#resultBox').empty();
		}

		function doresult(msg) {
			//$('#resultBox').text(msg.result+"👀");
			$('#resultBox').css("background-color", "lightyellow");
			console.log(msg.result);
			for (var i = 0; i < msg.result.length; i++) {
				(function(x) {
					setTimeout(function() {
						$('#resultBox').text(msg.result[x]);
							}, 200*x);
					})(i);
			}
		}
		
		//나가기 메시지
		function doout(msg){
			$("#chatMessageArea").append(
					"<b>" + msg.memberId +  msg.chatContent +"</b><br>");
			var chatAreaHeight = $("#chatArea").height();
			var maxScroll = $("#chatMessageArea").height() - chatAreaHeight;
			$("#chatArea").scrollTop(maxScroll);
		}
		
		//채널 삭제
		function dodel() {
			alert("채널이 삭제되었습니다.");
			var link = "/channel";
            location.href = link;
		}
		
		//메세지 보내기 
		function sendmsg() {
			var message = $("#message").val();
			client.send('/app/hello/' + roomNo, {}, JSON.stringify({
				roomNo : roomNo,
				chatContent : message,
				ispick : ispick,
				pickid : pickid,
				memberId : nickname,
				empty : empty
			}));
			$("#message").val("");
		}
		
		//클릭한 메뉴 전송
		function sendpick() {
			client.send('/app/hello/' + roomNo, {}, JSON.stringify({
				ispick : ispick,
				pickid : pickid,
				memberId : nickname,
				empty : empty
			}));
		}
		
		//랜덤뽑기 결과 전송
		function sendresult() {
			client.send('/app/hello/' + roomNo, {}, JSON.stringify({
				result : list
			}));
		}
		
		//메세지 보내기 
		function sendout() {
			client.send('/app/hello/' + roomNo, {}, JSON.stringify({
				roomNo : roomNo,
				chatContent : "님이 채널에서 나가셨습니다.",
				memberId : nickname,
				out : true
			}));
		}
		
		//삭제 소켓 전송
		function senddel() {
			client.send('/app/hello/' + roomNo, {}, JSON.stringify({
				del : true
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
			
			//메뉴 del
			$(document).on('click', '.pickdel', function () {
				savepick(roomNo, $(this).attr("name"), true, false);
				$(this).remove();
				$('#'+$(this).attr('id')).remove();
				
				console.log($(this));
				console.log($(this).attr('name'));
				
				ispick = "<li id='" + $(this).text()+"' class='jbli'>"+ $(this).text()+" </li><a class='pickdel' name='"+$(this).text()+"' id='"+$(this).text()+"a'><ion-icon name='close-outline'></ion-icon></a>";
				pickid = $(this).attr("name");
				sendpick();
				
				setTimeout(function() {
					ispick = "";
	  			}, 500);
			})
			
			//메뉴 clear
			$('#clearpick').click(function() {
				$('.jbul').empty();
				$('#resultBox').empty();
				empty = true;
				sendpick();
				savepick(roomNo, null, false, true);
				empty = false;
			})
			
			//메뉴 pick
			$('.foodbtn').click(function() {
				if($("#pickBox [id="+$(this).text()+"]").text() != ""){
					alert("중복된 메뉴입니다.");
				}
				else {
					ispick = "<li id='" + $(this).text()+"' class='jbli'>"+ $(this).text()+" </li><a class='pickdel' name='"+$(this).text()+"' id='"+$(this).text()+"a'><ion-icon name='close-outline'></ion-icon></a>";
					pickid = $(this).text();
					sendpick();
					savepick(roomNo, pickid, false, false);
				}
				
				setTimeout(function() {
					ispick = "";
	  			}, 500);
				
			});
			
			
			//랜덤뽑기
			$('#randomstart').click(function() {
				//$('.modal-wrapper').toggleClass('open');
				list = [];
				//$('#resultBox').css("background-color", "transparent");
				var ele = document.getElementsByTagName('ul')[0];
				var eleCount = ele.childElementCount;
				eleCount = eleCount / 2;
				if(eleCount == 0){
					alert("먼저 메뉴를 골라주세요.");
				}
				else {
					for(var i = 0; i < eleCount; i++){
						//console.log($('.jbul').children('a').eq(i).attr('name'));
						list.push($('.jbul').children('a').eq(i).attr('name'));
					}
					
					result = list[Math.floor(Math.random() * list.length)];
					list.push(result + "😋");
						
					sendresult();
				}
				
				
			});
			
			$('#findplace').click(function() {
				console.log($('#resultBox').length);
				if ($('#resultBox').is(':empty')) {
					alert('먼저 랜덤뽑기를 해주세요.');
				} else{
					var latitude = sessionStorage.getItem("latitude");
					var longitude = sessionStorage.getItem("longitude");
					latitude = "35.1416772";
					longitude = "126.8357822";
					console.log(latitude, longitude);
					//if (latitude == null || longitude == null) {
					//	alert('위치찾기에 동의해주세요.');
					//	getLocation();
					//}else{
				$('.modal-wrapper').toggleClass('open');
				$.ajax({
				    url: "https://dapi.kakao.com/v2/local/search/keyword.json?y="+latitude+"&x="+longitude+"&radius=2000",
				    data: { query: $('#resultBox').text(), page: 1},
				    headers: { 'Authorization': 'KakaoAK c602ea38330a8ae2bae8e53d2d5bb2b1'},
				    type: 'GET'
				}).done(function(data) {
				    $('#findplacebox').empty();
				    console.log( data.documents);
				    if (data.documents.length == 0) {
				    	var str = "찾으시는 메뉴의 음식점이 없습니다.";
				    	
				    	 $('#findplacebox').append(str);
					} else{
				    for(var i = 0; i < data.documents.length; i++){
						var distance = data.documents[i].distance;
						
				    	var str = "";
				    	str += "<b>" + data.documents[i].place_name + "</b><br>";
				    	str += "<div style='font-size:14px; margin-top:10px; margin-bottom:10px;'>" + data.documents[i].category_group_name + "<br>";
				    	str += data.documents[i].address_name + "<img class='location' onclick='locationclick("+data.documents[i].x+", "+data.documents[i].y+")' title='위치보기' src='/images/egovframework/location.png'/>" + "<br>" ;
				    	if (distance > 999) {
							distance = distance / 1000;
							distance = distance.toFixed(1);
							str += "여기서부터 " + distance + "km<br></div>";
						} else{
							str += "여기서부터 " + distance + "m<br></div>";
						}
				    	
				    	str += "<a style='font-size:14px;' href=" + data.documents[i].place_url + " target='_blank' >자세히 보기</a><hr>";
				    	
				    	 $('#findplacebox').append(str);
				    	
					}
				    
					}
				});
			//	}
				}
			});
			
			//메뉴 직접입력
			function inputmenu() {
				if($("#pickBox [id="+$('#inputmenu').val()+"]").text() != ""){
					alert("중복된 메뉴입니다.");
				} else {
					ispick = "<li id='" + $('#inputmenu').val()+"' class='jbli'>"+ $('#inputmenu').val()+" </li><a class='pickdel' name='"+$('#inputmenu').val()+"' id='"+$('#inputmenu').val()+"a'><ion-icon name='close-outline'></ion-icon></a>";
					pickid = $('#inputmenu').val();
					sendpick();	
					savepick(roomNo, pickid, false, false);
				}
			
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
			
			
			//채널 나가기
			if(document.getElementById('delchannelbtn') == null){
				if('${chtype}' == 0){
					$('#outbtndiv').append("<button class='btn btn-danger' id='outbtn'  >채널나가기</button>");
				}
			}
			$(document).on('click', '#outbtn', function () {
				if (confirm("채널을 나가시겠습니까?")) {
					
					
					$.ajax({
		                url         :   "/outchannel",
		                dataType    :   "json",
		                contentType :   "application/x-www-form-urlencoded; charset=UTF-8",
		                type        :   "post",
		                data        :   {"roomNo" : roomNo},
		                success     :   function(retVal){

		                    if(retVal.code == "OK") {
		                    	sendout();
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
			})
			
			
			
			
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
	                        //alert(retVal.message);
	                        senddel(true);
	                        //var link = "/channel";
	                        //location.href = link;
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

	
	function getLocation() {
		  if (navigator.geolocation) { // GPS를 지원하면
		    navigator.geolocation.getCurrentPosition(function(position) {
		    	sessionStorage.setItem("latitude", position.coords.latitude);
		    	sessionStorage.setItem("longitude", position.coords.longitude);
		   
		    }, function(error) {
		      console.error(error);
		    }, {
		      enableHighAccuracy: false,
		      maximumAge: 0,
		      timeout: Infinity
		    });
		  } else {
		    alert('GPS를 지원하지 않습니다');
		  }
		}

	
</script>
</html>