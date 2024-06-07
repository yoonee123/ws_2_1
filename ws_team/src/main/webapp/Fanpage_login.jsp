<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title> 연락처 </title>
</head>
<body>
	Home > Type your Phone number
	<hr>
	<form action="login_process.jsp" name="user_info" method="post">
		<fieldset style="width:200px">
			<legend> 회원가입 </legend><p>
	
			아이디 : <br>
			<input type="text" name="username"><br><br>
		
			비밀번호 : <br> 
			<input type="password" name="userpnum"><br><br>
					
		<div align="center">
			<input type="submit" value=" 등록 "> &nbsp;&nbsp;
			<input type="reset" value=" 다시작성 ">
		</div><br>
		</fieldset>
	</form>
</body>
</html>