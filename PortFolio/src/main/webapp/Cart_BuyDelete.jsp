<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.util.*"%>
<%
request.setCharacterEncoding("utf-8");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>장바구니 삭제</title>
</head>

<body>
	<%
	String b_num = request.getParameter("b_num");

	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;

	try {
        Class.forName("com.mysql.jdbc.Driver");
        String url = "jdbc:mysql://localhost:3306/cart";
		conn = DriverManager.getConnection(url, "cart", "cart");

		String strSQL = "DELETE FROM buy WHERE b_num=?";
		pstmt = conn.prepareStatement(strSQL);
		pstmt.setInt(1, Integer.parseInt(b_num));
		pstmt.executeUpdate();

		response.sendRedirect("2My_List.jsp");

	} catch (Exception e) {
		out.println(e.getMessage());

	} finally {
		try {
			rs.close();
			pstmt.close();
			conn.close();

		} catch (Exception e) {
			out.println(e.getMessage());
		}
	}
	%>
</body>
</html>