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
<script type="text/javascript">


</script>

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
			<h2>친구목록</h2>
			
			<div class="thirddiv" >
				<div class="item">

	<div id="custom-search-input">
                <div class="input-group col-md-12">
                    <input type="text" class="form-control input-lg" id="searchInput" placeholder="친구찾기" />
                    <span class="input-group-btn">
                        <button class="btn btn-info btn-lg" type="button">
                           <ion-icon name="search-outline"></ion-icon>
                        </button>
                    </span>
                </div>
            </div>
				</div>
				
				<div class="item">
				
					<ul class="list-group">
						<c:forEach var="friendlist" items="${friendslist}" varStatus="status">
							<li class="list-group-item">${friendlist.friendEmail}</li>
						</c:forEach>
						
				 		
				 		
						
					</ul>
          		
				</div>
	<div class="item">
	
	<ul class="list-group">
            <li class="list-group-item">Lorem<button>12</button></li>
            <li class="list-group-item">Ipsum</li>
            <li class="list-group-item">Dolor</li>
          </ul>
	</div>
	
	
			</div>
			
</body>
</html>