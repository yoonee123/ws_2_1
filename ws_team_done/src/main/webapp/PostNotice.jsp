<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>공지 작성</title>
</head>
<body>
    <%-- 공지 작성 폼에서 전송된 데이터 받기 --%>
    <% String noticeTitle = request.getParameter("noticeTitle");
       String noticeContent = request.getParameter("noticeContent");

       // 제목과 내용이 빈 값이 아닌지 확인
       if (noticeContent != null && noticeTitle != null && !noticeContent.trim().isEmpty() && !noticeTitle.trim().isEmpty()) {
           // 데이터베이스 연결 정보
           String driverName = "com.mysql.cj.jdbc.Driver";
           String url = "jdbc:mysql://localhost:3306/jyp";
           String username = "root";
           String password = "dongyang";
           Connection conn = null;

           try {
               // 드라이버 로드 및 데이터베이스 연결
               Class.forName(driverName);
               conn = DriverManager.getConnection(url, username, password);

               // SQL 문 준비 및 실행
               String sql = "INSERT INTO notices (title, content) VALUES (?, ?)";
               PreparedStatement stmt = conn.prepareStatement(sql);
               stmt.setString(1, noticeTitle);
               stmt.setString(2, noticeContent);

               // SQL 문 실행
               stmt.executeUpdate();

               // 자원 해제
               stmt.close();
               conn.close();

               // 공지사항 목록 페이지로 리디렉션
               response.sendRedirect("Notice.jsp");
           } catch (Exception e) {
               e.printStackTrace();
               // 데이터베이스 오류 발생 시 메시지 출력
               out.println("데이터베이스 오류가 발생했습니다. 다시 시도해주세요.");
           }
       } else {
           // 제목과 내용이 빈 값일 경우 메시지 출력
           out.println("제목과 내용을 입력하세요.");
       }
    %>
</body>
</html>
