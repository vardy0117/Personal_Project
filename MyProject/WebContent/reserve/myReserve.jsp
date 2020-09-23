<%@page import="Reserve.ReserveBean"%>
<%@page import="java.util.ArrayList"%>
<%@page import="Reserve.ReserveDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
   <link href=../css/reserveStyle.css rel="stylesheet" type="text/css">
<title>동물미용</title>
	<script src="https://code.jquery.com/jquery-3.3.1.js"></script>
</head>
<body>
<%--헤더영역 --%>
	<jsp:include page="../include/header.jsp"/>
<%--헤더영역 --%>
<div id="body">
	<div id="top"></div>
<center>
		<h2>나의 예약 정보</h2>
	<table border="1" width="800">
		<tr align="center" bgcolor="silver">
			<th>예약번호</th>
			<th>I D</th>
			<th>예약날짜</th>
			<th>예약시간</th>
			<th>강아지이름</th>
			<th>요청사항</th>
			<th>관리자읽음</th>
			<th>예약 현황</th>
		</tr>
<%
	//myReserve.jsp는 나의 예약 정보를 확인하는 페이지이다
	String id = (String)session.getAttribute("id");	
	ReserveDAO rDAO = new ReserveDAO();
	ArrayList<ReserveBean> list = rDAO.selectReserve(id);
	for(int i=0;i<list.size();i++){
		
		int num = list.get(i).getNum();
		
		out.println("<tr align='center' id='tbody'>");
		out.println("<td>");
		out.println(list.get(i).getNum());
		out.println("</td>");
		out.println("<td>");
		out.println(list.get(i).getId());
		out.println("</td>");
		out.println("<td>");
		out.println(list.get(i).getDate());
		out.println("</td>");
		out.println("<td>");
		out.println(list.get(i).getTime()+" 시");
		out.println("</td>");
		out.println("<td>");
		out.println(list.get(i).getDogname());
		out.println("</td>");
		out.println("<td>");
		out.println(list.get(i).getOrder());
		out.println("</td>");
		out.println("<td>");
		
		if(list.get(i).getReserve().equals("0")){
			
			out.println("접수 X");
			out.println("</td>");
		}else{
			out.println("접수 O");
			out.println("</td>");
		}
		out.println("<td>");
		if(list.get(i).getReserve().equals("1")){
			out.println("<small>예약완료</small>");
		}else{
			out.println("<input type='button' value='예약취소' onclick='cancel("+num+")'>");
		}
		out.println("</td>");
		out.println("</tr>");
	}
%>
	</table>
</center>
<script type="text/javascript">
	function cancel(num) {
		$.ajax(
				{
					url:"/MyProject/reserve/myReservePro.jsp",
					dataType:"text",
					data:{"num":num},
					success:function(data,textStatus){
						if(data==1){
							alert("취소완료");
							history.go(0);
						}else{
							alert("취소오류발생");
						}
						
						
					},
					error:function(data,textStatus){
						alert("ajax오류발생 : "+textStatus);
					}
					
				}		
			
			);
		
	}
</script>
	<!-- 플로팅 배너 -->
		<div class="floating"> 
			<h1><a href="#top">⬆</a></h1>
		    <h1><a href="#bottom">⬇</a></h1>
		</div>
		<div id="bottom"></div>


</div>
<%--푸터영역 --%>
<jsp:include page="../include/footer.jsp"/>
<%--푸터영역 --%>
</body>
</html>