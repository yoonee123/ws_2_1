<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.SQLException" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title> JDBC 커넥션 테스트 </title>
</head>
<body>
	<%
		// 1. 변수 4개 선언
		String driverName="com.mysql.cj.jdbc.Driver";
		String url = "jdbc:mysql://localhost:3307/odbo";
		String username = "root";
		String password = "dongyang";
		Connection connection = null;
		try{
			// 2. 드라이버 로딩	
			Class.forName(driverName);
			// 3. 연동
			connection = DriverManager.getConnection(url, username, password);
			// 4. 사용
			out.println(">> 연결 성공 : " + connection);
		} catch(ClassNotFoundException e){
			out.println(">> 연결 실패 : 드라이버 복사 필요!");			
		} catch(SQLException e){
			out.println(">> 연결 실패 : SQL 명령문 확인 필요!");
		} finally{
			// 5. 닫기
			try{
				if(connection != null)
					connection.close();
			} catch(SQLException e){
				;
			}
		}
	%>
</body>
</html>