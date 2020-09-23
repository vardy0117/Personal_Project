<%@page import="BoardComment.BoardCommentBean"%>
<%@page import="java.util.ArrayList"%>
<%@page import="BoardComment.BoardCommentDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>동물미용</title>
</head>
<body>
<!-- 댓글 수정 페이지 -->
<%
	request.setCharacterEncoding("utf-8");
	String primaryNum1 = request.getParameter("primaryNum");
	int primaryNum = Integer.parseInt(primaryNum1);
	
	BoardCommentDAO bcDAO = new BoardCommentDAO();
	ArrayList<BoardCommentBean> arr = new ArrayList();
	arr = bcDAO.getComment(primaryNum);	//primaryNum으로 댓글의 내용을 ArrayList에 담는다
	
	//담아온 ArrayList를 다시 bcBean객체로 만든다
	BoardCommentBean bcBean = new BoardCommentBean();
	bcBean.setNumber(arr.get(0).getNumber());
	bcBean.setId(arr.get(0).getId());
	bcBean.setComment(arr.get(0).getComment());
	bcBean.setDate(arr.get(0).getDate());
	bcBean.setPrimaryNum(arr.get(0).getPrimaryNum());
		
%>
<form action="boardCommentUpdatePro.jsp?primaryNum=<%=primaryNum%>" method="post">	
	<table border="2" width="500" align="center">
		<tr>
			<th colspan="3">COMMENT</th>
		</tr>
		
		<tr>
			<th>ID</th>
			<th>COMMENT</th>
			<th>DATE</th>
		</tr>
		
		<tr>
			<td><%=bcBean.getId()%></td>
			<td><input type="text" value="<%=bcBean.getComment()%>" name="newComment"></td>
			<td><%=bcBean.getDate()%></td>
		</tr>
		<tr><td colspan="3"><input type="submit" value="수정하기"><input type="reset" value="다시작성"></td></tr>
	</table>
</form>
</body>
</html>