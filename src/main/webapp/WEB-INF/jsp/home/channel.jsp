<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="../../js/jquery-3.6.0.js"></script>

<link href="../../css/egovframework/bootstrap.css" rel="stylesheet">
</head>
<style>
.listdiv {
	display: grid;
	grid-template-columns: 1fr 4fr 0.7fr;
	text-align: left;
	width: 380px;
	height: 80px;
	align-items: center;
	border-bottom: 1px solid #d3d3d3;
}
.listdivitem:nth-child(1) {
	grid-column: 1/2;
	grid-row: 1/3;
}

.listdivitem:nth-child(2) {
	grid-column: 2/3;
	grid-row: 1/3;
}

.listdivitem:nth-child(3) {
	grid-column: 3/4;
	grid-row: 1/3;
	margin-top: 25px;
}
ion-icon {
  font-size: 25px;
}

.thirddiv {
	display: grid;
	grid-template-columns: 1fr 1fr;
	grid-column-gap: 10px;
	margin-left: 50px;
	margin-top: 20px;
	margin-right: 100px;
}

.item:nth-child(1) {
	grid-column: 1/3;
	grid-row: 1/2;
	margin-bottom: 20px;
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
	height: 450px;
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

.modal-wrapper2 {
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

.modal-wrapper2.open {
	opacity: 1;
	visibility: visible;
}

.modal2 {
	width: 500px;
	height: 450px;
	display: block;
	margin: 50% 0 0 -255px;
	position: relative;
	top: 50%;
	left: 50%;
	background: #fff;
	opacity: 0;
	transition: all 0.5s ease-in-out;
}

.modal-wrapper2.open .modal2 {
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
	padding-top: 5%;
	padding-left: 10%;
	padding-right: 10%;
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

#chatArea {
	width: 400px;
	height: 100px;
	overflow-y: auto;
	border: 1px solid black;
}

#chatMessageArea {
	justify-content: center;
	align-content: center;
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
#createfriendslist{
	height: 230px;
	margin-bottom: 15px;
	overflow: auto;
	overflow-x: hidden;
	overflow: auto;
}
#selectaddfriends{
	height: 200px;
	margin-bottom: 5px;
	overflow: auto;
	overflow-x: hidden;
	overflow: auto;
}
.mydiv {
	border: 1px solid gray;
	height: 200px;
	margin-bottom: 5px;
	overflow: auto;
	overflow-x: hidden;
	overflow: auto;
}

ul.mylist li, ol.mylist li {
	padding: 5px 0px 5px 5px;
	margin-bottom: 5px;
	border-bottom: 1px solid #efefef;
	font-size: 12px;
}

ul.mylist2 li, ol.mylist2 li {
	padding: 5px 0px 5px 5px;
	margin-bottom: 5px;
	border-bottom: 1px solid #efefef;
	font-size: 12px;
}
.change_back {
	background-color: lightgray;
	color: white;
}
</style>

<body>
	<jsp:include page="Home.jsp" flush="true"></jsp:include>
	<div class="thirddiv">
		<div class="item">
			<h3>채널</h3>
		</div>

		<div class="item">
			<button class="btn btn-primary trigger">채널만들기+</button>
		</div>

		<div class="item">

			<ul class="list-group">
				<c:forEach var="namelist" items="${namelist}" varStatus="status">
					<div class="listdiv">
						<div class="listdivitem">
							<img width="40px" src="../../images/egovframework/profile/group2.png">
						</div>
						<div class="listdivitem">
							<li>${namelist}</li>
							
						</div>
						<div class="listdivitem">
							<button class="btn enterchbtn" value="${chlist[status.index].chNum}"  title="입장">
								<ion-icon name="log-in-outline"></ion-icon>
							</button>
						</div>
					</div>
				</c:forEach>
			</ul>
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

					<div class="form-group">
						<input id="channelname" type="email" class="form-control" placeholder="채널이름" /> <br>

						<div class="form-control" id="selectaddfriends">
							<!-- <nav> -->
							<ul class="mylist2">
							</ul>
							<!-- </nav> -->
						</div>

						<button class="btn trigger2" style="float: right;">친구추가＋</button>
						<br> <br>
						<button class="btn btn-primary trigger" id='createchannel'>만들기</button>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- Modal -->
	<div class="modal-wrapper2">
		<div class="modal2">
			<div class="head">
				<a class="btn-close trigger2" href="#"> <i class="fa fa-times" aria-hidden="true"></i>
				</a>
			</div>
			<div class="content">
				<div class="good-job">
					<i class="fa fa-thumbs-o-up" aria-hidden="true"></i>
					<div class="input-group col-md-12">
						<input name="nickname" type="text" class="form-control input-lg" id="searchInput" placeholder="닉네임으로 검색해주세요" /> <span class="input-group-btn">
							<button class="btn btn-info btn-lg" id="findbtn">
								<ion-icon name="search-outline"></ion-icon>
							</button>
						</span>
					</div>

					<br>
					<div class="form-control" id="createfriendslist">
						<!-- <nav> -->
						<ul class="mylist">
							<c:forEach var="friendlist" items="${friendslist}" varStatus="status">
								<li>${friendlist.friendNickname}&nbsp;(${friendlist.friendEmail})</li>
							</c:forEach>
						</ul>
						<!-- </nav> -->
					</div>
					<button class="btn btn-secondary" id="friendsaddbtn">
						<ion-icon name="add-outline"></ion-icon>
					</button>
					
					<br> <br>
				</div>
			</div>
		</div>
	</div>

</body>
<script type="text/javascript">
	$(document).ready(function() {
		localStorage.clear();
		$("#menupick").removeClass("active");
		$("#friendlist").removeClass("active");
		$("#findfriend").removeClass("active");
		$("#channel").addClass("active");

		$('.trigger').click(function() {
			$('.modal-wrapper').toggleClass('open');
			
			  setTimeout(function() {
	  				$('li').removeClass('change_back');
	  				$("#channelname").val('');
	  				$("#selectaddfriends").empty();
	  				localStorage.clear();
	  			}, 500);
		});

		$('.trigger2').click(function() {
			$('.modal-wrapper2').toggleClass('open');
			
		});

		$('ul.mylist li').click(function() {
			$(this).toggleClass('change_back');
			var temp = $(this).text();
			var sub = temp.substring(temp.indexOf("(") + 1, temp.indexOf(")"));
			console.log(sub);
			if (localStorage.getItem(sub) == null) {
				localStorage.setItem(sub, sub);
			} else if (localStorage.getItem(sub) != null) {
				localStorage.removeItem(sub);
			}

		});
		$('#friendsaddbtn').click(function() {
			$('.modal-wrapper2').toggleClass('open');
			var str = "";
			str += "<ul class='mylist'>";
			for(var i = 0; i < localStorage.length; i++){
				str += "<li>" + localStorage.getItem(localStorage.key(i)) + "</li>";
			}
			str += "</ul>";
			$("#selectaddfriends").empty();
			$("#selectaddfriends").append(str);
		});
		
		$(".enterchbtn").on('click', function() {
			 var chnum = $(this).attr("value");
			
					var link = '/enter/chat/'+chnum;
					location.href = link;
		});
		
		$('#createchannel').click(function() {
			
			var array = [];
			
			for(var i = 0; i < localStorage.length; i++){
				array.push(localStorage.getItem(localStorage.key(i)));
			}
			
			var objParams = {
					"channelname" : $('#channelname').val(),
					"selectlist" : array
			};
			
			$.ajax({
                url         :   "/createchannel",
                dataType    :   "json",
                contentType :   "application/x-www-form-urlencoded; charset=UTF-8",
                type        :   "post",
                data        :   objParams,
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
		});

	});
</script>
</html>