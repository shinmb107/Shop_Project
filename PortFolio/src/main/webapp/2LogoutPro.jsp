<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*, java.util.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>로그아웃 동작</title>
</head>

<body>
    <%
        session.invalidate(); // 세션 무효화
    %>
    
    <script>
        alert('로그아웃 되었습니다.');
        window.location.href = '1Main_Form.jsp'; // 로그인 페이지로 리디렉션
    </script>
</body>
</html>