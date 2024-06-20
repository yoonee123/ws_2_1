<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.text.SimpleDateFormat" %>
<!DOCTYPE html>
<html>
<head>
    <title>앨범 상세 페이지</title>
</head>
<body>

<!-- Main.jsp로 돌아가는 버튼 -->
<form action="Main.jsp" method="get">
    <button type="submit">처음으로 돌아가기</button>
</form>

<h2>사진 상세보기</h2>

<!-- 업로드된 사진을 표시할 영역 -->
<div id="photoDisplay">
    <%
        // MySQL 데이터베이스 연결 정보 설정
        String driverName = "com.mysql.cj.jdbc.Driver";
        String url = "jdbc:mysql://localhost:3306/jyp";
        String username = "root";
        String password = "dongyang";

        // JDBC 드라이버 로드
        Class.forName(driverName);
        // 데이터베이스 연결
        Connection conn = DriverManager.getConnection(url, username, password);
        
        // URL 파라미터에서 사진 ID를 가져옴
        int photoId = Integer.parseInt(request.getParameter("photoId"));
        
        // 특정 사진의 경로 및 업로드 시간을 조회하는 SQL 쿼리
        String photoSql = "SELECT * FROM photos WHERE id = ?";
        PreparedStatement photoStmt = conn.prepareStatement(photoSql);
        photoStmt.setInt(1, photoId);
        ResultSet photoRs = photoStmt.executeQuery();
        
        if (photoRs.next()) {
            String photoPath = photoRs.getString("path");  // 사진 경로
            Timestamp createdAt = photoRs.getTimestamp("created_at"); // 사진 업로드 시간
            
            // SimpleDateFormat을 사용하여 원하는 형식으로 시간을 변환
            SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm");
            String formattedCreatedAt = dateFormat.format(createdAt);
    %>
    <div>
        <!-- 사진을 화면에 표시 -->
        <img src='<%= photoPath %>' style='max-width: 300px;'><br>
        <!-- 사진 업로드 시간 표시 -->
        <p><i>작성 시간: <%= formattedCreatedAt %></i></p>
        
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
                    String commenter = commentRs.getString("commenter");  // 댓글 작성자 이름
                    String commentContent = commentRs.getString("content");  // 댓글 내용
            %>
            <!-- 댓글 내용 표시 -->
            <p><%= commenter + ": " + commentContent %></p>
            <%
                }
                
                commentRs.close();
                commentStmt.close();
            %>
        </div>
    </div>
    <% 
        } else {
            out.println("<p>사진을 찾을 수 없습니다.</p>");
        }

        photoRs.close();
        photoStmt.close();
        conn.close();
    %>
</div>

<%
    // 댓글 작성 후 처리 로직
    if ("POST".equalsIgnoreCase(request.getMethod())) {
        // 요청 파라미터에서 사진 ID와 댓글 내용 가져오기
        String commentContent = request.getParameter("comment");

        // 세션에서 사용자 이름 가져오기
        String commenter = (String) session.getAttribute("id");

        if (commenter != null && commentContent != null && !commentContent.trim().isEmpty()) {
            // 데이터베이스에 댓글 저장
            Class.forName(driverName);
            Connection conn2 = DriverManager.getConnection(url, username, password);
            String insertCommentSql = "INSERT INTO album_comments (photo_id, commenter, content) VALUES (?, ?, ?)";
            PreparedStatement insertCommentStmt = conn2.prepareStatement(insertCommentSql);
            insertCommentStmt.setInt(1, photoId);
            insertCommentStmt.setString(2, commenter);
            insertCommentStmt.setString(3, commentContent);
            insertCommentStmt.executeUpdate();

            insertCommentStmt.close();
            conn2.close();
        }

        // 댓글 작성 후 페이지 다시 로드하여 갱신된 댓글 표시
        response.sendRedirect(request.getRequestURI());
    }
%>
</script>
</body>
</html>
