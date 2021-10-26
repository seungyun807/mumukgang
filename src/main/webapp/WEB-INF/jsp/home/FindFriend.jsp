<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="../../js/jquery-3.6.0.js"></script>

<link href="../../css/egovframework/bootstrap.css" rel="stylesheet">
</head>
<style>
	.thirddiv{
		display: grid;
		grid-template-columns: 1fr 1fr;
		grid-column-gap:10px;
		margin-left: 100px;
		margin-top: 20px;
		margin-right: 100px;
		
		
	}
	.item:nth-child(1) {
	grid-column: 1 / 3;
	grid-row: 1 / 2;
	margin-bottom: 20px;
}
#custom-search-input{
    padding: 3px;
    border: solid 1px #E4E4E4;
    border-radius: 6px;
    background-color: #fff;
}

#custom-search-input input{
    border: 0;
    box-shadow: none;
}

#custom-search-input button{
    margin: 2px 0 0 0;
    background: none;
    box-shadow: none;
    border: 0;
    color: #666666;
    padding: 0 8px 0 10px;
    border-left: solid 1px #ccc;
}

#custom-search-input button:hover{
    border: 0;
    box-shadow: none;
    border-left: solid 1px #ccc;
}


#custom-search-input .glyphicon-search{
    font-size: 23px;
}
</style>
<body>
	<jsp:include page="Home.jsp" flush="true"></jsp:include>
	
	
	<div class="thirddiv" >
	<div class="item">
	<h1>친구찾기</h1></div>
	<form action="/findfriendsdo" method="post">
				<div class="item">
	
	<div id="custom-search-input">
                <div class="input-group col-md-12">
                    <input name="nickname" type="text" class="form-control input-lg" id="searchInput" placeholder="친구찾기" />
                    <span class="input-group-btn">
                        <button class="btn btn-info btn-lg" type="submit">
                           <ion-icon name="search-outline"></ion-icon>
                        </button>
                    </span>
                </div>
            </div>
            
	</div>
	</form>
			<form action="/requestfriends" method="post">
				<div class="item" >
					${findfriend.nickname} 
					<input name="res_email" type="hidden" value="${findfriend.email}" id="res_email"/>
					<button class="btn btn-primary" type="submit" >친구요청</button>
				</div>
			</form>
			
			<div class="item">
				<h1>친구요청</h1>
			</div>
			
			<div class="item">
	
			</div>
			
			<div class="item">
			<c:forEach var="resfriend" items="${resfriends}" varStatus="status">
				<div class="card text-white bg-info mb-3" style="max-width: 20rem; height: 100px;">
  					<div class="card-body">
    					<h5 class="card-title">${resfriend.req_email}</h5>
   					 	<p class="card-text">email</p>
 					</div>
  				</div>
			</c:forEach>
			</div>
		
		
		</div>
			
</body>
</html>