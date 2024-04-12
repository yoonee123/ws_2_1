<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="java.util.*, java.text.SimpleDateFormat" %>  
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title> 로그인 결과 화면 </title>
</head>
<body>
	Home > 로그인 결과
	<hr>
		<%
		String u_id = request.getParameter("id");
		String u_pw = request.getParameter("passwd");
		
		if(u_id.equals("seoyoon") && u_pw.equals("1111"))
		{
			session.setAttribute("memberId", u_id);
			session.setAttribute("memberPw", u_pw);
			
			out.println(" " + u_id + " 님 환영합니다. <br><br>");
			
			long last_time = session.getLastAccessedTime();
			Date last_date = new Date(last_time);
			String pattern = "yyyy-MM-dd HH:mm";
			SimpleDateFormat sdf = new SimpleDateFormat(pattern);
			String format_date = sdf.format(last_date);	
		
			out.println("마지막 접속 시간 : "+format_date+"");
		}
		else
		{
			out.println("로그아웃 실패 ! <br>");
			out.println("다시 시도해 보세요.");
		}
	%>
	 <br><br><button onclick="location.href='test_06_04_03.jsp'">로그아웃</button>
</body>
</html>