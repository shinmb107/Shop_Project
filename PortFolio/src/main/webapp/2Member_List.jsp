<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.util.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원정보</title>

<style type='text/css'>
.center {
	text-align: center;
	margin: 0 auto;
}

.tablems {
	width: 65%;
	border: none; /* 1px solid black; */
	border-collapse: collapse;
	padding: 0;
	border-spacing: 0;
	margin-left: auto;
	margin-right: auto;
}

.tablems td {
	padding: 0;
	border: 0; /* 1px solid black; */
	text-align: center;
	vertical-align: middle;
}

.tablems1 {
	width: 65%;
	border: 1px solid black; /* 1px solid black; */
	border-collapse: collapse;
	padding: 0;
	border-spacing: 0;
	margin-left: auto;
	margin-right: auto;
	background-color: #FFEAD0;
}

.tablems1 td {
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
	<div class="center">
		<table class="tablems">
			<tr>
				<td><jsp:include page="0Main_AC.jsp" flush="false" /></td>
			</tr>
		</table>

		<table class="tablems1">
			<tr height="50">
				<td>
					<h1 style="font-size: 20px;">회원정보</h1>
				</td>
			</tr>
		</table>

		<table class="tablems1">
			<tr height="40">
				<td>아이디</td>
				<td>이름</td>
				<td>이메일</td>
				<td>가입일자</td>
			</tr>
			<%
			Connection conn = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;

			try {
				Class.forName("com.mysql.jdbc.Driver");
				String jdbcUrl = "jdbc:mysql://localhost:3306/member";
				conn = DriverManager.getConnection(jdbcUrl, "member", "member");

				String sql = "select*from member";
				pstmt = conn.prepareStatement(sql);
				rs = pstmt.executeQuery();

				while (rs.next()) {
					String id = rs.getString("id");
					String name = rs.getString("name");
					String email = rs.getString("email");
					String address = rs.getString("address");
					java.sql.Date date = rs.getDate("date");
			        java.util.Date utilDate = new java.util.Date(date.getTime());
			        java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyy-MM-dd");
			        String formattedDate = sdf.format(utilDate);
			%>
			<tr height="50" bgcolor="white">
				<td><%=id%></td>
				<td><%=name%></td>
				<td><%=email%></td>
				<td><%=address%></td>
				<td><%=date.toString()%></td>
			</tr>
			<%
			}
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
		</table>
	</div>
</body>
</html>