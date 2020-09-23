<%@page import="java.util.ArrayList"%>
<%@page import="Board.BoardBean"%>
<%@page import="java.util.List"%>
<%@page import="Board.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>동물미용</title>
	<script src="https://code.jquery.com/jquery-3.3.1.js"></script>
    <link href=../css/boardStyle.css rel="stylesheet" type="text/css">
</head>
<body>


<!-- 헤더영역 -->
	<jsp:include page="../include/header.jsp"></jsp:include>
<!-- 헤더영역 -->
	
	
	
		
		<script type="text/javascript">
		/* 
			상단의 글 제목별로 게시글을 검색했을때 아무것도 입력하지 않고 그냥 입력하면 모든 게시글을 보여준다
			또는 입력을 하고 검색버튼 클릭 시 .. 해당 문자열에 제목이 일치하는 글만 가져온다
		*/
			function find() {
				if($("#find").val()==""){
					location.href="boardList.jsp";					
				}else{
					location.href="boardList.jsp?value="+$("#find").val();
				}
			}
		
		</script>
		
		
		
		
		
	<%
		request.setCharacterEncoding("utf-8");
		String value = request.getParameter("value");
		
		
		// input태그에 검색란이 공백일떄 (모든 글 뿌려주기)
		if(value == null){

			BoardDAO bDAO = new BoardDAO();
			int count = bDAO.getBoardCount();
			
			int pageSize = 5;
			
			
			
			String pageNum = request.getParameter("pageNum");
			if(pageNum == null){
				pageNum ="1";
			}

			int currentPage = Integer.parseInt(pageNum);
			
			int startRow = (currentPage - 1)* pageSize;
			
			List<BoardBean> list = null;
			
			if(count > 0){	//글개수가 0보다 크다면?
				list = bDAO.getBoardList(startRow,pageSize);
			}
		%>
		
		
		
		
		
		
		
		<table align="center" id="boardList" width="1100px">
			<tr>
				<th colspan="4">
					<h2>관리자에게 문의하기</h2>
				</th>
			</tr>
			
			<tr bgcolor="silver">
				<th>No.</th>
			    <th>Name</th>
			    <th width="70%">Subject</th>
			    <th>Date</th>
			</tr>
			<tbody id="tbody" align="center">
			<%
				for(int i = 0;i<list.size();i++){
					BoardBean bean = list.get(i);
			%>
				<tr onclick="location.href='boardDetail.jsp?Num=<%=bean.getNumber()%>'">
					<td><%=list.get(i).getNumber() %></td>
					<td><%=list.get(i).getName() %></td>
					<td><%=list.get(i).getSubject() %></td>
					<td><%=list.get(i).getDate() %></td>
				</tr>
			<%
				}
			%>
			</tbody>
		</table>
		<%
		//로그인을 해야지 글작성 버튼이 활성화
		String id = (String)session.getAttribute("id");
			if(id != null){
		%>
				<input type="button" onclick="location.href='board.jsp'" value="글작성" id="write">
		<%		
				}
		%>
		
		
		
		
		
		<div align="center">
		<%
		if(count > 0){	//DB에 글이 저장되어 있다면?
			
			int pageCount = count/pageSize+(count%pageSize==0?0:1);
			
			int pageBlock = 2;

			int startPage = ((currentPage/pageBlock)-(currentPage%pageBlock==0?1:0))*pageBlock+1;
			
			int endPage = startPage + pageBlock - 1;
			
			if(endPage > pageCount){
				endPage = pageCount;
			}
			if(startPage > pageBlock){
			%>
				<a href="boardList.jsp?pageNum=<%=startPage-pageBlock%>">[이전]</a>
			<%
			}
			
			// [1]	[2]	 [3]	...[10] 페이지 번호
			for(int i = startPage;i<=endPage;i++){
				if(i == currentPage) {
			%>
					<a href="boardList.jsp?pageNum=<%=i%>"><b>[<%=i %>]</b></a>
			<%			
				} else {
			%>
				<a href="boardList.jsp?pageNum=<%=i%>">[<%=i %>]</a>
			<%	
				}
			}
			//[다음]	끝페이지 번호가 전체페이지 수보다 작을때
			if(endPage < pageCount){
			%>
				<a href="boardList.jsp?pageNum=<%=startPage+pageBlock%>">[다음]</a>
			<%
			}
			
		}
		
		/* //////////////////////////////////////////////////////////////////////////// */
		
		
		// input 태그에 해당하는 글 내용만 검색했을때
		}else{
			BoardDAO bDAO = new BoardDAO();
			int count = bDAO.getBoardCount(value);
			int pageSize = 5;
			
			
			
			String pageNum = request.getParameter("pageNum");
			if(pageNum == null){
				pageNum ="1";
			}
			int currentPage = Integer.parseInt(pageNum);
			
			int startRow = (currentPage - 1)* pageSize;
			
			List<BoardBean> list = null;
			
			list = bDAO.getBoardList(startRow,pageSize,value);
		%>
		
		
		
		<table align="center" id="boardList" width="1100px">
			<tr  bgcolor="silver">
				<th>No.</th>
			    <th>Name</th>
			    <th>Subject</th>
			    <th>Date</th>
			</tr>
			
			<tbody id="tbody" align="center">
			<%
				for(int i = 0;i<list.size();i++){
					BoardBean bean = list.get(i);
			%>
				<tr onclick="location.href='boardDetail.jsp?Num=<%=bean.getNumber()%>'">
					<td><%=list.get(i).getNumber() %></td>
					<td><%=list.get(i).getName() %></td>
					<td><%=list.get(i).getSubject() %></td>
					<td><%=list.get(i).getDate() %></td>
				</tr>
			<%
				}
			%>

			</tbody>
		</table>
		<%
		//로그인을 해야지 글작성 버튼이 활성화
		String id = (String)session.getAttribute("id");
			if(id != null){
		%>
				<input type="button" onclick="location.href='board.jsp'" value="글작성" id="write">
		<%		
				}
		%>
		
		
		
		
		
		<div align="center">
		<%
		if(count > 0){	//DB에 글이 저장되어 있다면?
			
			int pageCount = count/pageSize+(count%pageSize==0?0:1);
			
			int pageBlock = 2;
			
			int startPage = ((currentPage/pageBlock)-(currentPage%pageBlock==0?1:0))*pageBlock+1;
			
			int endPage = startPage + pageBlock - 1;
			
			if(endPage > pageCount){
				endPage = pageCount;
			}
			if(startPage > pageBlock){
			%>
				<a href="boardList.jsp?pageNum=<%=startPage-pageBlock%>">[이전]</a>
			<%
			}
			
			// [1]	[2]	 [3]	...[10] 페이지 번호
			for(int i = startPage;i<=endPage;i++){
				if(i == currentPage) {
			%>
					<a href="boardList.jsp?pageNum=<%=i%>"><b>[<%=i %>]</b></a>
			<%			
				} else {
			%>
				<a href="boardList.jsp?pageNum=<%=i%>">[<%=i %>]</a>
			<%	
				}
			}
			//[다음]	끝페이지 번호가 전체페이지 수보다 작을때
			if(endPage < pageCount){
			%>
				<a href="boardList.jsp?pageNum=<%=startPage+pageBlock%>">[다음]</a>
			<%
			}
			
		}
		}
	%>
	

	</div>
	
	
	<div align="center">
			<b>글 제목</b> <input type="text" id="find">
			<input type="button" value="검색" onclick="find()">
	</div>
	</div>
	<jsp:include page="../include/footer.jsp"/>
</body>
</html>