<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.util.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>아이디 중복</title>

<style type='text/css'>
.center {
	text-align: center;
	margin: 0 auto;
}

.tablemc {
	width: 90%;
	border: 1px solid black; /* 1px solid black; */
	border-collapse: collapse;
	padding: 0;
	border-spacing: 0;
	margin-left: auto;
	margin-right: auto;
	border-collapse: collapse;
}

.tablemc td {
	padding: 0;
	border: 0; /* 1px solid black; */
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
	<div class="center">
		<table class="tablemc">
			<%
			String id = request.getParameter("id");

			if (id == "") {
			%>
			<tr>
				<td style="height: 100px; background-color: #7FFFD4;">
					<font size='5'> id를 입력하세요. </font>
				</td>
			</tr>

			<tr>
				<td>
					<br>
					<font size='4'><a href="javascript:close()"> [닫 기] </a></font>
					<br><br>
				</td>
			</tr>
			<%
			} else {

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
			%>
			<tr>
				<td style="height: 100px; background-color: #7FFFD4;">
					<font size='5'>ID : <%=id%> <BR>사용할 수 있는 아이디입니다.
					</Font>
				</td>
			</tr>

			<tr>
				<td>
					<br>
					<font size='4'><a href="javascript:close()"> [닫 기] </a></font>
					<br><br>
				</td>
			</tr>
			<%
			} else {
			%>
			<tr>
				<td style="height: 150px; background-color: #7FFFD4;">
					<font size="5">ID : <%=id%> <BR>사용할 수 없는 아이디입니다.
					</font>
				</td>
			</tr>

			<tr>
				<td>
					<br>
					<font size='4'><a href="javascript:close()"> [닫 기] </a></font>
					<br><br>
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
	}
	%>
</body>
</html>