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
	grid-column-gap: 10px;
	margin-left: 50px;
	margin-top: 20px;
	margin-right: 100px;
}

.item {
	margin-bottom: 20px;
}

.card-body {
	display: flex;
	flex-direction: row;
	align-items: center;
}

#custom-search-input {
	padding: 3px;
	border: solid 1px #E4E4E4;
	border-radius: 6px;
	background-color: #fff;
}

#custom-search-input input {
	border: 0;
	box-shadow: none;
}

#custom-search-input button {
	margin: 2px 0 0 0;
	background: none;
	box-shadow: none;
	border: 0;
	color: #666666;
	padding: 0 8px 0 10px;
	border-left: solid 1px #ccc;
}

#custom-search-input button:hover {
	border: 0;
	box-shadow: none;
	border-left: solid 1px #ccc;
}

#custom-search-input .glyphicon-search {
	font-size: 23px;
}

/*-- POPUP --*/
.modal-wrapper {
	width: 100%;
	height: 100%;
	position: fixed;
	top: 0;
	left: 0;
	background: rgba(128, 128, 128, 0.8);
	visibility: hidden;
	opacity: 0;
	transition: all 0.25s ease-in-out;
}

.modal-wrapper.open {
	opacity: 1;
	visibility: visible;
}

.modal {
	width: 600px;
	height: 400px;
	display: block;
	margin: 50% 0 0 -300px;
	position: relative;
	top: 50%;
	left: 50%;
	background: #fff;
	opacity: 0;
	transition: all 0.5s ease-in-out;
}

.modal-wrapper.open .modal {
	margin-top: -200px;
	opacity: 1;
}

.head {
	width: 100%;
	height: 50px;
	padding: 12px 30px;
	overflow: hidden;
	background: #f89b00;
}

.btn-close {
	font-size: 20px;
	display: block;
	float: right;
	color: #fff;
}

.content {
	padding: 10%;
}

.good-job {
	text-align: center;
	font-family: 'Montserrat', Arial, Helvetica, sans-serif;
	color: black;
}

.good-job .fa-thumbs-o-up {
	font-size: 60px;
}

.good-job h1 {
	font-size: 45px;
}
</style>
<body>
	<jsp:include page="Home.jsp" flush="true"></jsp:include>


	<div class="thirddiv">
		<div class="item">
			<h3>친구찾기</h3>
		</div>
		<div class="item">

			<div class="item">

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

		</div>

		<div class="item">
			<h3>친구요청</h3>
		</div>

		<div class="item">
			<c:forEach var="resfriend" items="${resfriends}" varStatus="status">
				<div class="card text-white bg-info mb-3" style="max-width: 20rem; height: 100px;">
					<div class="card-body">
						<div>
							<p class="card-title">${resfriend.reqNickname}</p>
							<p class="card-text">${resfriend.reqEmail}</p>
						</div>
						<div style="margin-left: 50px; margin-top: 5px;">
							<button class="btn btn-secondary acceptfriend" id="${resfriend.index}">
								<ion-icon name="person-add-outline"></ion-icon>
							</button>
						</div>
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
		$
				.ajax({
					type : 'post',
					data : {
						"nickname" : $("#searchInput").val()
					},
					url : "/findfriendsdo",
					success : function(returnData, status) {
						console.log(returnData);
						if (status == "success") {
							if (returnData.nickname != null) {
								console.log(returnData.email);
								console.log(returnData.nickname);

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
							} else {
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
					}
				});
		$('.modal-wrapper').toggleClass('open');
	}

	$(document).ready(function() {
		$("#menupick").removeClass("active");
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

		$('.acceptfriend').on('click', function() {
			var acceptId = $(this).attr("id");
			$.ajax({
				type : 'post',
				data : {
					"index" : acceptId
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
		});

	});
</script>
</html>