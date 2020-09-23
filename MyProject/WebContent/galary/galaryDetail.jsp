<%@page import="GalaryComment.GalaryCommentBean"%>
<%@page import="GalaryComment.GalaryCommentDAO"%>
<%@page import="java.util.ArrayList"%>
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
	request.setCharacterEncoding("UTF-8");
	String n = request.getParameter("num");
	int num = Integer.parseInt(n);
	
	// 게시판 하나를 클릭 시 해당글의 num번호도 같이 넘겨주는데
	// num을 받아서 gDAO의 detailGalary()를 이용해서 게시글 하나의 정보를 받아온다
	GalaryDAO gDAO = new GalaryDAO();
	GalaryBean gBean = gDAO.detailGalary(num);
	
	
	// 엔터키 적용 작업하기위해서 content만 따로 꺼내와서 raplace로 속성을 변경 해준다음 뿌려준다
	String content = gBean.getContent();
	content = content.replace("\r\n", "<br>");	
	

	// 관리자가 이미지를 올려야지 사진받기 버튼 활성화
	if(gBean.getFile()!=null){
%>
	<form action="galaryDownload.jsp">
		<div align="right">
			<input type="hidden" name="path" value="upload">
			<input type="hidden" name="name" value="<%=gBean.getFile()%>">
			<input type="submit" value="사진받기" id="downBtn">
		</div>
	</form>
<%
	}
%>
	<table align="center" width="1000" id="galaryD">
			<tr>
				<th colspan="2" align="center" style="color: black;"><h2>갤러리 게시판</h2></th>
			</tr>
			<tr>
				<th>글 번호 : </th>
				<td><%=gBean.getNum() %>번 글</td>
			</tr>
			<tr>
				<th>작성자 : </th>
				<td>관리자</td>
			</tr>
			<tr>
				<th>글 제목 : </th>
				<td><%=gBean.getSubject()%></td>
			</tr>
			<tr>
				<th>이미지</th>
				<%
				if(gBean.getFile()==null){
			%>	
					<td width="600"><h2>사진이 없습니다.</h2></td>
			<%		
				}else{
			%>
					<td><img src="../upload/<%=gBean.getFile()%>" width="600" id="picture"></td>
			
			<%		
				}
			%>
			</tr>
			<tr>
				<th>글 내용 : </th>
				<td><%=content %></td>
			</tr>
			<tr>
				<th>작성일 : </th>
				<td><%=gBean.getDate() %></td>
			</tr>
			
			<%
				//id가 admin이여야지 글 삭제 & 글 수정 버튼 활성화
				if(session.getAttribute("id") != null && session.getAttribute("id").equals("admin")){
			%>
				<tr align="right">
					<td colspan="2">
						<input type="button" value="글 삭제" onclick="location.href='deleteGalary.jsp?num=<%=gBean.getNum()%>'">
						<input type="button" value="글 수정" onclick="location.href='updateGalary.jsp?num=<%=gBean.getNum()%>'">
					</td>
				</tr>
			<%		
				}
			%>
			
		</table>
		<br>
		<br>
		
		<%----------------------------------------댓 글 기 능---------------------------------- --%>
		
		<%
			// 댓글을 작성하고 댓글을 보여주는 테이블이다 
			// 먼저 DB에 저장되어있는 댓글을 등록하는 작업부터 한다.
			// 댓글을 등록하기 위해서는 먼저 DB의 number(댓글을 작성한 본문 글번호)를 이용하여 등록한다
			GalaryCommentDAO gcDAO = new GalaryCommentDAO();
			ArrayList<GalaryCommentBean> list =  gcDAO.selectComment(num);
			
			
		%>
		
		
		
		<script type="text/javascript">
			function commentSubmit() {
				$.ajax(
					{
						url:"/MyProject/galary/galaryCommentPro.jsp",
						type:"post",
						data:{comment:$("#comment").val(),num:<%=num%>},
						dataType:"text",
						success:function(data,textStatus){

							var jsonArr = JSON.parse(data);
							
							
							/* 기존에 글 삭제 후 재등록 */
							var table = document.getElementById("galaryComment");
							
							while(table.hasChildNodes()){	/* table에 자식이 있다면 */
								table.removeChild(table.firstChild);
							}
							
							for(var i = 0; i<jsonArr.length;i++){
								
								$("#galaryComment").append(
										
										"<tr><td>"+jsonArr[i].id+"</td>"+
										"<td>"+jsonArr[i].comment+"</td>"+
										"<td>"+jsonArr[i].date+"</td></tr>");
										
										history.go(0);// 댓글 등록후 페이지 새로고침
							}
							$("#comment").val("");
							
						},
						error:function(data,textStatus,errorThrown){
							alert("에러발생 : "+errorThrown);
							
						}
						
					}//ajax끝		
				
				);
			}
		</script>



	<table id="galaryComment" border="1" align="center" width="1100">
				<tr>
				<th>ID</th>
				<th>COMMENT</th>
				<th>DATE</th>
				<th colspan="2">UPD/DEL</th>
				</tr>
				
		<%
			for(int i=0;i<list.size();i++){
				
				
				out.println("<tr>");
				out.println("<td>"+list.get(i).getId()+"</td>");
				out.println("<td>"+list.get(i).getComment()+"</td>");
				out.println("<td>"+list.get(i).getDate()+"</td>");
				if(list.get(i).getId().equals(session.getAttribute("id"))){	//내가 쓴 댓글이면 [삭제] [수정] 버튼 활성화
					out.print("<td><a href='deleteGalaryComment.jsp?primaryNum="+list.get(i).getPrimaryNum()+"'>삭제</a></td>");
					out.print("<td><a onclick='updateComment("+list.get(i).getPrimaryNum()+")'>수정</a></td>");
				}
				out.println("</tr>");
				
			}
		%>
	</table>
	
	<%
		String id = (String)session.getAttribute("id");
		if(id != null){
	%>
	<form>
	<table border="1" align="center" width="1100">
			<tr>
				<th>댓글 달기</th>
				<td><textarea rows="6" cols="50" id="comment" name="comment" maxlength="30" placeholder="30자 제한"></textarea></td>
				<td><input type="button" value="댓글달기" onclick="commentSubmit()"></td>
				<td><input type="button" value="글목록" onclick="location.href='galary.jsp'"></td>
			</tr>
		</table>
	</form>	
	<%			
		}
	%>
	
	
		
		<br>
		<br>
		<br>
		<br>
	<script type="text/javascript">
		function updateComment(primaryNum) {
			window.open("updateGalaryComment.jsp?primaryNum="+primaryNum,"","width=800px,height=200px,top=100px,left=500px");
		}
	</script>


</div>
<jsp:include page="../include/footer.jsp"/>
</body>
</html>