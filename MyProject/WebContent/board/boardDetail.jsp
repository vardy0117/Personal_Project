<%@page import="java.util.ArrayList"%>
<%@page import="BoardComment.BoardCommentBean"%>
<%@page import="java.util.List"%>
<%@page import="BoardComment.BoardCommentDAO"%>
<%@page import="Board.BoardDAO"%>
<%@page import="Board.BoardBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>동물미용</title>
      <link href=../css/boardStyle.css rel="stylesheet" type="text/css">
  
  	<script src="https://code.jquery.com/jquery-3.3.1.js"></script>
  
</head>
<body>
<!-- 게시판의 글목록중 글 하나를 클릭하면 해당 글의 내용이 보여지는 페이지 -->

<!-- 헤더영역 -->
	<jsp:include page="../include/header.jsp"></jsp:include>
<!-- 헤더영역 -->
<div id="body">
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
	content = content.replace("\r\n", "<br>");
	String date = bBean.getDate();
	
	//해당글의 답글 가져오기
	BoardCommentDAO bcDAO = new BoardCommentDAO();
	ArrayList<BoardCommentBean> bcList = bcDAO.selectComment(number);
	
	
%>

	
	


<form action="boardPro.jsp" method="post">
	<table align="center" width="1000" id="boardDetail">
		<tr>
			<th colspan="2" style="color: black;"><h2><%=Num %>번 게시글</h2></th>
		</tr>
		<tr>
			<th>글번호</th>
			<td style="text-align: center;">
<%-- 				<input type="text" name="Num" value=<%=Num %>번글 readonly="readonly"> --%>
				<%=Num %>번글
			</td>
		</tr>
		<tr>
			<th>작성자</th>
			<td style="text-align: center;">
<%-- 				<input type="text" name="name" value=<%=name %> readonly="readonly"> --%>
				<%=name %>
			</td>
		</tr>
		<tr>
			<th>글 제목</th>
			<td style="text-align: center;">
<%-- 				<input type="text" name="subject" value=<%=subject %> readonly="readonly"> --%>
				<%=subject %>
			</td>
		</tr>
		<tr>
			<th colspan="2"><hr></th>
		</tr>
		<tr>
			<th>글 내용</th>
			<td style="text-align: center;">
<%-- 				<textarea rows="13" cols="30" name="content" readonly="readonly"><%=content %></textarea> --%>
				<%=content %>
			</td>
		</tr>
		<tr>
			<th colspan="2"><hr></th>
		</tr>
		<tr>
			<th>작성 날짜</th>
			<td style="text-align: center;">
<%-- 				<input type="text" name="subject" value=<%=date %> readonly="readonly"> --%>
				<%=date %>
			</td>
		</tr>
	</table>
	<br>
	
	
	
	
	
	
		<!-- boardDetail의 하단에 댓글 화면 -->
		<table border="0" width="1100" align="center" id="boardC">
				
			<tr>
				<th colspan="3" bgcolor="gray">COMMENT</th>
			</tr>
			
			<tr bgcolor="silver">
				<th>ID</th>
				<th>COMMENT</th>
				<th>DATE</th>
			</tr>
			
			<tbody id="tbodyC">
				<%
				
				// 댓글중에 내가 작성한 댓글이면 수정 , 삭제 버튼 활성화
				
				String loginId = (String)session.getAttribute("id");
				for(int i=0; i<bcList.size(); i++) {
					out.println("<tr>");
					out.println("<td>"+bcList.get(i).getId()+"</td>");
					out.println("<td>"+bcList.get(i).getComment()+"</td>");
					if(loginId != null && loginId.equals(bcList.get(i).getId())){
						out.println("<td>"+bcList.get(i).getDate()+"<a href='boardCommentDelete.jsp?primaryNum="+bcList.get(i).getPrimaryNum()+"'> [삭제] </a>"+
								"<a onclick='cmUpdateOpen("+bcList.get(i).getPrimaryNum()+")'>"+" [수정] </a></td>");
					}else{
						out.println("<td>"+bcList.get(i).getDate()+"</td>");
					}
					out.println("</tr>");
				}//for문
				
				%>
				
				
			</tbody> 
				
		</table>
		
		<script type="text/javascript">
			function cmUpdateOpen(primaryNum) {
				window.open("boardCommentUpdate.jsp?primaryNum="+primaryNum,"","width=800px,height=200px");
			}
		</script>
	
	
	
	
	
	
	
	
	
		<!-- 답글 달기 기능은 로그인을 해야지 사용할수있다 -->
	<%
		String id = (String)session.getAttribute("id");
		if(id != null){
	%>
			<!-- 답글<input type="text" id="reply"> -->
			<!-- <div id="replyList"></div>
			<br>		
			<input type="text" id="commentText">
			<input type="button" value="답글달기" onclick="getReply()"> -->
			
			
			<!-- 답글달기 -->
			<script type="text/javascript">
			
			//var commentText = document.getElementById("commentText").value;
			//var commentText = $("#commentText").val();
			
				
			function getReply() {
					$.ajax(
						{
							url:"/MyProject/board/boardComment.jsp",
							type:"post",
							data:{comment:$("#commentText").val(),pageNum:<%=number%>},
							dataType:"text",
							success:function(data,textStatus){
								alert("댓글이 등록되었습니다");
								var jsonArray = JSON.parse(data);
								
								var tbody = document.getElementById("tbodyC");
								var loginId = '<%=loginId%>';
								
								/* 기존에 글 삭제 후 재등록 */
								while(tbody.hasChildNodes()){	/* tbodyC에 자식이 있다면 */
									tbody.removeChild(tbody.firstChild);
								}
								
								for(var i=0;i<jsonArray.length;i++){
									
									/* 댓글 등록시 수정 삭제 버튼도 같이 비동기식으로 활성화 */
									if(jsonArray[i].id == loginId) {
										$("#tbodyC").append("<tr><td>"+jsonArray[i].id+"</td><td>"+jsonArray[i].comment+"</td><td>"+jsonArray[i].date+"<a href='boardCommentDelete.jsp?primaryNum="+jsonArray[i].primaryNum+"'>[X]</a><a onclick='cmUpdateOpen("+jsonArray[i].primaryNum+")'>[수정]</a></td></tr>");
									} else {
										$("#tbodyC").append("<tr><td>"+jsonArray[i].id+"</td><td>"+jsonArray[i].comment+"</td><td>"+jsonArray[i].date+"</td></tr>");									
									}
								}
								$("#commentText").val("");
								
								/* history.go(0);	 페이지 새로고침 <--ajax기법에 맞지 않는 방법*/
							},
							error:function(data,textStatus,errorThrown){
								alert("에러발생 : "+errorThrown);
								
							}
						}		
					
					);
					
				}
			</script>

			<input type="text" id="commentText" >
			<input type="button" value="댓글달기" onclick="getReply()">
			
	<%		
		}
	
	%>
		
		
	<%--
		id != null && 이 없는 방식은 sessiondp id가 로그인 되어있는 경우에는 문제없이 실행 되지만 
		예를 들어서 로그아웃을 하고 session에 id가 없는 경우에는 nullPointException이 발생한다
	 --%>
	 	
 	<%
		//게시판의 글이 내가 작성한 글이면 수정할수있게 해주기 & 삭제할수 있게 해주기
		if(id != null && id.equals(name)){
	%>
			<input type="button" value="게시글 수정하기" onclick="location.href='boardUpdate.jsp?Num=<%=Num%>'">
			<input type="button" value="게시글 삭제하기" onclick="location.href='boardDelete.jsp?Num=<%=Num%>'">
	<%
		}
	%>
		
	
		
		
		
		
		
		
	</form>
		</div>
		<jsp:include page="../include/footer.jsp"/>
</body>
</html>