<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title> 데이터 형식의 유효성 검사 애플리케이션 </title>
	<script type="text/javascript">
		function test() 
		{
			var f = document.loginForm;
			
			var name = f.sname.value;
			var regExpName = /^[a-zA-Z\u3131-\uD79D]+$/;

			var pw = f.passwd.value;
			var regExpPasswd = /^.{8,16}$/;
			
			var user = f.uname.value;
			var regExpUser = /.{1,}/;
			
			var age = f.uage.value;
			var regExpAge = /^\d+$/;
			
			var phone = f.pnumber.value;
			var regExpPhone = /^\d{3}-\d{3,4}-\d{4}$/;
			
			if(!regExpName.test(name))
			{
				alert("닉네임은 영문 또는 한글만 입력하세요.");
				f.sname.focus();
				return false;
			}
			if(!regExpPasswd.test(pw))
			{
				alert("비밀번호는 8자리 이상 16자리 미만만 입력해 주세요.");
				f.passwd.focus();
				return false;
			}	
			if(!regExpUser.test(user))
			{
				alert("작성자는 필수로 입력하세요.")
				f.uname.focus();
				return false;
			}
			if(!regExpAge.test(age))
			{
				alert("나이는 숫자로만 입력하세요.")
				f.uage.focus();
				return false;
			}
			if(!regExpPhone.test(phone))
			{
				alert("핸드폰 번호 형식으로만 입력하세요. ex.(010-1234-5678)")
				f.pnumber.focus();
				return false;
			}
			else return true;
		}		
	</script>
</head>
<body>
	Home > 닉네임과 비밀번호 입력
	<hr>
	<form name="loginForm" action="test05_05.jsp" 
		method="post" onsubmit="return test()">
		닉네임 : <br> 
		<input type="text" name="sname"><br><br>
		비밀번호 : <br> 
		<input type="password" name="passwd"><br><br>	
		작성자 : <br>
		<input type="text" name="uname"><br><br>
		나이 : <br>
		<input type="text" name="uage"><br><br>	
		핸드폰 번호 : <br>
		<input type="text" name="pnumber"><br><br>
		<input type="submit" value=" 신청하기 ">
	</form>
</body>
</html>