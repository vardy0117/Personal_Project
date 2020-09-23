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
<%
		//로그인 되어있지 않으면 예약할수없다
		String id = (String)session.getAttribute("id");
		if(id==null){
%>
			<script type="text/javascript">
				alert("로그인 하셔야합니다.");
				location.href="../login/login.jsp";
			</script>
<%			
		}
%>

<center>
		<table align="center">
			<tr>
				<th><h2>Hair Cut & Grooming 예약하기</h2></th>
			</tr>
		</table>
		
		 <div class="main">
    <div class="content-wrap">
      <div class="content-right">
        <table id="calendar" align="center">
          <thead>
            <tr class="btn-wrap clearfix">
              <td>
                <label id="prev">
                    &#60;
                </label>
              </td>
              <td align="center" id="current-year-month" colspan="5"></td>
              <td>
                <label id="next">
                    &#62;
                </label>
              </td>
            </tr>
            <tr>
                <td class = "sun" align="center">Sun</td>
                <td align="center">Mon</td>
                <td align="center">Tue</td>
                <td align="center">Wed</td>
                <td align="center">Thu</td>
                <td align="center">Fri</td>
                <td class= "sat" align="center">Sat</td>
              </tr>
          </thead>
          <tbody id="calendar-body" class="calendar-body"></tbody>
        </table>
      </div>
    </div>
  </div>
  
  
  
  
  
  
  
  
		
		
		<div id="wrap">
			<div id="dogGroomImg">
				<img src="../img/dogGroom.jpg">
			</div>
			<form action="reserveDogGroomingPro.jsp">
				<table id="T">
					<tr>
						<th>예약 날짜</th> 
						<td><input type="text" name="date" id="dateInput" readonly="readonly" required></td>
					</tr>
					<tr>
						<th>예약 시간</th>
						<td>
							<select name="time">
								<option value="10">10:00</option>
								<option value="12">12:00</option>
								<option value="15">15:00</option>
							</select>
						</td>
					</tr>
					<tr>
						<th>강아지 이름</th>
						<td><input type="text" name="dogName" required></td>
					</tr>
					<tr>
						<th>추가 요청 사항</th>
						<td><input type="text" name="order" required></td>
					</tr>
					<tr>
						<td colspan="2" align="right"><input type="submit" value="예약하기" id="sm"></td>
					</tr>
					<tr>
						<th colspan="2" align="center"><small><mark>-빈칸 없이 입력 해주세요.-</mark></small></th>
					</tr>
					<tr>
						<th colspan="2" align="center"><small>-입질이 심한 친구는 추가요금이 발생합니다.-</small></th>
					</tr>
				</table>
			</form>
		</div>
</center>
<div style="clear:both;"></div>
	<br>
	<br>

	
</div>

<%-------------------------------------- 달력 자바스크립트  -----------------------------------------------%>
	<script type="text/javascript">
		var currentTitle = document.getElementById('current-year-month');
		var calendarBody = document.getElementById('calendar-body');
		var today = new Date();
		var first = new Date(today.getFullYear(), today.getMonth(), 1);
		var dayList = [ 'Sunday', 'Monday', 'Tuesday', 'Wednesday',
				'Thursday', 'Friday', 'Saturday' ];
		var monthList = [ 'January', 'February', 'March', 'April', 'May',
				'June', 'July', 'August', 'September', 'October',
				'November', 'December' ];
		var leapYear = [ 31, 29, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31 ];
		var notLeapYear = [ 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31 ];
		var pageFirst = first;
		var pageYear;
		if (first.getFullYear() % 4 === 0) {
			pageYear = leapYear;
		} else {
			pageYear = notLeapYear;
		}
		/* 달력을 보여주는 작업 */
		function showCalendar() {
			var current_year_month = document
					.getElementById('current-year-month');
			current_year_month.innerText = first.getFullYear()
					+ "-"
					+ (first.getMonth() + 1 > 9 ? first.getMonth() + 1
							: "0" + (first.getMonth() + 1));

			let monthCnt = 100;
			let cnt = 1;
			for (var i = 0; i < 6; i++) {
				var $tr = document.createElement('tr');
				$tr.setAttribute('id', monthCnt);
				for (var j = 0; j < 7; j++) {
					if ((i === 0 && j < first.getDay())
							|| cnt > pageYear[first.getMonth()]) {
						var $td = document.createElement('td');
						$tr.appendChild($td);
					} else {
						var $td = document.createElement('td');
						$td.textContent = cnt;
						$td.setAttribute('id', cnt);
						var yyyy = first.getFullYear();
						var MM = first.getMonth() + 1;
						MM = MM < 10 ? "0"+MM : MM;
						var dd = cnt;
						dd = dd < 10 ? "0"+dd : dd;
						$td.setAttribute('value', yyyy+"-"+MM+"-"+dd);
						$td.setAttribute("class", 'abled_td');
						/* $td.setAttribute('value', first.getFullYear() + "-"
								+ ((first.getMonth() + 1)<10?"0"+(first.getMonth() + 1):(first.getMonth() + 1)) + "-" + cnt <10?"0"+cnt:cnt); */
						
						$td.onclick = function(){
							if(new Date(this.getAttribute("value") + " 23:59:59") < new Date()) {
								alert("이전 날짜로 예약 할 수 없습니다.");
								return;
							}
							document.getElementById("dateInput").value=this.getAttribute("value");
							
							var tds = document.querySelectorAll('.abled_td');
							for(var i=0; i<tds.length; i++) {
								tds[i].setAttribute("class", "abled_td");
							}
							this.setAttribute("class", "abled_td clicked_td");
						};
						$tr.appendChild($td);
						cnt++;
					}
				}
				monthCnt++;
				calendarBody.appendChild($tr);

			}

		}

		showCalendar();
		/* 화면에있던 기존의 달력을 지우는 작업 */
		function removeCalendar() {
			let
			catchTr = 100;
			for (var i = 100; i < 106; i++) {
				var $tr = document.getElementById(catchTr);
				$tr.remove();
				catchTr++;
			}
		}
		
		/* > 버튼 클릭시 */
		var nextBtn = document.getElementById("next");
		nextBtn.addEventListener("click", function() {
			removeCalendar();
			first = new Date(today.getFullYear(), today.getMonth() + 1, 1);
			showCalendar();
			today = new Date(today.getFullYear(), today.getMonth() + 1, 1);
		});
		
		/* < 버튼 클릭시 */
		var prevBtn = document.getElementById("prev");
		prevBtn.addEventListener("click", function() {
			removeCalendar();
			first = new Date(today.getFullYear(), today.getMonth() - 1, 1);
			showCalendar();
			today = new Date(today.getFullYear(), today.getMonth() - 1, 1);
		})
	</script>

<%--푸터영역 --%>
<jsp:include page="../include/footer.jsp"/>
<%--푸터영역 --%>
</body>
</html>