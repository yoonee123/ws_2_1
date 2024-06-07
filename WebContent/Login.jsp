<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Login</title>
</head>
<body>
	<form action="Loginprocess.jsp" name="login" method="post">

			<input type="text" name="id" placeholder="ID"><br><br>
			
			<input type="password" name="pw" placeholder="PASSWORD"><br><br>
			
			<input type="submit" value="로그인">
			<div style="margin-left:115px;"><a href="Signup.jsp">회원가입</a></div>
	</form>
</body>
</html>