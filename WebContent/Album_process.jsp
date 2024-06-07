<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>앨범 페이지</title>
</head>
<body>
<%@ page import="java.sql.*" %>

<%
    String loggedInUser = (String) session.getAttribute("id");

    if (loggedInUser == null) {
        // 로그인하지 않은 경우 로그인 페이지로 리다이렉트
        response.sendRedirect("Fanpage_login.jsp");
        return;
    }

    String sql = "SELECT * FROM jypuser WHERE id = ?";
    
    String driverName = "com.mysql.jdbc.Driver";
    String url = "jdbc:mysql://localhost:3307/jyp";
    String username = "root";
    String password = "dongyang";
    Connection conn = null;
    
    Class.forName(driverName);
    conn = DriverManager.getConnection(url, username, password);
    
    PreparedStatement sm = conn.prepareStatement(sql);
    sm.setString(1, loggedInUser);

    ResultSet rs = sm.executeQuery(); // SELECT 쿼리 실행
    
    boolean isAdmin = false; // 관리자 여부를 저장하는 변수
    if (rs.next()) {
        String username_result = rs.getString("id");
        if ("admin".equals(username_result)) {
            isAdmin = true;
        }
    } else {
        // 사용자가 존재하지 않는 경우
        response.sendRedirect("Fanpage_login.jsp");
        return;
    }

    rs.close();
    sm.close();
    conn.close();
%>

<% if (isAdmin) { %>
    <!-- 사진 업로드 폼 -->
    <input type="file" id="photoInput" accept="image/*">
    <button onclick="uploadPhoto()">사진 업로드</button>
    <br><br>
<% } %>

<!-- 댓글 작성 폼 -->
<textarea id="commentInput" placeholder="댓글을 입력하세요" rows="4" cols="50"></textarea>
<button onclick="postComment()">댓글 작성</button>

<!-- 업로드된 사진 표시 -->
<div id="photoDisplay"></div>

<!-- 댓글 표시 -->
<div id="commentDisplay"></div>

<script>
function uploadPhoto() {
    var photoInput = document.getElementById('photoInput');
    var photoDisplay = document.getElementById('photoDisplay');
    var file = photoInput.files[0];
    var reader = new FileReader();

    reader.onload = function(event) {
        var img = document.createElement('img');
        img.src = event.target.result;
        img.style.maxWidth = '300px'; // 이미지 최대 너비 설정
        photoDisplay.appendChild(img);
    };

    reader.readAsDataURL(file);
}

function postComment() {
    var commentInput = document.getElementById('commentInput');
    var commentDisplay = document.getElementById('commentDisplay');
    var comment = commentInput.value;

    var commentElement = document.createElement('p');
    commentElement.textContent = comment;
    commentDisplay.appendChild(commentElement);
}
</script>
</body>
</html>