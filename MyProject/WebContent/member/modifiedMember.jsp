<%@page import="Member.MemberBean"%>
<%@page import="java.util.ArrayList"%>
<%@page import="Member.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>



<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<link href=../css/memberStyle.css rel="stylesheet" type="text/css">

<title>회원가입 화면</title>
</head>
<body>
	
<!-- modified 버튼을 클릭해서 회원정보 수정 -->
	<script src="https://code.jquery.com/jquery-3.3.1.js"></script>
		<jsp:include page="../include/header.jsp"/>
<div id="body">
	<!-- 공백인 칸 처리 -->
	<script type="text/javascript">
	
	
	
	
	function checkAll() {	// 공백 처리 +유효성 검사 함수
		
		// .replace(/^\s+|\s+$/g, "")  <== 공백을 제거해주는 함수 
	
		
		
		// pw 입력란이 공백일 경우 경고메세지 출력
		if(document.getElementById("newPw").value.replace(/^\s+|\s+$/g, "")==""){
			alert("비밀번호를 입력하세요");
			document.getElementById("newPw").focus();
			return false;
		}
		// checkPw 입력란이 공백일 경우 경고메세지 출력
		if(document.getElementById("newCheckPw").value.replace(/^\s+|\s+$/g, "")==""){
			alert("비밀번호 확인란을 입력하세요");
			document.getElementById("newCheckPw").focus();
			return false;
		}
		
		// name 입력란이 공백일 경우 경고메세지 출력
		if(document.getElementById("newName").value.replace(/^\s+|\s+$/g, "")==""){
			alert("이름을 입력하세요");
			document.getElementById("newName").focus();
			return false;
		}
		// email 입력란이 공백일 경우 경고메세지 출력
		if(document.getElementById("newEmail").value.replace(/^\s+|\s+$/g, "")==""){
			alert("이메일을 입력하세요");
			document.getElementById("newEmail").focus();
			return false;
		}
		// phone 입력란이 공백일 경우 경고메세지 출력
		if(document.getElementById("newPhone").value.replace(/^\s+|\s+$/g, "")==""){
			alert("휴대폰번호를 입력하세요");
			document.getElementById("newPhone").focus();
			return false;
		}
		// 주소 입력란이 공백일 경우 경고메세지 출력
		if(document.getElementById("newAddress_code").value.replace(/^\s+|\s+$/g, "")==""){
			alert("주소를 입력하세요");
			document.getElementById("newAddress_code").focus();
			return false;
		}
		// pw와 checkPw 의 값이 다를때
		if(document.getElementById("newPw").value != document.getElementById("newCheckPw").value){
			alert("비밀번호를 다시 확인하세요");
			document.getElementById("newCheckPw").focus();
			return false;
		}
		
		
		
		
	/* -------------------------------------------------------------------------------- */	
		
		/* 정규표현식 */
		
		
// 		//아이디 정규식
// 		var idJ = /^[a-z0-9]{4,12}$/;	//a ~ z, 0~ 9로 시작하는 4~12자리 아이디
// 		// 비밀번호 정규식
// 		var pwJ = /^[A-Za-z0-9]{4,12}$/; // A~Z, a~z,0~9로 시작하는 4~12자리 비밀번호
// 		// 이름 정규식
// 		var nameJ = /^[가-힣]{2,6}$/;	//가 ~힣 한글로만 된 이름 2~6자리
// 		// 휴대폰 번호 정규식
// 		var phoneJ = /^01([0|1|6|7|8|9]?)?([0-9]{3,4})?([0-9]{4})$/;	// '-' 생략
			
// 		if(!idJ.text($("#id").val())){
//  			alert("AS");
//  			return false;
//  		}
// 		if(!pwJ.text($("#pw").val())){
// 			alert("!!!!");
// 			return false;
// 		}
		
		
		
		
		
	
	}//checkAll()
	


	
	
	
	
	/* 중복체크 기능 구현 */
<%--	function checkId() {
		
	 	
		<%
		request.setCharacterEncoding("UTF-8");
		String id = request.getParameter("id");
		%>
		
		
		var s = document.getElementById("id").value;
		
		<%
		MemberDAO mDAO = new MemberDAO();
		int result = mDAO.checkId(%>s<%);%> 
		
		
		
		!!!!
		원래는 중복체크 button에 checkID.jsp를 onclick으로 설정해뒀다가 DAO의 check()메소드에서 result값을 리턴받는것 까지 성공했으나
		그 후에 도저히 어떻게 alert을 띄우고 마무리를해야할지 모르겠어서
		onclick="check()"메소드로 변경해서 시행했는데도
		위에 보이는 바와같이 자바 코드와 자바스크립트 코드의 혼동으로 도저히 마무리 지을수 없어서 
		결국 Ajax방식을 사용했다
		
		
		
		--%>
		
	<%-- 	var idCheck = $("#newId").val();
		
		
		if($.trim($("#newId").val())==""){
			alert("아이디 공백은 사용할수 없습니다.");
			$("#newId").focus();
			return false;
		}
		
		$.ajax(
				{
					
					url:"/MyProject/join/checkId.jsp",
					data:{id:idCheck},
					dataType:"text",
					success:function(data,textStatus){
						
							
						if(data == 1){
							alert("중복된 아이디 입니다");
						}else{
							alert("사용할수 있는 아이디입니다.");
							mustIdCheck = true;
						}
					},
					error:function(data,textStatus,errorThrown){
						alert("에러발생 : "+errorThrown);
						
					}
					
				
				}//json
				
			
			)//$.ajax
		
	}//checkId() --%>
	
	
	
	
	
	</script>
	




















<%
	//기존에 정보를 가져와서 <input>태그 안에 띄워준다
	String oldId = (String)session.getAttribute("id");

	//mDAO.selectOldMember()를 통해서 기존에 존재하던 회원정보를 <input>태그에 띄워준다.
	MemberDAO mDAO = new MemberDAO();
	MemberBean mb = mDAO.selectOldMember(oldId); 
	
	/* for(int i = 0;i<list.size();i++){
		
	} */
	
%>



<form action="modifiedMemberPro.jsp" method="post" onsubmit="return checkAll()">
		<table bgcolor="white" align="center">
			
			<tr>
				<td colspan="2" align="center"><h1>회원정보 수정</h1></td>
			</tr>
			
			<tr>
				<td>
					새 비밀번호
				</td>
				<td>
					<input type="password" name="newPw" id="newPw" value="<%=mb.getPw() %>">
				</td>
			</tr>
			
			<tr>
				<td>
					새 비밀번호 확인
				</td>
				<td>
					<input type="password" name="newCheckPw" id="newCheckPw">
				</td>
			</tr>
				
			<tr>
				<td>
					새 이름
				</td>
				<td>
					<input type="text" name="newName" id="newName" value="<%=mb.getName() %>">
				</td>
			</tr>	
				
			<tr>
				<td>
					새 이메일
				</td>
				<td>
					<input type="email" name="newEmail" id="newEmail" value="<%=mb.getEmail() %>">
				</td>
			</tr>	
				
			<tr>
				<td>
					새 휴대폰번호
				</td>
				<td>
					<input type="text" name="newPhone" id="newPhone" value="<%=mb.getPhone() %>">
				</td>
			</tr>	
			
			<tr>
				<td>
				
				<!-- 카카오 주소검색 API -->
				
			<tr>
			
				<td>새 주소</td>	
				<td><input type="text" id="newAddress_code" name="newAddress_code" readonly="readonly" value="<%=mb.getAddress_code()%>"></td>
				<td><input type="button" onclick="sample4_execDaumPostcode()" value="우편번호 찾기"></td>
			</tr>
			<tr>
				<td><label>&nbsp;</label></td>
				<td><input type="text" id="newRoadAddress" style="width:250px;" name="newRoadAddress" readonly="readonly" value="<%=mb.getRoadAddress()%>"></td><br>
				<td><span id="guide" style="color:#999;display:none"></span></td>
				<td><label>&nbsp;</label></td>
			</tr>
			<tr>
				<td>상세 주소</td>
				<td><input type="text" id="newDetailAddress" style="width:250px;" name="newDetailAddress"></td>
			</tr>
	<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	<script>
	    //본 예제에서는 도로명 주소 표기 방식에 대한 법령에 따라, 내려오는 데이터를 조합하여 올바른 주소를 구성하는 방법을 설명합니다.
	    function sample4_execDaumPostcode() {
	        new daum.Postcode({
	            oncomplete: function(data) {
	                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
	
	                // 도로명 주소의 노출 규칙에 따라 주소를 표시한다.
	                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
	                var roadAddr = data.roadAddress; // 도로명 주소 변수
	                var extraRoadAddr = ''; // 참고 항목 변수
	
	                // 법정동명이 있을 경우 추가한다. (법정리는 제외)
	                // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
	                if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
	                    extraRoadAddr += data.bname;
	                }
	                // 건물명이 있고, 공동주택일 경우 추가한다.
	                if(data.buildingName !== '' && data.apartment === 'Y'){
	                   extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
	                }
	                // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
	                if(extraRoadAddr !== ''){
	                    extraRoadAddr = ' (' + extraRoadAddr + ')';
	                }
	
	                // 우편번호와 주소 정보를 해당 필드에 넣는다.
	                document.getElementById('newAddress_code').value = data.zonecode;
	                document.getElementById("newRoadAddress").value = roadAddr;
	                //document.getElementById("sample4_jibunAddress").value = data.jibunAddress;
	                
	                // 참고항목 문자열이 있을 경우 해당 필드에 넣는다.
	                /* if(roadAddr !== ''){
	                    document.getElementById("sample4_extraAddress").value = extraRoadAddr;
	                } else {
	                    document.getElementById("sample4_extraAddress").value = '';
	                } */
	
	                var guideTextBox = document.getElementById("guide");
	                // 사용자가 '선택 안함'을 클릭한 경우, 예상 주소라는 표시를 해준다.
	                if(data.autoRoadAddress) {
	                    var expRoadAddr = data.autoRoadAddress + extraRoadAddr;
	                    guideTextBox.innerHTML = '(예상 도로명 주소 : ' + expRoadAddr + ')';
	                    guideTextBox.style.display = 'block';
	
	                } else if(data.autoJibunAddress) {
	                    var expJibunAddr = data.autoJibunAddress;
	                    guideTextBox.innerHTML = '(예상 지번 주소 : ' + expJibunAddr + ')';
	                    guideTextBox.style.display = 'block';
	                } else {
	                    guideTextBox.innerHTML = '';
	                    guideTextBox.style.display = 'none';
	                }
	            }
	        }).open();
	    }
	</script><br>
				</td>
			</tr>
			
			<tr>
				<td></td>
				<td>
					<input type="submit" value="회원정보수정" class="btn">
					<input type="reset" value="다시입력" class="btn">
				</td>
			</tr>
		</table>
	</form>


</div>
<jsp:include page="../include/footer.jsp"/>
</body>
</html>