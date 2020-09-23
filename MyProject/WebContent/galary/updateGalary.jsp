<%@page import="java.io.File"%>
<%@page import="java.util.Enumeration"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="Galary.GalaryBean"%>
<%@page import="Galary.GalaryDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>동물미용</title>
	<script src="https://code.jquery.com/jquery-3.3.1.js"></script>
   <link href=../css/galaryStyle.css rel="stylesheet" type="text/css">
</head>
<body>


<!-- 헤더영역 -->
	<jsp:include page="../include/header.jsp"></jsp:include>
<!-- 헤더영역 -->
<div id="body">
	<%
		//galaryDetail.jsp에서 게시글 하나를 삭제 하려고 할때 이동되는 페이지
		request.setCharacterEncoding("utf-8");
		int num = Integer.parseInt(request.getParameter("num"));
	 	
		// 넘겨받은 num을 이용하여 DAO에서 해당 글을 select해서 가지고 온다
		GalaryDAO gDAO = new GalaryDAO();
		GalaryBean gBean =  gDAO.galaryUpdateSelect(num);
	%>	
	<form action="updateGalaryPro.jsp" enctype="multipart/form-data" method="post">
		<input type="hidden" value="<%=num%>" name="num">
		<input type="hidden" value="../upload/<%=gBean.getFile()%>" name="oldFile">
		<table border="1" align="center">
			<tr>
				<th colspan="2">갤러리 게시판 수정</th>
			</tr>
			<tr>
				<th>글 번호 : </th>
				<td><%=gBean.getNum() %>번 글</td>
			</tr>
			<tr>
				<th>작성자 : </th>
				<td><input type="text" value="<%=gBean.getName() %>" name="newName"></td>
			</tr>
			<tr>
				<th>글 제목 : </th>
				<td><input type="text" value="<%=gBean.getSubject() %>" name="newSubject"></td>
			</tr>
			<tr>
				<th>기존 이미지</th>
				<td><img src="../upload/<%=gBean.getFile()%>" width="600" id="o"></td>
			</tr>
			<tr>
				<th>변경할 이미지</th>
				<td><input type="file" name="newFile" id="f"></td>
			</tr>
			<tr>
				<th>글 내용 : </th>
				<td><textarea name="newContent" rows="5" cols="60"><%=gBean.getContent()%></textarea></td>
			</tr>
			<tr>
				<th>기존 작성일 : </th>
				<td><%=gBean.getDate()%></td>
			</tr>
			<tr>
				<td colspan="2" align="right"><input type="submit" value="수정하기"></td>
			</tr>
		</table>
	 </form>
	 
	
</div>	
	<jsp:include page="../include/footer.jsp"/>
</body>
</html>