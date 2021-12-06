<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>머먹GANG · 채널찾기</title>
<script src="../../js/jquery-3.6.0.js"></script>

<link href="../../css/egovframework/bootstrap.css" rel="stylesheet">
</head>


<style>

ion-icon {
  font-size: 20px;
}
.listdiv{
	width: 90% !important;
}
.paging{
	text-align: center;
	margin-right: 10%;
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
.item:nth-child(3) {
	display: flex;
	justify-content: right;
}
.item:nth-child(4) {
	grid-column: 1/3;
	margin-top: 40px;
}
.item:nth-child(5) {
	grid-column: 1/3;
	margin-top: 25px;
	margin-bottom: 25px;
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
	margin-top: 9px;
}

#sptext{
	font-size: 13px;
	text-align: right;
	margin-right: 10%;
}

.form-select-sm{
	width: 140px;
    margin: 5px;
    margin-left: 20px;
    margin-right: 30px;
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
				<button class="btn" style="width: 130px; " id="findmycop" value="true" name="mycop">나의 회사 찾기</button>
			</form>
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
							<li>${chlist.chName} <span style="float: right;">${chlist.chDate}</span></li>
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
		<div class="item">
		 			<div class="paging">
                    <c:if test="${pagination.curRange ne 1 }">
                        <a href="#" onClick="fn_paging(1)"><<</a> 
                    </c:if>
                    <c:if test="${pagination.curPage ne 1}">
                        <a href="#" onClick="fn_paging('${pagination.prevPage }')"><</a> 
                    </c:if>
                    <c:forEach var="pageNum" begin="${pagination.startPage }" end="${pagination.endPage }">
                        <c:choose>
                            <c:when test="${pageNum eq  pagination.curPage}">
                                <span style="font-weight: bold;"><a href="#" onClick="fn_paging('${pageNum }')">${pageNum }</a></span> 
                            </c:when>
                            <c:otherwise>
                                <a href="#" onClick="fn_paging('${pageNum }')">${pageNum }</a> 
                            </c:otherwise>
                        </c:choose>
                    </c:forEach>
                    <c:if test="${pagination.curPage ne pagination.pageCnt && pagination.pageCnt > 0}">
                        <a href="#" onClick="fn_paging('${pagination.nextPage }')">></a> 
                    </c:if>
                    <c:if test="${pagination.curRange ne pagination.rangeCnt && pagination.rangeCnt > 0}">
                        <a href="#" onClick="fn_paging('${pagination.pageCnt }')">>></a> 
                    </c:if>
                </div>
		</div>
	</div>
</body>
<script src="../../js/jquery_cookie.js"></script>
<script type="text/javascript">
	$(document).ready(function() {
		var latitude = sessionStorage.getItem("latitude");
		var longitude = sessionStorage.getItem("longitude");
		console.log(latitude, longitude);
		getLocation();
		$("#findchannel").addClass("active");
		$("#friendlist").removeClass("active");
		$("#findfriend").removeClass("active");
		$("#channel").removeClass("active");
		
		//$("#region").val($.cookie('selectRegion')).prop("selected", true);
		console.log('${keyword}');
		
		if('${chregion}' != ""){
			$("#region").val('${chregion}').prop("selected", true);
			$('#searchRegion').attr('value', '${chregion}');
		}else{
			$('#searchRegion').attr('value', '지역선택');
		}
		if('${keyword}' != ""){
			$('#searchInput').attr('value', '${keyword}');
		}
		//$('#searchInput').attr('value', $.cookie('searchInput'));
		
		
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
	
	function fn_paging(curPage) {
		location.href = "/findchannel?curPage=" + curPage;
	}
	
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