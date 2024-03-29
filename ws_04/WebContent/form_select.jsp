<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
HOME > Language
<hr>
<form action="#" method="get">
<fieldset style="width:300px">
<legend>언어 선택</legend><p>
<select name="language" multiple>
<option value="choice">선택</option>
<option value="korean" selected>한국어</option>
<option value="english">영어</option>
<option value="chinese">중국어</option>
<option value="japanese">일본어</option>
<option value="spanish" disabled>스페인어</option>
</select>
</fieldset>
<select name="country">
<option value="choice">선택</option>
<optgroup label="본인 국적" disabled>
<option value="korea">대한민국</option>
<option value="USA">미국</option>
<option value="France">프랑스</option>
</optgroup>
<option value="Japan">일본</option>
<option value="Spanish">스페인어</option>
</select>
<textarea class="message_area" rows="3" cols="30">
</textarea>
</form>
</body>
</html>