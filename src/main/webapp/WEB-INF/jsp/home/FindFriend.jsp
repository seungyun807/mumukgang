<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="../../js/jquery-3.6.0.js"></script>

<link href="../../css/egovframework/bootstrap.css" rel="stylesheet">
</head>


<style>
.thirddiv {
	display: grid;
	grid-template-columns: 1fr 1fr;
	grid-column-gap: 10px;
	margin-left: 50px;
	margin-top: 20px;
	margin-right: 100px;
}

.itemflex:nth-child(1) {
	flex-grow: 1;
	text-align: right;
	/* flex-grow: 0; */ /* 기본값 */
}
.card-body {
	display: flex;
	flex-direction: row;
	align-items: center;
}
.item:nth-child(1) {
	grid-column: 1/3;
} 
.item:nth-child(2) {
	grid-column: 1/3;
	margin-bottom: 50px;
} 

.item:nth-child(3) {
	
} 

</style>
<body>
	<jsp:include page="Home.jsp" flush="true"></jsp:include>


	<div class="thirddiv">
		<div class="item">
			<h3>친구찾기</h3>
		</div>
		<div class="item">
			<hr>
				<div id="custom-search-input">
					<div class="input-group col-md-12">
						<input name="nickname" type="text" class="form-control input-lg" id="searchInput" placeholder="닉네임으로 검색해주세요" onkeyup="if(window.event.keyCode==13){findfriends()}" /> <span class="input-group-btn">
							<button class="btn btn-info btn-lg" id="findbtn">
								<ion-icon name="search-outline"></ion-icon>
							</button>
						</span>
					</div>

			</div>

		</div>

		<div class="item">
		<h6>받은 친구요청</h6>
			<hr>
			<c:forEach var="resfriend" items="${resfriends}" varStatus="status">
				<div class="card card bg-light mb-3" style="height: 100px; max-width: 383px;">
					<div class="card-body">
						<div>
							<p class="card-title">${resfriend.reqNickname}</p>
							<p class="card-text" style="font-size: 13px">(${resfriend.reqEmail})</p>
						</div>
						<br>
							<div class = "btn-group" role="group" style="margin-left: 45px; margin-top: 5px;">
								<button class="btn btn-secondary acceptfriend" id="${resfriend.index}">
									<ion-icon name="checkmark-outline" style="color:green;"></ion-icon>
								</button>
								<button class="btn btn-secondary refusefriend" id="${resfriend.index}">
									<ion-icon name="close-outline" style="color:red;"></ion-icon>
								</button>
						</div>
					</div>
				</div>
			</c:forEach>
		</div>

		<div class="item">
			<h6>요청한 친구</h6>
			<hr>
			<c:forEach var="reqfriends" items="${reqfriends}" varStatus="status">
				<div class="card card bg-light mb-3" style="height: 100px; max-width: 383px;">
					<div class="card-body">
						<div>
							<p class="card-title">${reqfriends.resNickname}</p>
							<p class="card-text" style="font-size: 13px">(${reqfriends.resEmail})</p>
						</div>
						<br>
								<button class="btn btn-secondary cancelreq" id="${reqfriends.index}" style="margin-left: 90px; margin-top: 5px;">
									<ion-icon name="close-outline" style="color:red;"></ion-icon>
								</button>
					</div>
				</div>
			</c:forEach>
			
		</div>
	</div>


	<!-- Modal -->
	<div class="modal-wrapper">
		<div class="modal">
			<div class="head">
				<a class="btn-close trigger" href="#" id="modalclose"> <i class="fa fa-times" aria-hidden="true"></i>
				</a>
			</div>
			<div class="content">
				<div class="good-job">
					<i class="fa fa-thumbs-o-up" aria-hidden="true"></i>
					<div class="item" id="test">친구를 찾을수 없습니다.</div>
				</div>
			</div>
		</div>
	</div>

</body>
<script type="text/javascript">
	function findfriends() {
		console.log($("#searchInput").val());
		$.ajax({
					type : 'post',
					data : {
						"nickname" : $("#searchInput").val()
					},
					url : "/findfriendsdo",
					success : function(returnData, status) {
						console.log(returnData);
						if (status == "success") {
							if (returnData.nickname != null) {
								console.log(returnData);

								var str = "";
								str += returnData.email;
								str += "<br>";
								str += returnData.nickname;
								str += "<br>";
								str += "<input name='res_email' type='hidden' value='"+returnData.email+"' id='res_email'/>";
								str += "<input name='res_nickname' type='hidden' value='"+returnData.nickname+"' id='res_nickname'/>";
								str += "<button class='btn btn-primary' id='requestbtn'>친구요청</button>";
								$("#test").empty();
								$("#test").append(str);
							} else if( returnData == null) {
								var str = "친구를 찾을수 없습니다.";
								$("#test").empty();
								$("#test").append(str);
								//$('.modal-wrapper').toggleClass('open');
							}
						} else {
							alert("ERROR!" + error);
							return;
						}
						$("#requestbtn").on('click', function() {
							$.ajax({
								type : 'post',
								data : {
									"res_email" : $("#res_email").val(),
									"res_nickname" : $("#res_nickname").val()
								},
								url : "/requestfriends",
								dataType : "text",
								success : function(returnData, status) {
									var temp = returnData.substring(1, 3);
									if (temp == "성공") {
										alert("친구요청을 하였습니다.");
										var link = "/findfriends";
										location.href = link;

									}
									else{
										alert(returnData);
										
									}

								}
							});
						});
						$('.modal-wrapper').toggleClass('open');
					}
					
				});
	}

	$(document).ready(function() {
		$("#findchannel").removeClass("active");
		$("#friendlist").removeClass("active");
		$("#findfriend").addClass("active");
		$("#channel").removeClass("active");

		$('.trigger').click(function() {
			$('.modal-wrapper').toggleClass('open');
			var str = "";
			str += "친구를 찾을수 없습니다.";
			setTimeout(function() {
				$("#test").empty();
				$("#test").append(str);
			}, 500);

		});

		$("#findbtn").on('click', function() {
			findfriends();
		});

		$('.acceptfriend, .refusefriend, .cancelreq').on('click', function() {
			var acceptId = $(this).attr("id");
			var state = $(this).attr("class").substr(18, 1);
			var msg = "";
			var refuse = false;
			console.log(state);
			if (state.includes("a")) {
				msg = "친구요청을 수락하시겠습니까?"
			} else if (state.includes("r")) {
				msg = "친구요청을 거절하시겠습니까?"
				refuse = true;
			} else {
				msg = "친구요청을 취소하시겠습니까?"
				refuse = true;
			}
			if(confirm(msg)){
			$.ajax({
				type : 'post',
				data : {
					"index" : acceptId,
					"refuse" : refuse
				},
				url : "/acceptfriends",
				success : function(returnData, status) {
					console.log(returnData);
					if (status == "success") {
						if (returnData) {

						} else {

						}
					} else {
						alert("ERROR!" + error);
						return;
					}
					
				}

			})
			var link = '/findfriends';
			location.href = link;
		}
			
		});
		
	});
</script>
</html>