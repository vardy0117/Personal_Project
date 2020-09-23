
<%@page import="Reserve.ReserveBean"%>
<%@page import="java.util.ArrayList"%>
<%@page import="Reserve.ReserveDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
  
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<link href="css/mainStyle.css" rel="stylesheet" type="text/css">
	<script src="https://code.jquery.com/jquery-3.3.1.js"></script>


<title>동물미용</title>
</head>
<body>
	<header>
 		<div id="header">
			
			<div id="headerImg">
				<input type="image" src="img/logoFinal.png" id="dogImg" class="dog">
  <%
  
  
  	//새로운 예약 개수 보여주는
    	ReserveDAO rDAO = new ReserveDAO();
    	ArrayList<ReserveBean> list =  rDAO.selectAll();
    	int count = 0;
    	for(int i = 0; i<list.size(); i++){
    		if(list.get(i).getReserve().equals("0")){
    			count++;
    		}
    	}
    
    
    %>			
			
			
<%	
	String id = (String)session.getAttribute("id");

	if(id == null){	// session값에 id가 저장되어 있지 않을 경우 ( 로그인 하지 않았을 경우)

%>		
			<div class="loginJoin">
				<a href="join/join.jsp">JOIN</a>
				<a href="login/login.jsp">LOGIN</a>
			</div>
<%
	
	}else if(id.equals("admin")){	//id가 admin (관리자 계정) 이면
%>
		
		<div class="loginJoin">
				<h4>관리자 계정입니다.</h4>
				<a href="login/logout.jsp">LOGOUT</a>
				<a href="member/modifiedMember.jsp">MODIFIED</a>
				<a href="admin/lookUpMember.jsp">ADMIN</a>
				<a href="reserve/adminReserve.jsp">새로운 예약 [<%=count %>]</a>
			</div>
	
	
	
<%	
	}else if(id != null){	//session값에 id가 저장되어 있을 경우(로그인 했을 시)
%>
			<div class="loginJoin">
				<h4>WELCOME ... <%=id %></h4>
				<a href="login/logout.jsp">LOGOUT</a>
				<a href="member/modifiedMember.jsp">MODIFIED</a>
				<a href="member/deleteMember.jsp">SECESSION</a>
				<a href="reserve/myReserve.jsp">RESERVE</a>
			</div>
		
<%
	}
	
%>		

				
			</div>
		</div>
		<div id="menu">
			<a href="map/map.jsp">찾아오는길</a>
			<a href="board/boardList.jsp">문의사항</a>
			<a href="staff/staff.jsp">디자이너 소개</a>
			<a href="galary/galary.jsp">미용완료사진</a>
			<a href="reserve/reserve.jsp">예약하기</a>
		</div>		
	</header>
	<br>
	<hr>
	
	
	<div class="slide_box mySlides">
		<div id="dogInfo">
		<ul>
			<li style="list-style: none; text-align: center;">
				<span>SOME HAPPY CLIENTS</span>
			</li>
		</ul>
		</div>
		
		<ul class="slide_wrap" id="sl">
			<li class="slide_item" id="img1">
				<a href="#">
					<img src="img/supportDog1-removebg-preview.png"
						onmouseover="this.src='img/support.png'"
						onmouseout="this.src='img/supportDog1-removebg-preview.png'">
				</a>
			</li>
			
			<li class="slide_item" id="img2">
				<a href="#">
					<img src="img/supportDog2-removebg-preview.png" 
						onmouseover="this.src='img/support2.png'"
						onmouseout="this.src='img/supportDog2-removebg-preview.png'">
				</a>
			</li>
			
			<li class="slide_item" id="img3">
				<a href="#">
					<img src="img/supportDog3-removebg-preview.png" 
						onmouseover="this.src='img/supportDogInfo3.png'"
						onmouseout="this.src='img/supportDog3-removebg-preview.png'">
				</a>
			</li>
			
			<li class="slide_item" id="img4">
				<a href="#">
					<img src="img/blackDog2-removebg-preview.png"
						onmouseover="this.src='img/supportDogInfo4.png'"
						onmouseout="this.src='img/blackDog2-removebg-preview.png'">
				</a>
			</li>
		</ul>
	</div>
	
	
	
	
	
	
	
	
	
	
	<%-- 
		슬라이드 방식으로 메인 이미지 구현 
		(화면이 슬라이드 되는데 마우스를 올렸을때 화면이 정지되고
		다시 마우스를 밖으로 뺐을때 다시 슬라이드 시작된다)	
	--%>
    <script>
        var ul = document.querySelector('.slide_wrap');
 		var rep = null;
 		var curIndex = 0;
        function move(){
 
         	rep = setInterval(startInterval,2500);
        
         	
         	$(".slide_item").mouseout(function(e) {
         		clearInterval(rep);
         		rep = setInterval(startInterval,2500);
         	});
         	
         	//이미지에 마우스를 올렸을때clearInterval로 슬라이드 정지
         	 $(".slide_item").mouseover(function(e){
     				clearInterval(rep);
     				rep = null;
             });//마우스 오버시 setInterval 멈춤
             
             //그러나 문제는 다시 마우스를올렸을때 동작이 실행되지않음
        }
        
        
        function startInterval() {
        		
               ul.style.transition = '1.0s';
               ul.style.transform = "translate3d(-"+1100*(curIndex+1)+"px, 0px, 0px)";

               curIndex++;

               if(curIndex === 3){
                   curIndex = -1;
               };

        }
        
        
        document.addEventListener("DOMContentLoaded",function(){
            move();
        });
        
       
        
        
       
    </script>
	
	
	
	
	<!-- footer 들어가는곳 -->
		<jsp:include page="include/footer.jsp"/>
	<!-- footer 들어가는곳 -->
</body>
</html>