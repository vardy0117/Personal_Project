<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href=../css/adminStyle.css rel="stylesheet" type="text/css">
<title>Insert title here</title>
	<script src="https://code.jquery.com/jquery-3.3.1.js"></script>
</head>
<body>
	<jsp:include page="../include/header.jsp"/>
	<div id="body">
	
	<!-- 회원정보를 조회해서 회원 탈퇴도 시킬수있는 관리자 페이지이다 -->
	<%
	
		// admin말고는 들어오지 못하도록 막는다 
		
		String id = (String)session.getAttribute("id");
		if(id == null || !id.equals("admin")){
	%>
			<script type="text/javascript">
				alert("비정상적인 접근입니다.");
				location.href="../main.jsp";
			</script>
	<%		
		}
	
	%>
	
	
	
	<script type="text/javascript">
	/* 회원정보 조회 클릭시 호출되는 함수로 ajax방식으로 DB의 회원정보를 조회해와서 띄워준다. */
	var isRun = false;	//상태변수
		function lookupMember() {
			
			if(isRun == true){
				return;
			}
			
			
			
			$.ajax(
					
				{
					url:"/MyProject/admin/allMemberSelect.jsp",
					dataType:"text",
					success:function(data,textStatus){
						var result=JSON.parse(data);
						var member=result.member;
						for(var i = 0; i<member.length;i++){
							$("#memberTable").append("<tr><th align='center' bgcolor='silver'>회원정보</th></tr><tr><td align='center'>"+member[i].id+" / "+member[i].pw+" / "+member[i].name+
									" / "+member[i].email+" / "+member[i].phone+" / "+member[i].address_code+" / "+member[i].roadAddress+" / "+member[i].detailAddress+"</td></tr>");
						}
						isRun = true;
					},
					error:function(data,textStatus){
						alert("에러발생 lookUpMember.jsp: "+textStatus)
					}
					
					
				}
			);
				
				
			
		}//lookupMember() 끝
		
		
		
		/* 회원강제 탈퇴 클릭시 새로운 창을 띄워서 회원의 아이디를 입력받고 회원 강제 탈퇴를 진행한다 */
		function winopen() {
			window.open("dropMember.jsp","","width=500px,height=100px ,top=100px ,left=500px");
		}
	</script>
	
	
	
	<table border="1" width="1000px" align="center" id="adminT">
		<tr>
			<th bgcolor="silver">ADMINISTRATOR</th>
		</tr>
		<tr>
			<td align="center"><a id="memberSearch" onclick="lookupMember()">회원정보 조회</a></td>
		</tr>
		<tr>
			<td align="center"><a onclick="winopen()">회원강제 탈퇴</a></td>
		</tr>
		<tr>
			<td align="center"><a onclick="location.href='../galary/galary.jsp'">갤러리 게시판 관리</a></td>
		</tr>
		<tr>
			<td align="center"><a onclick="location.href='../reserve/adminReserve.jsp'">미용 예약 관리</a></td>
		</tr>
	</table>
	<table id="memberTable" border="1" width="1000px" align="center">
	
	</table>
	
	
	</div>
	<jsp:include page="../include/footer.jsp"/>
</body>
</html>