<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>동물미용</title>
   <link href= "css/indexStyle.css" rel="stylesheet" type="text/css">
   	<script src="https://code.jquery.com/jquery-3.3.1.js"></script>
   
</head>
<body>
<!-- 	<div id="welcome"> -->
<!-- 		<h1 align="center">WELCOME</h1> -->
<!-- 	</div> -->
<!-- 	<input type="button" id="start" value="지금 시작하기" onclick="location.href='main.jsp'"> -->




	<img src="img/whiteDog2.jpg" class="image">

		<h1 class="text">WELCOME</h1>
<!-- 	5초 후에 main.jsp로 이동 -->
	<script type="text/javascript">
		$(function(){
			setTimeout(function(){
				location.href="main.jsp";	
			}, 5000);
		})
	</script>
</body>
</html>