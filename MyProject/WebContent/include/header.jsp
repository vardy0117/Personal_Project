<%@page import="Reserve.ReserveBean"%>
<%@page import="java.util.ArrayList"%>
<%@page import="Reserve.ReserveDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%
	ReserveDAO rDAO = new ReserveDAO();
	ArrayList<ReserveBean> list =  rDAO.selectAll();
	int count = 0;
	for(int i = 0; i<list.size(); i++){
		if(list.get(i).getReserve().equals("0")) count++;
		
	}


 
 %>
    <header>
	<div id="header">
			<div id="headerImg">
				<input type="image" src="../img/logoFinal.png" id="dogImg"
				onclick="location.href='../main.jsp'">
				
			
			
			
<%	
	String id = (String)session.getAttribute("id");

	if(id == null){	// session값에 id가 저장되어 있지 않을 경우 ( 로그인 하지 않았을 경우)

%>		
			<div class="loginJoin">
				<a href="../join/join.jsp">JOIN</a>
				<a href="../login/login.jsp">LOGIN</a>
			</div>
<%
	
	}else if(id.equals("admin")){	//id가 admin (관리자 계정) 이면
%>
		
		<div class="loginJoin">
				<h4>관리자 계정입니다.</h4>
				<a href="../login/logout.jsp">LOGOUT</a>
				<a href="../member/modifiedMember.jsp">MODIFIED</a>
				<a href="../admin/lookUpMember.jsp">ADMIN</a>
				<a href="../reserve/adminReserve.jsp">새로운 예약 [<%=count %>]</a>
			</div>
	
	
	
<%	
	}else if(id != null){	//session값에 id가 저장되어 있을 경우(로그인 했을 시)
%>
			<div class="loginJoin">
				<h4>WELCOME ... <%=id %></h4>
				<a href="../login/logout.jsp">LOGOUT</a>
				<a href="../member/modifiedMember.jsp">MODIFIED</a>
				<a href="../member/deleteMember.jsp">SECESSION</a>
				<a href="../reserve/myReserve.jsp">RESERVE</a>
			</div>
		
<%
	}
	
%>		
		<div id="menu">
					<a href="../map/map.jsp" style="margin: 0 auto; padding:auto; margin-right:40px;">찾아오는길</a>
					<a href="../board/boardList.jsp" style="margin: 0 auto; padding:auto; margin-right:40px;">문의사항</a>
					<a href="../staff/staff.jsp" style="margin: 0 auto; padding:auto; margin-right:40px;">디자이너 소개</a>
					<a href="../galary/galary.jsp" style="margin: 0 auto; padding:auto; margin-right:40px;">미용완료사진</a>
					<a href="../reserve/reserve.jsp" style="margin: 0 auto; padding:auto; margin-right:40px;">예약하기</a>
		</div>		

		</div>
		<br>
		<br>
		<hr>
	</header>
	
	