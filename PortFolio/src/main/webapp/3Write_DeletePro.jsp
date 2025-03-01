<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.util.*"%>
<%
request.setCharacterEncoding("utf-8");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>고객센터 삭제 동작</title>
</head>

<body>
	<%
	String num = request.getParameter("num");
	
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;

	try {
		Class.forName("com.mysql.jdbc.Driver");
		String url = "jdbc:mysql://localhost:3306/board";
		conn = DriverManager.getConnection(url, "board", "board");

		String strSQL = "DELETE FROM board WHERE num=?";
		pstmt = conn.prepareStatement(strSQL);
		pstmt.setInt(1, Integer.parseInt(num));
		pstmt.executeUpdate();

		response.sendRedirect("3Write_listboard.jsp");

	} catch (Exception e) {
		e.printStackTrace();

	} finally {
		try {
			rs.close();
			pstmt.close();
			conn.close();

		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	%>
</body>
</html>