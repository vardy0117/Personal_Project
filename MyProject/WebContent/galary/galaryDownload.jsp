<%@page import="java.io.OutputStream"%>
<%@page import="java.io.File"%>
<%@page import="java.io.FileInputStream"%>
<%@page import="java.net.URLEncoder"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>동물미용</title>
</head>
<body>
	<%
		//한글처리
		request.setCharacterEncoding("UTF-8");
		
	    //다운로드를 처리 하기 위해
	    //전달 받은 다운로드할 가상경로 와 다운로드할 파일명을 request내장객체 영역에서 얻기
	    String path  = request.getParameter("path");	//upload
	    String name  = request.getParameter("name");	//실제 다운로드할 파일명	(업로드된 파일명)
	    
	      
		//D:\workspace_jsp6\FileUpload\WebContent\	     
	    //String realPath = getServletContext().getRealPath("/");	
	   
	    //전달받은 다운로드할 가상경로 upload를  getRealPath()메소드로 전달후
	    //파일이 업로드된 위치인? 다운로드할 실제 경로를 얻어 온다.
	    //D:\workspace_jsp6\FileUpload\WebContent\ upload
	    String realPath = getServletContext().getRealPath("/" + path);
/*
(설명) 실행가능한 파일(.xml파일) 일지라도 무조건 다운로드 받게 처리 해야 하는데..
그러기 위해서는 ? 지금까지는  서버페이지가 클라이언트의 웹브라우저로 응답할때...
응답할 데이터  + 응답할 파일 데이터에 대한 헤더 정보
            (어떤형식,누구한테 전달,어떻게 만들어졌고,응답할 파일의 사이즈)등등...
응답할 파일 데이터의 헤더 정보 또한 같이 클라이언트의 웹브라우저에 전달 해야 한다.
 */
//다운로드할 파일을 서버에서 클라이언트의 웹브라우저로 내보내기 전에 response객체메모리의 영역중
//header영역에 내보낼 파일은 다운로드시키는 파일이다 라고 설정 해 놓아야 함
response.setContentType("Application/x-msdownload");//다운로드 문서형식으로 내보내겠다고 수정
 
//웹브라우저에서 다운로드할 파일명 클릭시..
//1.Content-disposition속성에 attachment;을 지정하여 
//다운로드시 무조건 "파일 다운로드" 대화상자가 뜨도록하는 헤더속성의 값 설정
//2.다운로드시킬 파일명을 넣는데... 
//파일명이 한글일경우  꺠지는 현상을 방지 하기위해 인코딩 방식을 UTF-8로 처리하여 설정
//Content-Disposition속성에 fileName=다운로드할 파일명

response.setHeader("Content-Disposition", 
				   "attachment; fileName=\"" + URLEncoder.encode(name,"UTF-8")+ "\";");
	    
/*
	Content-disposition속성  : attachment값
	웹브라우저 인식 파일 확장자를 포함하여 모든 확장자의 파일들에 대해,
	다운로드시 무조건 "파일 다운로드" 대화상자가 뜨도록 하는 헤더 속성
  
	Content-disposition속성 : inline값
	웹브라우저 인식 파일 확장자를 가진 파일들에 대해서는 웹브라우저 상에서 바로 파일을 열고
	그외의 파일들에 대해서 "파일 다운로드" 대화상자가 뜨도록 하는 헤데 속성
*/
	File f = new File(realPath + "\\" + name);
	
	//다운로드할 파일을 바이트 단위로 읽어 들일 버퍼공간 스트림 통로 생성
	FileInputStream inputStream  = new FileInputStream(f);
	
	//파일다운로드를 요청한 클라이언트의 웹브라우저로 읽어 들인 파일의 정보를 버퍼 메모리 공간에서 
	//내보내기 위한 출력 스트림통로 만들기
	OutputStream outputStream = response.getOutputStream();
	
	// 이미 존재하고 있는 out객체의 내용을 지워주는 메소드
	// 이 문장 전의 내용은 모두 출력되지 않고 버퍼의 내용이 지워진다.
	out.clear();
	out = pageContext.pushBody();
	
	
	//다운로드할 파일에서 데이터를 8KB씩 읽어와 저장할 용도의 byte단위의 배열 생성
	byte[] buffer = new byte[1024*8];

	while(true){
		//다운로드할 파일의 내용을 약 8kb단위만 한번 읽어와 변수에 저장
		int count = inputStream.read(buffer); 
		//더이상 파일에서 읽어 들일 값이 없으면 -1
		if(count == -1){
			break; //while반복문을 빠져 나감
		}
		//다운로드할 파일로 부터 읽어 들인 전체 용량중..8kb의 값이 존재하면
		//읽어 들인 0~8KB 까지 8KB를 출력 파일을 내려 받을수 있게 
		//스트림 통로로 내보내서 웹브라우저의 버퍼공간에 저장후 다운로드 시킨다. 
		outputStream.write(buffer,0,count);
	}
	//스트림 통로 해제
	inputStream.close();
	outputStream.close();
%>



</body>
</html>





