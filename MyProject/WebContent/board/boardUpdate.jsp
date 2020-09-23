<%@page import="Board.BoardBean"%>
<%@page import="Board.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>동물미용</title>
</head>
	<script src="https://code.jquery.com/jquery-3.3.1.js"></script>

    <link href=../css/boardStyle.css rel="stylesheet" type="text/css">
<body>

<%--헤더영역 --%>
<jsp:include page="../include/header.jsp"/>
<%--헤더영역 --%>
<div id="body">

<%-- 게시글 수정하기 버튼 클릭시 나오는 페이지 --%>
<%
//해당 num에 해당하는 글의 정보를 DB로부터 가져온다
	// boardList에서 get방식으로 전송한 Num을 가져온다.
	request.setCharacterEncoding("UTF-8");
	String Num = request.getParameter("Num");
	
	
	//글 작성자는 DB에 담겨져있는 데이터에 Num값을 이용하여 조회한다
	BoardDAO bDAO = new BoardDAO(); 
	BoardBean bBean = new BoardBean();
	
	int number = Integer.parseInt(Num);
	
	int number1 = bDAO.selectContent(number,bBean);
	String name = bBean.getName();
	String pass = bBean.getPass();
	String subject = bBean.getSubject();
	String content = bBean.getContent();
	String date = bBean.getDate();
%>	

<form action="boardUpdatePro.jsp?Num=<%=number %>" method="post">
	<table align="center">
		<tr>
			<td>글번호</td>
			<td style="text-align: center;">
				<input type="text" name="number" value=<%=Num %>번글 readonly="readonly">
			</td>
		</tr>
		
				<%-- 비밀번호는 변경하지 못하게 hidden태그로 기존의 비밀번호를 그대로 넘겨준다 --%>
				<input type="hidden" name="pass" value=<%=pass %>>
				
				
		<tr>
			<td>작성자</td>
			<td style="text-align: center;">
				<input type="text" name="name" value=<%=name %> readonly="readonly">
			</td>
		</tr>
		
		
		<tr>
			<td>글 제목</td>
			<td style="text-align: center;">
				<input type="text" name="subject" value=<%=subject %>>
			</td>
		</tr>
		
	
		
		<tr>
			<td>글 내용</td>
			<td style="text-align: center;">
				<textarea rows="13" cols="30" name="content"><%=content %></textarea>
			</td>
		</tr>
		
		<tr>
			<td><input type="submit" value="수정완료"></td>
			<td><input type="reset" value="다시작성"></td>
			<td><input type="button" onclick="location.href='boardDetail.jsp?Num=<%=Num %>'" value="취소"></td>
		</tr>
	</table>





</form>
</div>
<jsp:include page="../include/footer.jsp"/>
</body>
</html>