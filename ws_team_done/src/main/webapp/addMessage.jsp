<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.text.SimpleDateFormat" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>방명록</title>
</head>
<body>
<!-- Main.jsp로 돌아가는 버튼 -->
<form action="Main.jsp" method="get">
    <button type="submit">처음으로 돌아가기</button>
</form>
    <div id="message-container">
        <% 
        try {
            // 데이터베이스 연결 정보 설정
            String driverName = "com.mysql.cj.jdbc.Driver";
            String url = "jdbc:mysql://localhost:3306/jyp";
            String username = "root";
            String password = "dongyang";

            // 드라이버 로드
            Class.forName(driverName);

            // 데이터베이스 연결
            Connection conn = DriverManager.getConnection(url, username, password);

            // 메시지 목록을 가져옴
            String fetchSql = "SELECT name, message, created_at FROM guestbook ORDER BY id ASC"; // 오름차순 정렬
            Statement stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery(fetchSql);

            // 날짜 형식을 지정
            SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm");

            while (rs.next()) {
                String fetchedName = rs.getString("name");
                String fetchedMessage = rs.getString("message");
                Timestamp timestamp = rs.getTimestamp("created_at");
                String formattedDate = dateFormat.format(timestamp);

                out.println("<p><strong>" + fetchedName + ":</strong> " + fetchedMessage + " <em>(" + formattedDate + ")</em></p>");
            }

            // 리소스 해제
            rs.close();
            stmt.close();
            conn.close();
        } catch (ClassNotFoundException e) {
            out.println("JDBC 드라이버를 찾을 수 없습니다.");
            e.printStackTrace();
        } catch (SQLException e) {
            out.println("데이터베이스 오류가 발생했습니다: " + e.getMessage());
            e.printStackTrace();
        } catch (Exception e) {
            out.println("오류가 발생했습니다: " + e.getMessage());
            e.printStackTrace();
        }
        %>
    </div>
    <div id="input-form">
        <form action="addMessageAction.jsp" method="post">    
            <input name="message" type="text" placeholder="message">
            <input type="submit" value="작성">
        </form>
    </div>
</body>
</html>
