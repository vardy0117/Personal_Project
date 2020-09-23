<%@page import="Member.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <link href=../css/joinStyle.css rel="stylesheet" type="text/css">

<title>동물미용 회원가입 화면</title>
</head>
<body>
	
	<script src="https://code.jquery.com/jquery-3.3.1.js"></script>
		<jsp:include page="../include/header.jsp"/>
<div id="body">
	<!-- 공백인 칸 처리 -->
	<script type="text/javascript">
	
	
	var mustIdCheck = false;	//	id중복체크 여부를 확인할 변수
	
	
	function checkAll() {	// 공백 처리 +유효성 검사 함수
		
		// .replace(/^\s+|\s+$/g, "")  <== 공백을 제거해주는 함수 
	
		
		// id 입력란이 공백일 경우 경고메세지 출력
		if(document.getElementById("id").value.replace(/^\s+|\s+$/g, "")==""){
			alert("아이디를 입력하세요");
			document.getElementById("id").focus();
			return false;
		}
		// pw 입력란이 공백일 경우 경고메세지 출력
		if(document.getElementById("pw").value.replace(/^\s+|\s+$/g, "")==""){
			alert("비밀번호를 입력하세요");
			document.getElementById("pw").focus();
			return false;
		}
		// checkPw 입력란이 공백일 경우 경고메세지 출력
		if(document.getElementById("checkPw").value.replace(/^\s+|\s+$/g, "")==""){
			alert("비밀번호 확인란을 입력하세요");
			document.getElementById("checkPw").focus();
			return false;
		}
		
		// name 입력란이 공백일 경우 경고메세지 출력
		if(document.getElementById("name").value.replace(/^\s+|\s+$/g, "")==""){
			alert("이름을 입력하세요");
			document.getElementById("name").focus();
			return false;
		}
		// email 입력란이 공백일 경우 경고메세지 출력
		if(document.getElementById("email").value.replace(/^\s+|\s+$/g, "")==""){
			alert("이메일을 입력하세요");
			document.getElementById("email").focus();
			return false;
		}
		// phone 입력란이 공백일 경우 경고메세지 출력
		if(document.getElementById("phone").value.replace(/^\s+|\s+$/g, "")==""){
			alert("휴대폰번호를 입력하세요");
			document.getElementById("phone").focus();
			return false;
		}
		// 주소 입력란이 공백일 경우 경고메세지 출력
		if(document.getElementById("address_code").value.replace(/^\s+|\s+$/g, "")==""){
			alert("주소를 입력하세요");
			document.getElementById("address_code").focus();
			return false;
		}
		// pw와 checkPw 의 값이 다를때
		if(document.getElementById("pw").value != document.getElementById("checkPw").value){
			alert("비밀번호를 다시 확인하세요");
			document.getElementById("checkPw").focus();
			return false;
		}
		
		
		/* 중복체크 기능을 하지 않으면 submit이 되지 않도록 */
		if(mustIdCheck == false){
			alert("중복체크를 하셔야 합니다.");
			return false;
		}
		
	/* -------------------------------------------------------------------------------- */	
		
		/* 정규표현식 */
		
		
		//아이디 정규식
		var idJ = /^[a-z0-9]{4,12}$/;	//a ~ z, 0~ 9로 시작하는 4~12자리 아이디
		// 이름 정규식
		var nameJ = /^[가-힣]{2,6}$/;	//가 ~힣 한글로만 된 이름 2~6자리
		// 휴대폰 번호 정규식
		var phoneJ = /^01([0|1|6|7|8|9]?)?([0-9]{3,4})?([0-9]{4})$/;	// '-' 생략
			
		if(!nameJ.test($("#name").val())){
			alert("이름을 다시 확인하세요");
			return false;
		}
		if(!phoneJ.test($("#phone").val())){
			alert("휴대폰 번호를 다시 확인하세요 (' - ' 생략)");
			return false;
		}
	
	}//checkAll()
	


	
	
	
	
	/* 
		중복체크 기능 구현 
		아이디 중복체크 버튼 클릭했을때 정규식에 맞는 양식으로 입력했는지 확인하고 맞지 않으면
		ajax까지 가지도 못한다
	*/
	function checkId() {
		
		//아이디 정규식
		var idJ = /^[a-z0-9]{4,12}$/;	//a ~ z, 0~ 9로 시작하는 4~12자리 아이디
		
		if(!idJ.test($("#id").val())){
 			alert("정규식에 맞지않는 아이디");
 			$("#id").focus();
 			return false;
 		}
		
		if($.trim($("#id").val())==""){
			alert("아이디 공백은 사용할수 없습니다.");
			$("#id").focus();
			return false;
		}
		
		var idCheck = $("#id").val();
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
		
	}//checkId()
	
	
	// id 중복검사후 <input id="id">태그에 값을 변경했을때 다시 중복검사를 하도록
	function reCheckId() {
		mustIdCheck=false;
	}
	
	
	
	</script>
	
	<!-- 회원가입 화면 -->
	
	<form action="joinPro.jsp" method="post" onsubmit="return checkAll()">
		<table align="center" id="joinTable">
			<tr>
				<th align="center" colspan="2"><h1>회원가입</h1></th>
			</tr>
			<tr>
				<td>
					아이디
				</td>
				<td>
					<input type="text" name="id" id="id" onkeydown="reCheckId()" placeholder="a ~ z, 0~ 9로 시작하는 4~12자리 아이디">
					<input type="button" value="아이디중복검사" onclick="checkId()" class="I">
				</td>
			</tr>	
			
			<tr>
				<td>
					비밀번호
				</td>
				<td>
					<input type="password" name="pw" id="pw">
				</td>
			</tr>
			
			<tr>
				<td>
					비밀번호 확인
				</td>
				<td>
					<input type="password" name="checkPw" id="checkPw">
				</td>
			</tr>
				
			<tr>
				<td>
					이름
				</td>
				<td>
					<input type="text" name="name" id="name" placeholder="ex) 홍길동">
				</td>
			</tr>	
				
			<tr>
				<td>
					이메일
				</td>
				<td>
					<input type="email" name="email" id="email">
				</td>
			</tr>	
				
			<tr>
				<td>
					휴대폰번호
				</td>
				<td>
					<input type="text" name="phone" id="phone" placeholder="ex) 01011111111">
				</td>
			</tr>	
			
			<tr>
				<td>
				
				<!-- 카카오 주소검색 API -->
				
			<tr>
				<td>주소</td>	
				<td><input type="text" id="address_code" name="address_code" readonly="readonly"></td>
				<td><input type="button" onclick="sample4_execDaumPostcode()" value="우편번호 찾기"></td><br>
			</tr>
			<tr>
				<td><label>&nbsp;</label></td>
				<td><input type="text" id="roadAddress" style="width:250px;" name="roadAddress" readonly="readonly"></td><br>
				<td><span id="guide" style="color:#999;display:none"></span></td>
				<td><label>&nbsp;</label></td>
			</tr>
			<tr>
				<td>상세 주소</td>
				<td><input type="text" id="detailAddress" style="width:250px;" name="detailAddress"></td>
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
	                document.getElementById('address_code').value = data.zonecode;
	                document.getElementById("roadAddress").value = roadAddr;
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
					<input type="submit" value="회원가입" class="btn">
					<input type="reset" value="다시입력" class="btn">
				</td>
			</tr>
		</table>
	</form>
	
	<p align="center">
		<small>
			모든 항목은 반드시 입력해야 합니다.<br>
			허위로 작성된 정보일 경우 승인이 보류되거나 임의로 삭제처리될 수 있으니 주의해 주세요.<br>
		</small>
	</p>

		
	
	
	
	
	
	
	
	
	
	
</div>	
	<jsp:include page="../include/footer.jsp"/>
</body>
</html>