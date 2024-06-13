<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>앨범 보기 페이지</title>
</head>
<body>

<h2>업로드된 사진</h2>

<!-- 업로드된 사진을 표시할 영역 -->
<div id="photoDisplay">
    <%
        // MySQL 데이터베이스 연결 정보 설정
        String driverName = "com.mysql.jdbc.Driver";
        String url = "jdbc:mysql://localhost:3306/jyp";
        String username = "root";
        String password = "dongyang";

        // JDBC 드라이버 로드
        Class.forName(driverName);
        // 데이터베이스 연결
        Connection conn = DriverManager.getConnection(url, username, password);
        
        // 업로드된 사진 경로를 조회하는 SQL 쿼리
        String photoSql = "SELECT * FROM photos";
        Statement photoStmt = conn.createStatement();
        ResultSet photoRs = photoStmt.executeQuery(photoSql);
        
        // 각 사진을 반복하여 표시
        while (photoRs.next()) {
            String photoPath = photoRs.getString("path");  // 사진 경로
            int photoId = photoRs.getInt("id");  // 각 사진의 고유 ID
    %>
    <div>
        <!-- 사진을 화면에 표시 -->
        <img src='<%= photoPath %>' style='max-width: 300px;'><br>
        
        <!-- 댓글 작성 폼 -->
        <form id="commentForm_<%= photoId %>" method="post">
            <!-- 숨겨진 필드에 사진 ID를 저장 -->
            <input type="hidden" name="photoId" value="<%= photoId %>">
            <!-- 댓글 입력 필드 -->
            <input type="text" name="comment" placeholder="댓글을 입력하세요">
            <!-- 댓글 작성 버튼 -->
            <button type="submit">댓글 작성</button>
        </form>
        
        <!-- 댓글 목록을 표시할 영역 -->
        <div id="commentDisplay_<%= photoId %>">
            <% // 특정 사진에 대한 댓글을 조회하여 표시
                String commentSql = "SELECT * FROM album_comments WHERE photo_id = ?";
                PreparedStatement commentStmt = conn.prepareStatement(commentSql);
                commentStmt.setInt(1, photoId);
                ResultSet commentRs = commentStmt.executeQuery();
                
                // 각 댓글을 반복하여 표시
                while (commentRs.next()) {
                    String commentContent = commentRs.getString("content");  // 댓글 내용
            %>
            <!-- 댓글 내용 표시 -->
            <p><%= commentContent %></p>
            <%
                }
                
                commentRs.close();
                commentStmt.close();
            %>
        </div>
    </div>
    <% } %>
</div>

<%
    // 데이터베이스 연결 종료
    conn.close();
%>

<script>
<%
    // 댓글 작성 후 처리 로직
    if ("POST".equalsIgnoreCase(request.getMethod())) {
        // 요청 파라미터에서 사진 ID와 댓글 내용 가져오기
        int photoId = Integer.parseInt(request.getParameter("photoId"));
        String commentContent = request.getParameter("comment");
        
        // 데이터베이스에 댓글 저장
        Class.forName(driverName);
        Connection conn2 = DriverManager.getConnection(url, username, password);
        String insertCommentSql = "INSERT INTO album_comments (photo_id, content) VALUES (?, ?)";
        PreparedStatement insertCommentStmt = conn2.prepareStatement(insertCommentSql);
        insertCommentStmt.setInt(1, photoId);
        insertCommentStmt.setString(2, commentContent);
        insertCommentStmt.executeUpdate();
        
        insertCommentStmt.close();
        conn2.close();

        // 댓글 작성 후 페이지 다시 로드하여 갱신된 댓글 표시
        response.sendRedirect(request.getRequestURI());
    }
%>
</script>
</body>
</html>
