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
<%
	request.setCharacterEncoding("UTF-8");
	String newComment = request.getParameter("newComment");
	String r = request.getParameter("primaryNum");
	int primaryNum = Integer.parseInt(r);
	
	BoardCommentDAO bcDAO = new BoardCommentDAO();
	
	bcDAO.updateComment(primaryNum,newComment);
	
%>
<script type="text/javascript">
	alert("댓글 수정이 완료되었습니다.");
	window.opener.location.reload();
	window.close();
</script>
</body>
</html>