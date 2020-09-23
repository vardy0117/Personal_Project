
<%@page import="java.util.ArrayList"%>
<%@page import="java.io.File"%>
<%@page import="java.util.Enumeration"%>
<%@page import="Galary.GalaryBean"%>
<%@page import="Galary.GalaryDAO"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<!-- DB와 연동해서 갤러리게시판 글을 저장 -->
	<%
	// 현재 실행중인 웹프로젝트에 대한 정보 지니고있는 객체 생성
	ServletContext ctx = getServletContext();	
	
	//업로드되는 실제 경로 반환
	String realPath = ctx.getRealPath("/upload");
	
	//업로드할수있는 파일의 최대 용량 지정(100mb)
	int max =  100 * 1024 *1024;
	
	MultipartRequest multi =
			new MultipartRequest(request,realPath,max,"UTF-8",new DefaultFileRenamePolicy());
	
	//getUpload.jsp에서 입력한 작성자,글제목,글내용 얻기
	String name = multi.getParameter("name");	
	String subject = multi.getParameter("subject");
	String content = multi.getParameter("content");
	content = content.replace("\r\n", "<br>");	// 엔터키 적용 작업
// 	out.println(name+","+subject+","+content);
	
// 	out.println("<hr/>");
	
	// form 태그에서 파일 업로드를 하기위해서
	// <input type="file" name="upFile1">태그
	// <input type="file" name="upFile2">태그
	// <input type="file" name="upFile3">태그
	// 를 선택후 파일 업로드를 요청했다.
	
	// 위 <input>태그의 name속성값을 얻어 Enumeration반복기 역할을 하는 객체에 저장후 반환
	//	Enumeration반복기 객체 자체를 반환
	
	Enumeration e = multi.getFileNames();
	
	while(e.hasMoreElements()){	//위의 <input>태그의 name속성값들이 Enumeration반복기객체에 저장되어 있는 동안 반복
		//파일 업로드를 하기위해 선택했던 <input>태그의 name속성값을 Enumeration반복기 안에서 꺼내옵니다
		String fileName =(String) e.nextElement();
// 		out.println("클라이언트가 업로드한 파일의 원본이름 :" 
// 						+ multi.getOriginalFileName(fileName)+"<br>");
		
// 		out.println("서버에 실제로 업로드한 파일의 이름 : "
// 						+multi.getFilesystemName(fileName)+"<br>");
		
		//out.println("업로드드한 파일의 타입 : "
		//				+multi.getContentType(fileName)+"<br>");
		
		//서버에 업로드된 파일에 접근하기 위해 File객체 얻기
		
		File f = multi.getFile(fileName);
		
		//out.println("업로드한 파일의 크기 : "+f.length()+"byte <br>");
		
		
		//DB에 연결해서 insert작업
		GalaryBean gBean = new GalaryBean(name,subject,multi.getFilesystemName(fileName),content);
		GalaryDAO gDAO = new GalaryDAO();
		gDAO.insertGalary(gBean);
	}
	%>
	<script type="text/javascript">
	
		alert("게시글이 등록 되었습니다.");
		location.href="galary.jsp";
	</script>
	
	
</body>
</html>