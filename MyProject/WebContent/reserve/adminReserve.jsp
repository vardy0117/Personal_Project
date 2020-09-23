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
	<jsp:include page="../include/header.jsp"/>
<div id="body">
	<div id="top"></div>

	<center>
		<h2>Hair Cut & Grooming예약 관리</h2>
		<table>
			<tr>
				<th>예약번호</th>
				<th>I D</th>
				<th>예약날짜</th>
				<th>예약시간</th>
				<th>강아지이름</th>
				<th>추가사항</th>
				<th colspan="2">접수&취소</th>
			</tr>
			
		
<%
	//admin이 미용예약관리 <a>태그를 클릭했을때 이동되는 페이지로 모든 예약을 관리한다
	
	// 1. DB에 저장되어있는 모든 예약 정보들을 가져온다
	
	ReserveDAO rDAO = new ReserveDAO();
	ArrayList<ReserveBean> list =  rDAO.selectAll();
	
	for(int i = 0;i<list.size();i++){
		
		
		int num = list.get(i).getNum();
		System.out.println(num);
		out.println("<tr align='center'>");
		out.println("<td id='memberNum'>");
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
		if(list.get(i).getReserve().equals("1")){
	 		out.println("<input type='button' value='접수완료' name='yes' id='btn_"+num+"' onclick='submit("+num+")' disabled='disabled'>");
		}else{
	 		out.println("<input type='button' value='접수' name='yes' id='btn_"+num+"' onclick='submit("+num+")'>");
		out.println("<td>");
	 		out.println("<input type='button' value='취소' name='yes' id='btnC_"+num+"' onclick='cancel("+num+")'>");
		}
		out.println("</td>");
			
	}	//for문
%>	
		<script type="text/javascript">
		
			function submit(num) {
 				
	
				$.ajax(
					{
						url:"/MyProject/reserve/adminReservePro.jsp",
						dataType:"text",
						data:{"num":num},
						success:function(data,textStatus){
							if(data==1){
								alert("접수완료");
								$('#btn_'+num).attr("disabled", "disabled");
								history.go();
							}else{
								alert("접수오류발생");
							}
						},
						error:function(data,textStatus,error){
							alert("ajax오류발생 : "+textStatus+"/"+error);
						}
						
					}		
				
				);
				
			
			}
			
			function cancel(num) {
				$.ajax(
						{
							url:"/MyProject/reserve/adminReserveCancelPro.jsp",
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

		</table>
	</center>
	
	<%-- <script type="text/javascript">
		function submit(num) {
		<%
			// 예약접수 버튼을 클릭했을때 DB와 연동해서 check컬럼의 값을 1로 변경해준다
			
			rDAO.submit();
		%>
		}
		
		js 변수를 java로 받을수 없어서 포기
	</script> --%>
	
	
	
	<!-- 플로팅 배너 -->
	<div class="floating"> 
		<h1><a href="#top">⬆</a></h1>
	    <h1><a href="#bottom">⬇</a></h1>
	</div>
	
	
	<script type="text/javascript">
// 		 if($("#memberNum").indexOf(  $("#search_num").val())){
// 			 alert("AAA");
// 		 }
		 if(document.getElementById("memberNum").match(document.getElementById("search_num").value)!= -1  ){
			 alert("H");
		 }
	</script>
	
	<div id="bottom"></div>
</div>
	<jsp:include page="../include/footer.jsp"/>
</body>
</html>