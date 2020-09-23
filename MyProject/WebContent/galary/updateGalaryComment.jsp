<%@page import="GalaryComment.GalaryCommentBean"%>
<%@page import="GalaryComment.GalaryCommentDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>동물미용</title>
</head>
<body>
	<%
		//galaryDetail.jsp에서 댓글 수정하기 버튼 클릭시 window.open()으로 새 창을 띄우준다
		// 띄워주는 창
		int primaryNum = Integer.parseInt(request.getParameter("primaryNum"));
		GalaryCommentDAO gcDAO = new GalaryCommentDAO();
		GalaryCommentBean gcBean = new GalaryCommentBean();
				  gcBean = gcDAO.selectDetailComment(primaryNum);
	%>
	<form action="updateGalaryCommentPro.jsp?primaryNum=<%=primaryNum%>" method="post">	
	<table border="2" width="1000" align="center">
		<tr>
			<th colspan="3">COMMENT</th>
		</tr>
		
		<tr>
			<th>ID</th>
			<th>COMMENT</th>
			<th>DATE</th>
		</tr>
		
		<tr>
			<td><%=gcBean.getId() %></td>
<%-- 			<td><input type="text" value="<%=gcBean.getComment()%>" name="newComment"></td> --%>
			<td><textarea rows="6" cols="50" maxlength="30" placeholder="30자 제한" name="newComment"><%=gcBean.getComment()%></textarea></td>
			<td><%=gcBean.getDate() %></td>
		</tr>
		<tr><td colspan="3"><input type="submit" value="수정하기"><input type="reset" value="다시작성"></td></tr>
	</table>
</form>
</body>
</html>