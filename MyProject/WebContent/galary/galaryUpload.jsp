<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
   <link href=../css/galaryStyle.css rel="stylesheet" type="text/css">
<title>동물미용</title>
	<script src="https://code.jquery.com/jquery-3.3.1.js"></script>
</head>
<body>
	<jsp:include page="../include/header.jsp"/>
	<div id="body">
	<!-- 갤러리 글 작성 버튼을 클릭했을때 글을 작성할수있는 jsp페이지 -->
	<form action="galaryUploadPro.jsp" method="post" enctype="multipart/form-data">
		<table align="center" width="1000">
			<tr>
				<th colspan="2" align="center"><h2>갤러리 게시판 작성</h2></th>
			</tr>
			<tr align="center">
				<th>작성자 : </th>
				<td><input type="text" value="admin" readonly="readonly" name="name"></td>
			</tr>
			<tr align="center">
				<th>글 제목 : </th>
				<td><input type="text" name="subject"></td>
			</tr>
			<tr align="center">
				<th>파일 : </th>
				<td><input type="file" name="file" class="btn"></td>
			</tr>
			<tr align="center">
				<th>글 내용 : </th>
				<td><textarea cols="60" rows="30" name="content"></textarea></td>
			</tr>
			
			<tr align="center">
				<td align="center" colspan="2">
					<input type="submit" value="업로드" class="btn">
					<input type="reset" value="다시작성" class="btn">
				</td>
			</tr>
			
		</table>
	</form>


</div>
<jsp:include page="../include/footer.jsp"/>
</body>
</html>