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
	grid-template-columns: 1fr 1fr 1fr;
	grid-column-gap: 10px;
	margin-left: 50px;
	margin-top: 20px;
	margin-right: 100px;
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

#createfriendslist{
	height: 230px;
	margin-bottom: 15px;
	overflow: auto;
	overflow-x: hidden;
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
	cursor: pointer;
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

label {
    font: 1rem 'Fira Sans', sans-serif;
    margin-left: 4px;
    margin-bottom: 4px;
    margin-right: 4px;
}

#radio {
    margin-bottom: .4rem;
}
#chaddbtn{
	float: right;
	margin-left: 20%;
}

.item:nth-child(1) {
	grid-column: 1/4;
	margin-bottom: 20px;
}
.item:nth-child(2) {
	grid-column: 1/4;
}
.item:nth-child(3) {
	grid-column: 1/4;
}
.item:nth-child(4) {
	grid-column: 1/3;
}
.item:nth-child(5) {
	margin-top:20px;
	grid-column: 3/4;
}
.cardDiv {
	display: flex;
	flex-direction: row;
	align-items: center;
}
</style>

<body>
	<jsp:include page="Home.jsp" flush="true"></jsp:include>
	<div class="thirddiv">
		<div class="item">
			<h3>채널</h3>
		</div>

		<div class="item">
			<button class="btn btn-primary trigger" id="chaddbtn">채널만들기+</button>
		</div>

		<div class="item">
			<h6>내가 참여중인 채널</h6>
			<hr style="border: solid 5px #f89b00;">
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
		<div class="item">
		<h6>초대받은 채널</h6>
		<hr  style="border: solid 1px;">
			<c:forEach var="chinvited" items="${chinvited}" varStatus="status">
				<div class="card bg-light mb-3">
						 	<div class="card-header">${chinvited.chName}</div>
						 	<div class="card-body">
								<h6 class="card-title">${chinvited.nickname} </h6>
								<div class="cardDiv">
									<p class="card-text"><span style="font-size: 13px;">(${chinvited.reqEmail})</span> ${chinvited.requestTime}</p>	
						<div class = "btn-group" role="group" style="margin-left: 50px; margin-top: 5px;">
							<button class="btn btn-secondary acceptch" id="${chinvited.chNum}">
								<ion-icon name="checkmark-outline" style="color:green;"></ion-icon>
							</button>
							<button class="btn btn-secondary refusech" id="${chinvited.chNum}">
								<ion-icon name="close-outline" style="color:red;"></ion-icon>
							</button>
						</div>
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
				<a class="btn-close trigger" href="#"> <i class="fa fa-times" aria-hidden="true"></i>
				</a>

			</div>
			<div class="content">
				<div class="good-job">
					<i class="fa fa-thumbs-o-up" aria-hidden="true"></i>

					<div class="form-group">
						<div id="radio">
							<input type="radio" id="onlyfriend" value="onlyfriend" name="chtype" checked="checked"><label for="onlyfriend">비공개방(친구만 초대가능)</label>
							<input type="radio" id="public" value="public" name="chtype"><label for="public">공개방(모두 초대가능)</label>
						</div>
						<div id="regiondiv" style="display: none;">
							<select class="form-select form-select-sm" name="region" id="region">
   								<option value="">지역선택</option>
   								<option value="전체">전체</option>
   				 				<option value="경기">경기</option>
    			 				<option value="서울">서울</option>
    			 				<option value="인천">인천</option>
    			 				<option value="대전">대전</option>
    			 				<option value="대구">대구</option>
    			 				<option value="울산">울산</option>
    			 				<option value="부산">부산</option>
    			 				<option value="광주">광주</option>
    			 				<option value="강원">강원</option>
    			 				<option value="충남">충남</option>
    			 				<option value="충북">충북</option>
    			 				<option value="경북">경북</option>
    			 				<option value="경남">경남</option> 
    			 				<option value="전북">전북</option>
    			 				<option value="전남">전남</option> 
							</select>
						</div>
						<input id="channelname" type="email" class="form-control" placeholder="채널이름" /> <br>

						<div class="form-control" id="selectaddfriends">
							<!-- <nav> -->
							<ul class="mylist2">
							</ul>
							<!-- </nav> -->
						</div>
						
								<button class="btn trigger2" id="addfriend" style="float: right;">친구추가＋</button>
						
						<br> <br>
						<button class="btn btn-primary" id='createchannel'>만들기</button>
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

//채널 수락여부 ajax
function chreqaon(AorN, chnum) {
	$.ajax({
        url         :   "/chreqaon",
        dataType    :   "json",
        contentType :   "application/x-www-form-urlencoded; charset=UTF-8",
        type        :   "post",
        data        :   {"chnum" : chnum,
        				"acceptornot" : AorN
        	},
        success     :   function(retVal){
            if(retVal.code == "NO") {  
            	alert(retVal.message);
            }
            var link = "/channel";
            location.href = link;
        },
        error       :   function(request, status, error){
            console.log("AJAX_ERROR");
        }
    });
}
	$(document).ready(function() {
		localStorage.clear();
		$("#findchannel").removeClass("active");
		$("#friendlist").removeClass("active");
		$("#findfriend").removeClass("active");
		$("#channel").addClass("active");
		
		var chtype = false;
		var chregion = "";
		
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
		
		//공개, 비공개
		$('#onlyfriend, #public').click(function() {
			$("input[name='chtype']:checked").each(function(){	
				if ($(this).val() == "onlyfriend") {
					chtype = false;
					$('#regiondiv').css('display', 'none');
				}else{
					chtype = true;
					$('#regiondiv').css('display', 'inline');
				}
			});
			
		});
		
		$('.form-select-sm').change(function (){
			chregion = $('#region option:selected').text();
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
		
		//채널 수락여부
		$(".acceptch").click(function() {
			if (confirm("채널에 참가하시겠습니까?")) {
				chreqaon(true, $(this).attr("id"));
			}
		});
		$(".refusech").click(function() {
			if (confirm("채널을 거절하시겠습니까?")) {
				chreqaon(false, $(this).attr("id"));
			}
		});
		
		
		
		$('#createchannel').click(function() {
			if ($('#channelname').val() == "") {
				alert("채널 이름을 입력해주세요.");
			}
			else {
				
			
			var array = new Array();
			
			for(var i = 0; i < localStorage.length; i++){
				array.push(localStorage.getItem(localStorage.key(i)));
			}
			
			
			var objParams = {
					"channelname" : $('#channelname').val(),
					"chtype" : chtype,
					"chregion" : chregion,
					"selectlist" : array
			};
			console.log(objParams);

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
			$('.modal-wrapper2').toggleClass('open');
			}
		});

	});
</script>
</html>