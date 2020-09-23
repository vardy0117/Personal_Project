<%@page import="java.util.List"%>
<%@page import="GalaryComment.GalaryCommentDAO"%>
<%@page import="Galary.GalaryDAO"%>
<%@page import="Galary.GalaryBean"%>
<%@page import="java.util.ArrayList"%>
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
	
	<!-- 강아지 미용 잘된 사진 올리는 게시판을 만들거다 -->
	<!-- galary.jsp의 글 등록 등등 은 admin 관리자밖에 할수없음 -->
	<h2 align="center">미용 완료된 사진</h2>
	
		
	
	
	<%
		String id = (String)session.getAttribute("id");
		if(id != null && id.equals("admin")){	//id가 admin인 경우 ( 로그인했을때 !)
	%>
			<div align="right" id="write">
				<input type="button" value="글 작성" onclick="location.href='galaryUpload.jsp'">
			</div>
	<%		
	
		}// id가 admin이아니거나 로그인상태가 아니면 글 작성 버튼을 보여주지 않는다
	%>
	

	<%------------------------------------------------------------------------------------ --%>
	
	<%
	
	
		// galary.jsp의 화면에 모든 갤러리 목록들을 뿌려주는 작업
		GalaryDAO gDAO = new GalaryDAO();
		ArrayList<GalaryBean> list = gDAO.selectGalary();
		
		int count = gDAO.getBoardCount();
		int pageSize = 6;
		String pageNum = request.getParameter("pageNum");
		if(pageNum == null){
			pageNum ="1";
		}
		int currentPage = Integer.parseInt(pageNum);
		
		int startRow = (currentPage - 1)* pageSize;

		List<GalaryBean> list2 = null;
		
		if(count > 0){	//글개수가 0보다 크다면?
			list2 = gDAO.getBoardList(startRow,pageSize);
		}
			
		
		for(int i=0; i<list2.size();i++){
			GalaryBean gBean = list2.get(i);
			
			
		//galary.jsp의 각 게시글마다 댓글의 수를 적용시킬 작업
		GalaryCommentDAO gcDAO = new GalaryCommentDAO();
		int countComment = gcDAO.countComment(gBean.getNum());
	%>
	<table onclick="location.href='galaryDetail.jsp?num=<%=gBean.getNum()%>'" id="galaryT" align="center">
		<tr>
			<th>글 번호</th>
			<td><%=gBean.getNum()%></td>
		</tr>
		<tr>
			<th>글 제목</th>
			<td><%=gBean.getSubject()%></td>
		</tr>
		<tr>
			<th>글 사진</th>
			<%
				if(gBean.getFile()==null){
			%>	
					<td width="150" height="200" class="picture"><h2>사진이<br> 없습니다.</h2></td>
			<%		
				}else{
			%>
					<td><img src="../upload/<%=gBean.getFile()%>" width="150" class="picture"></td>
			
			<%		
				}
			%>
		</tr>
		<tr>
			<th>댓글</th>
			<td>[<%=countComment %>개] ..</td>
		</tr>


	</table>
	<%	
		}//for문 끝
	%>
	
	<div style="clear:both;"></div>
	<div style="text-align: center;">
	<%
		if(count > 0) {
			int pageCount = count/pageSize+(count%pageSize==0?0:1);
			
			int pageBlock = 2;
			
			int startPage = ((currentPage/pageBlock)-(currentPage%pageBlock==0?1:0))*pageBlock+1;
			
			int endPage = startPage + pageBlock - 1;
			
			if(endPage > pageCount){
				endPage = pageCount;
			}
			if(startPage > pageBlock){
	%>
				<a href="galary.jsp?pageNum=<%=startPage-pageBlock%>">[이전]</a>
	<%
			}
			for(int i = startPage;i<=endPage;i++){
				if(i == currentPage) {
	%>
					<a href="galary.jsp?pageNum=<%=i%>"><b>[<%=i %>]
					</b></a>
	<%			
				} else {
	%>
					<a href="galary.jsp?pageNum=<%=i%>">[<%=i %>]
					</a>
	<%	
				}
			}
			if(endPage < pageCount){
	%>
				<a href="galary.jsp?pageNum=<%=startPage+pageBlock%>">[다음]</a>
	<%
			}
		}
	%>
	</div>
	
	
	
	</div>
	<jsp:include page="../include/footer.jsp"/>
</body>
</html>