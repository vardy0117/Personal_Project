<%@page import="Board.BoardDAO"%>
<%@page import="Board.BoardBean"%>
<%@page import="BoardComment.BoardCommentBean"%>
<%@page import="BoardComment.BoardCommentDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<%-- boardUpdate.jsp 에서 게시글 수정을 누른 후 수정하기 버튼을 클릭했을때 DB와 연동해서 UPDATE작업을 수행하기 위한 페이지 --%>

<%
	request.setCharacterEncoding("UTF-8");
	String Num = request.getParameter("Num");
	int number = Integer.parseInt(Num);
	
	String name = request.getParameter("name");
	String pass = request.getParameter("pass");
	String subject = request.getParameter("subject");
	String content= request.getParameter("content");
	
	BoardBean bBean = new BoardBean(number,name,pass,subject,content);
	BoardDAO bDAO = new BoardDAO();
	bDAO.updateBoard(bBean);
%>
	<script type="text/javascript">
	alert("수정완료되었습니다");
	location.href="boardList.jsp";
	</script>
	

</body>
</html>