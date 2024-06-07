<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Sign up</title>
</head>
<body>
	<form action="Signupok.jsp" name="signup" method="post">
	
			<input type="text" name="username" placeholder="NAME"><br><br>
			
			<input type="text" name="userid" placeholder="ID (6 ~ 12)"><br><br>
			
			<input type="password" name="userpw" placeholder="PASSWORD (8 ~ 20)"><br><br>
			
			<input type="password" name="userpwcheck" placeholder="PASSWORD CHECK"><br><br>

			<input type="submit" value="회원가입">
	</form>
</body>
</html>