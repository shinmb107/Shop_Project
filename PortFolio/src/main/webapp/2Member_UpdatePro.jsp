<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.util.*"%>
<%
request.setCharacterEncoding("utf-8");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입 동작</title>

<style type='text/css'>
.center {
	text-align: center;
}

.tablemp {
	width: 40%;
	border: none; /* 1px solid black; */
	border-collapse: collapse;
	padding: 0;
	border-spacing: 0;
	margin-left: auto;
	margin-right: auto;
}

.tablemp td {
	padding: 0;
	border: none; /* 1px solid black; */
	text-align: center;
	vertical-align: middle;
}

.tablemp1 {
	width: 40%;
	border: none; /* 1px solid black; */
	border-collapse: collapse;
	padding: 10px;
	border-spacing: 0;
	margin-left: auto;
	margin-right: auto;
	background-color: #FFEAD0;
}

.tablemp1 td {
	padding: 0;
	border: 1px solid black; /* 1px solid black; */
	text-align: center;
	vertical-align: middle;
}

a:link { /* 방문하지 않은 링크에 적용되는 스타일 */
	font-family: "";
	color: black;
	text-decoration: none; /* underline; */
}

a:visited { /* 이미 방문한 링크에 적용되는 스타일 */
	font-family: "";
	color: black;
	text-decoration: underline;
}

a:hover { /* 마우스를 링크 위에 올렸을 때의 스타일 */
	font-family: "";
	color: black;
	text-decoration: underline;
}
</style>
</head>

<body>
	<%
	String id = request.getParameter("id");
	String pass = request.getParameter("pass");
	String name = request.getParameter("name");
	String email = request.getParameter("email");
	String address = request.getParameter("address");

	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;

	try {
		Class.forName("com.mysql.jdbc.Driver");
		String url = "jdbc:mysql://localhost:3306/member";
		conn = DriverManager.getConnection(url, "member", "member");

		String SQL = "UPDATE member SET id=?, pass=?, name=?, email=?, address=? WHERE id=?";
		pstmt = conn.prepareStatement(SQL);
		pstmt.setString(1, id);
		pstmt.setString(2, pass);
		pstmt.setString(3, name);
		pstmt.setString(4, email);
		pstmt.setString(5, address);
		pstmt.setString(6, id);
		pstmt.executeUpdate();

		response.sendRedirect("2My_List.jsp");
		
	} catch (Exception e) {
		e.printStackTrace();

	} finally {
		try {
			pstmt.close();
			conn.close();

		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	%>
</body>
</html>