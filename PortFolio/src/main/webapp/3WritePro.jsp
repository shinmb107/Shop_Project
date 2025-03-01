<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.util.*"%>
<%
request.setCharacterEncoding("utf-8");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>고객센터 저장</title>
</head>

<body>
	<%
    String name = request.getParameter("name");
    String pass = request.getParameter("pass");
    String email = request.getParameter("email");
    String title = request.getParameter("title");
    String contents = request.getParameter("contents");
    
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;

	try {
		Class.forName("com.mysql.jdbc.Driver");
		String url = "jdbc:mysql://localhost:3306/board";
		conn = DriverManager.getConnection(url, "board", "board");

		Calendar dateIn = Calendar.getInstance();
		String indate = Integer.toString(dateIn.get(Calendar.YEAR)) + "-";
		indate = indate + Integer.toString(dateIn.get(Calendar.MONTH) + 1) + "-";
		indate = indate + Integer.toString(dateIn.get(Calendar.DATE) + 1) + " ";
		indate = indate + Integer.toString(dateIn.get(Calendar.HOUR_OF_DAY) + 1) + ":";
		indate = indate + Integer.toString(dateIn.get(Calendar.MINUTE)) + ":";
		indate = indate + Integer.toString(dateIn.get(Calendar.SECOND));

		String strSQL = "INSERT INTO board(name, pass, email, title, contents, writedate, readcount) ";
		strSQL = strSQL + "VALUES(?, ?, ?, ?, ?, ?, ?)";

		pstmt = conn.prepareStatement(strSQL);
		pstmt.setString(1, name);
		pstmt.setString(2, pass);
		pstmt.setString(3, email);
		pstmt.setString(4, title);
		pstmt.setString(5, contents);
		pstmt.setString(6, indate);
		pstmt.setInt(7, 0);
		pstmt.executeUpdate();

		response.sendRedirect("3Write_Listboard.jsp");

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