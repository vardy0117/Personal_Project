<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
   <link href=../css/hireStyle.css rel="stylesheet" type="text/css">
	<script src="https://code.jquery.com/jquery-3.3.1.js"></script>

<title>Insert title here</title>
</head>
<body>
	<jsp:include page="../include/header.jsp"/>
	<div id="body">
	
		<%-- 이력서 --%>
		<form action="hirePro.jsp" method="post">
			<table align="center">
				<tr>
					<td colspan="2" align="center"><h1>이 력 서</h1></td>
				</tr>
				<tr>
					<th>이름</th>
					<td><input type="text" name="name"></td>
				</tr>
				<tr>
					<th>나이</th>
					<td><input type="text" name="age"></td>
				</tr>
				<tr>
					<th>연락받을 번호</th>
					<td><input type="text" placeholder="010xxxxxxxx" name="phone"></td>
				</tr>
				<tr>
					<th>경력사항 및 자기소개</th>
					<td><textarea rows="5" cols="30" name="info"></textarea> </td>
				</tr>
				<tr>
					<td colspan="2" align="right"><br><input type="submit" value="전송"></td>
				</tr>
			</table>
		</form>	
	</div>
	<jsp:include page="../include/footer.jsp"/>
</body>
</html>