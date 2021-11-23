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

.form-select-sm{
	width: 140px;
    margin: 7px;
    margin-left: 30%;
    margin-right: 40%;
    float: right;
}
</style>
<body>
	<jsp:include page="Home.jsp" flush="true"></jsp:include>


	<div class="thirddiv">
		<div class="item">
			<h3>채널찾기</h3>
					<hr>
		</div>

		<div class="item">
		<form action="/findchannel" method="post">
			<div id="custom-search-input">
					<div class="input-group col-md-12">
						<input type="hidden" id="searchRegion" name="region" value=""/>
						<input name="findchannel" type="text" class="form-control input-lg" id="searchInput" placeholder="채널제목을 검색해주세요." onkeyup="if(window.event.keyCode==13){searchch()}" /> <span class="input-group-btn">
							<button class="btn btn-info btn-lg" id="findbtn">
								<ion-icon name="search-outline"></ion-icon>
							</button>
						</span>
						
					
					</div>
				</div>
				</form>
		</div>
		<div class="item">
		<form action="/findchannel" method="post">
			<select class="form-select form-select-sm" name="region" id="region" onchange="this.form.submit()">
   				 <option value="지역선택" selected="selected">지역선택</option>
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
		</form>
		</div>
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
<script src="../../js/jquery_cookie.js"></script>
<script type="text/javascript">
	$(document).ready(function() {
		$("#findchannel").addClass("active");
		$("#friendlist").removeClass("active");
		$("#findfriend").removeClass("active");
		$("#channel").removeClass("active");
		
		$("#region").val($.cookie('selectRegion')).prop("selected", true);
		$('#searchRegion').attr('value', $.cookie('selectRegion'));
		
		$(".enterchbtn").on('click', function() {
			
			 var chnum = $(this).attr("value");
				
					var link = '/enter/chat/'+chnum;
					location.href = link;
		});
		
		$('.form-select-sm').change(function (){
		
			$('#searchRegion').attr('value', $('#region option:selected').text());
			
			$.cookie('selectRegion', $('#region option:selected').text());
		});
		
		$(document).keydown(function (e) {
			if(e.which == 116){
				console.log($('#region option:selected').text());
				console.log($('#searchInput').text());
				console.log($('#searchRegion').text());
			}
			
		})
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