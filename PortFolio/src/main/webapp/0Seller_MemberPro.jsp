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
</style>
</head>

<body>
	<%
	String id = request.getParameter("id");
	String pass = request.getParameter("pass");
	String name = request.getParameter("name");
	String number = request.getParameter("number1") + "-" + request.getParameter("number2") + "-" + request.getParameter("number3");
	String tel = request.getParameter("tel1") + "-" + request.getParameter("tel2") + "-" + request.getParameter("tel3");
	String address = request.getParameter("address");
	String email = request.getParameter("email");

	Timestamp time = new Timestamp(System.currentTimeMillis());

	String check_ok = "yes";

	if (id == "") {
		check_ok = "no";
	}
	if (pass == "") {
		check_ok = "no";
	}
	if (name == "") {
		check_ok = "no";
	}
	if (number == "") {
		check_ok = "no";
	}
	if (tel == "") {
		check_ok = "no";
	}
	if (address == "") {
		check_ok = "no";
	}
	if (email == "") {
		check_ok = "no";
	}

	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;

	try {
		Class.forName("com.mysql.jdbc.Driver");
		String jdbcUrl = "jdbc:mysql://localhost:3306/member";
		conn = DriverManager.getConnection(jdbcUrl, "member", "member");

		String sql = "SELECT id FROM member WHERE id='" + id + "'";
		pstmt = conn.prepareStatement(sql);
		rs = pstmt.executeQuery(sql);

		if (!rs.next()) {
			check_ok = "yes";
		} else {
			check_ok = "no";
		}

		if (check_ok == "yes") {
			String SQL = "INSERT INTO member value(?,?,?,?,?,?,?,?)";
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, id);
			pstmt.setString(2, pass);
			pstmt.setString(3, name);
			pstmt.setString(4, number);
			pstmt.setString(5, tel);
			pstmt.setString(6, address);
			pstmt.setString(7, email);
			pstmt.setTimestamp(8, time);
			pstmt.executeUpdate();
	%>
	<div class="center">
		<table class="tablemp">
			<tr>
				<td><jsp:include page="0Main_AC.jsp" flush="false" /></td>
			</tr>
		</table>

		<table class="tablemp1">
			<tr>
				<td>
					<h2>
						<b> 회 원 가 입 성 공 </b>
					</h2>
				</td>
			</tr>

			<tr>
				<td>
					<h3>
						회원가입을 축하합니다.
						<br>
						로그인하세요.
					</h3>
				</td>
			</tr>

			<tr>
				<td>
					<font size='4'><a href='2Login_Form.jsp'> [로그인] </a></font>
				</td>
			</tr>
		</table>
	</div>
	<%
	} else {
	%>
	<div class="center">
		<table class="tablemp">
			<tr>
				<td><jsp:include page="0Main_AC.jsp" flush="false" /></td>
			</tr>
		</table>

		<table class="tablemp1">
			<tr>
				<td>
					<h2>
						<b> 회 원 가 입 실 패 </b>
					</h2>
				</td>
			</tr>

			<tr>
				<td>
					<h3>
						회원가입에 실패했습니다.
						<br>
						다시 작성해주세요.
					</h3>
				</td>
			</tr>

			<tr>
				<td>
					<font size='4'><a href='0Seller_Member_Form.jsp'> [다시작성] </a></font>
				</td>
			</tr>
		</table>
	</div>
	<%
	}
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