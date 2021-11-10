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

ion-icon {
  font-size: 20px;
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
	margin-bottom: 40px;
}

.item:nth-child(4) {
	grid-column: 1/3;
	margin-top: 40px;
}
.listdiv {
	display: grid;
	grid-template-columns: 55px 1fr 55px ;
	text-align: left;
	width: 80%;
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
#sptext{
	font-size: 13px;
	text-align: right;
	margin-right: 20%;
}
</style>
<body>
	<jsp:include page="Home.jsp" flush="true"></jsp:include>


	<div class="thirddiv">
		<div class="item">
			<h3>채널찾기</h3>
		</div>

		<div class="item">
		<form action="/searchch" method="post">
			<div id="custom-search-input">
					<div class="input-group col-md-12">
					
						<input name="findchannel" type="text" class="form-control input-lg" id="searchInput" placeholder="채널제목을 검색해주세요." onkeyup="if(window.event.keyCode==13){searchch()}" /> <span class="input-group-btn">
							<button class="btn btn-info btn-lg" id="findbtn">
								<ion-icon name="search-outline"></ion-icon>
							</button>
						</span>
					
					</div>
				</div>
				</form>
		</div>
		<div class="item"></div>
		<div class="item">
		<div id="sptext">
			<span >이곳은 공개 채널로 모든 유저가 입장할 수 있습니다.</span>
		</div>
		
		<ul class="list-group">
			<c:forEach var="chlist" items="${chlist}" varStatus="status">
					<div class="listdiv">
						<div class="listdivitem">
							<img width="40px" src="../../images/egovframework/profile/group2.png">
						</div>
						<div class="listdivitem">
							<li>${chlist.chName} </li>
						</div>
						<div class="listdivitem">
							<button class="btn enterchbtn" value="${chlist.chNum}" title="입장">
								<ion-icon name="log-in-outline"></ion-icon>
							</button>
						</div>
					</div>
				</c:forEach>
				</ul>
		</div>
	</div>
</body>
<script type="text/javascript">
	$(document).ready(function() {
		$("#findchannel").addClass("active");
		$("#friendlist").removeClass("active");
		$("#findfriend").removeClass("active");
		$("#channel").removeClass("active");
		
		$(".enterchbtn").on('click', function() {
			
			 var chnum = $(this).attr("value");
			
					var link = '/enter/chat/'+chnum;
					location.href = link;
		});
		
		//$('#findbtn').click(function (){
		//	searchch();
		//});
	});
	/*
	function searchch(){
		var objParams = {
				"keyword" : $('#searchInput').val()
		};
		$.get({
            url         :   "/searchch",
           
            type        :   "GET",
            data        :   objParams,
            success     :   function(data){

                if(data) {
                	location.href = data;
                	//location.replace = data;
                    alert(data);
                    
                } else {
                    alert(retVal.message);
                }
                 
            },
            error       :   function(request, status, error){
                console.log("AJAX_ERROR");
            }
        });
	}*/
</script>
</html>