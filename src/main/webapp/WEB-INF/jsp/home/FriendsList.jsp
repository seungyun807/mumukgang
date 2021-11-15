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
	grid-template-columns: 1fr 5fr 0.7fr !important;
	text-align: left;
	width: 100% !important;
	height: 80px;
	align-items: center;
	border-bottom: 1px solid #d3d3d3;
}
ion-icon {
  font-size: 20px;
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

</style>
<body>
	<jsp:include page="Home.jsp" flush="true"></jsp:include>


	<div class="thirddiv">
		<div class="item">
			<h3>친구목록</h3>
			<hr>
		</div>
		<div class="item">
			
			<ul class="list-group">
				<c:forEach var="friendlist" items="${friendslist}" varStatus="status">
					<div class="listdiv">
						<div class="listdivitem">
							<img width="40px" src="../../images/egovframework/profile/profile2.png">
						</div>
						<div class="listdivitem">
							<li>${friendlist.friendNickname}</li>
							<li style="font-size: 14px;">${friendlist.friendEmail}</li>
						</div>
						<div class="listdivitem">
							<button class="btn delfriendbtn" value="${friendlist.friendEmail}">
								<ion-icon name="trash-outline"></ion-icon>
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
		$("#findchannel").removeClass("active");
		$("#friendlist").addClass("active");
		$("#findfriend").removeClass("active");
		$("#channel").removeClass("active");
		
		$(".delfriendbtn").on('click', function() {
			if (confirm("친구를 삭제하시겠습니까?")){
			 var delemail = $(this).attr("value");
			 $.ajax({
					type : 'post',
					data : {"delemail" : delemail},
					url : "/delfriend",
					success : function(returnData, status) {
					console.log(returnData);
					if (returnData) {
						
					} else {
					}
					var link = '/friendslist';
					location.href = link;
					}
						
				});
			}
		});
	});
</script>
</html>