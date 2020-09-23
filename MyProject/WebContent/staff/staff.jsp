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
   <link href=../css/staffStyle.css rel="stylesheet" type="text/css">
<title>동물미용</title>
	<script src="https://code.jquery.com/jquery-3.3.1.js"></script>
</head>
<body>
	<jsp:include page="../include/header.jsp"/>
	<div id="body">
	
		<div id="designer">
			<img src="../img/designer1.jpg" width="550">
			<img src="../img/designer2.jpg" width="550">
	    </div>
	    <div id="info">
	    	<div style=" height: 344.08px;">
	    		<h2 style="text-align: center">"Bonjour à tous"</h2>
				<small>
					Suspendisse potenti. Sed in consectetur libero. Quisque tristique interdum sapien,
					eget lobortis sem porta et. Vivamus nec magna eget est ullamcorper elementum. Mauris est augue,
					scelerisque viverra justo ut, pharetra auctor magna. Etiam turpis mi, hendrerit sed tempus ac, molestie et dolor.
					Praesent tempus erat ut libero fermentum, ac ultricies est mollis.
					Nunc sed tincidunt tellus, lacinia varius ex. Integer laoreet sit amet enim chez pulvinar. Donec ac mi placerat,
					sempre nibh non, eleifend neque. Praesent nec nisi quam. Praesent suscipit, nibh non convallis fermentum, mi felis finibus magna,
					un sempre tortor massa eu arcu.
			 	</small>
			 	<h2 style="text-align: center">Je vous remercie</h2>
			 </div>
			<img src="../img/designer3.jpg" width="550" id="lastImg">
	    </div>

 <!-- The Modal -->
    <div id="myModal" class="modal">
 
      <!-- Modal content -->
      <div class="modal-content">
            <p style="text-align: center;">
            	<span style="font-size: 14pt;">
            		<b><span style="font-size: 24pt;">공지</span></b>
            	</span>
            </p>
            
            <p style="text-align: center; line-height: 1.5;">
            	<br>COVID-19 로 인하여 디자이너가 부족합니다
            	<br>많은 디자이너들의 지원 바랍니다.
            	<br><a href="../hire/hire.jsp" style="text-align: center;">지원하기</a>
            </p>
            <p>
            	<br>
            </p>
                
            <div style="cursor:pointer; background-color:#DDDDDD; text-align: center; padding-bottom: 10px; padding-top: 10px;" onClick="close_pop();">
                <span class="pop_bt" style="font-size: 13pt;" >
                   	닫기
                </span>
            </div>
      </div>
 
    </div>
	
	 <script type="text/javascript">
      
        jQuery(document).ready(function() {
                $('#myModal').show();
        });
        //팝업 Close 기능
        function close_pop() {
             $('#myModal').hide();
        };
        
    </script>

	</div>
	<jsp:include page="../include/footer.jsp"/>
</body>
</html>