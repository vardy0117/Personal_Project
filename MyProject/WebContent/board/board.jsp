<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <link href=../css/boardStyle.css rel="stylesheet" type="text/css">

<title>동물미용</title>
</head>

<!-- 게시판 작성을 하는 페이지 -->


<body>
	<!-- 헤더영역 들어가는곳 -->
		<jsp:include page="../include/header.jsp"></jsp:include>
	<!-- 헤더영역 들어가는곳 -->
<div id="body">
	<%
		String id = (String)session.getAttribute("id");
	
		// 로그인을 하지 않고 url주소로 바로 접근시 경고문 띄워주고 main.jsp로 강제 이동
		if(id == null){
	%>
			<script type="text/javascript">
				alert("비정상적인 접근입니다.");
				location.href="../main.jsp";
			</script>
	<%		
		}
	
	
	%>
	<!-- 게시판 내용 -->
	<form action="boardPro.jsp" method="post">
	<center>
	<table width="1000">
		<tr>
			<td colspan="2" align="center"><h1>글 작성</h1></td>
		</tr>
		<tr>
			<td>작성자</td>
			<td style="text-align: center;">
				<input type="text" name="name" value=<%=id %> readonly="readonly">
			</td>
		</tr>
		
		<tr>
			<td>비밀번호</td>
			<td style="text-align: center;">
				<input type="password" name="pass">
			</td>
		</tr>
		<tr>
			<td>글 제목</td>
			<td style="text-align: center;">
				<input type="text" name="subject">
			</td>
		</tr>
		
		<tr>
			<td>글 내용</td>
			<td style="text-align: center;">
				<textarea rows="13" cols="30" name="content"></textarea>
			</td>
		</tr>
		
	</table>
	<br>
	<input type="submit" value="작성완료" class="btn">
	<input type="reset" value="다시작성" class="btn">
	<input type="button" onclick="location.href='boardList.jsp'" value="글목록">
	</center>
	</form>
	<br>
	<br>
		
	<!-- 게시판 내용 -->
	</div>
	<jsp:include page="../include/footer.jsp"/>
</body>
</html>