<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<script src="http://code.jquery.com/jquery-latest.js"></script>
<script type="text/javascript">
$.ajax({
    url: 'https://dapi.kakao.com/v2/local/search/keyword.json?y=35.142432279851256&x=126.83601844546476&radius=2000',
    data: { query: '분식', page: 1},
    headers: { 'Authorization': 'KakaoAK c602ea38330a8ae2bae8e53d2d5bb2b1'},
    type: 'GET'
}).done(function(data) {
    console.log(data);
});

</script>
<body>
<h1>hello</h1>
</body>
</html>