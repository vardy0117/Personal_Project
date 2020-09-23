<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>동물미용 로그인 화면</title>
    <link href=../css/loginStyle.css rel="stylesheet" type="text/css">

</head>
<body>
		<jsp:include page="../include/header.jsp"/>
<div id="body">
		<!-- 로그인 화면 -->
		<form method="post" action="loginPro.jsp">
		<div id="login"  height="700">
		<table align="center">
			<tr>
				<td colspan="2" align="center"><h1>로그인</h1></td>
			</tr>
			<tr>
				<td>ID</td>
				<td><input type="text" name="id" id="id"></td><br>
			</tr>
			<tr>	
				<td>PW</td>
				<td><input type="password" name="pw" id="pw"></td>
			</tr>
			<tr>
				<td></td>
				<td><input type="submit" value="로그인" class="btn"></td>
			</tr>
			<tr>
				<td><br></td>
			</tr>
			<tr>
				<td colspan="2" align="center"><a href="../join/join.jsp">계정이 없으신가요?</a></td>
			</tr>
		</table>
		</div>
		</form>
		
</div>		
		<jsp:include page="../include/footer.jsp"/>
</body>
</html>