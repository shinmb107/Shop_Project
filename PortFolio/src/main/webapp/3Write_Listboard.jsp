<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.util.*"%>
<%
request.setCharacterEncoding("utf-8");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>고객센터 목록</title>

<style type='text/css'>
.center {
	text-align: center;
	margin: 0 auto;
}

.tablewl {
	width: 45%;
	border: none; /* 1px solid black; */
	border-collapse: collapse;
	padding: 0;
	border-spacing: 0;
	margin-left: auto;
	margin-right: auto;
}

.tablewl td {
	padding: 0;
	border: 0; /* 1px solid black; */
	text-align: center;
	vertical-align: middle;
}

.tablewl1 {
	width: 45%;
	border: 1px solid black; /* 1px solid black; */
	border-collapse: collapse;
	padding: 2px;
	border-spacing: 0;
	margin-left: auto;
	margin-right: auto;
	background-color: #cccccc;
}

.tablewl1 td {
	padding: 0;
	border: 0; /* 1px solid black; */
	text-align: center;
	vertical-align: middle;
}

textarea {
	overflow-x: auto;
	white-space: nowrap;
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
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;

	try {
		Class.forName("com.mysql.jdbc.Driver");
		String url = "jdbc:mysql://localhost:3306/board";
		conn = DriverManager.getConnection(url, "board", "board");

		String sql = "SELECT * FROM board ORDER BY num ASC";
		pstmt = conn.prepareStatement(sql);
		rs = pstmt.executeQuery(sql);
	%>

	<div class="center">
		<table class="tablewl">
			<tr>
				<td><jsp:include page="0Main_AC.jsp" flush="false" /></td>
			</tr>
		</table>

		<table class="tablewl1">
			<tr height="50">
				<td>
					<h1 style="font-size: 20px;">고객센터</h1>
				</td>
			</tr>
		</table>

		<table class="tablewl1">
			<tr height="40">
				<td>
					<font size="3"> <b> 번호 </b>

					</font>
				</td>
				<td>
					<font size="3"> <b> 글 제목 </b>

					</font>
				</td>
				<td>
					<font size="3"> <b> 작성자 </b>
					</font>
				</td>
				<td>
					<font size="3"> <b> 작성일 </b>
					</font>
				</td>
				<td>
					<font size="3"> <b> 조회 </b>
					</font>
				</td>
			</tr>
			<%
			while (rs.next()) {
				int num = rs.getInt("num");
				String name = rs.getString("name");
				String email = rs.getString("email");
				String title = rs.getString("title");
				String writedate = rs.getString("writedate");
				int readcount = rs.getInt("readcount");
			%>
			<tr height="50">
				<td bgcolor="ededed">
					<font size="3" color="black"> <%=num%>
					</font>
				</td>
				<td bgcolor="ededed">
					<a href="3Write_Output.jsp?num=<%=num%>"> <font size="3" color="black"> <%=title%>
					</font></a>
				</td>
				<td bgcolor="ededed">
					<font size="3" color="black"> <%=name%>
					</font>
				</td>
				<td bgcolor="ededed">
					<font size="3" color="black"> <%=writedate%>
					</font>
				</td>
				<td bgcolor="ededed">
					<font size="3" color="black"> <%=readcount%>
					</font>
				</td>
			</tr>
			<%
			}
			%>
			<tr>
				<td colspan="5" height="40">
					<input type="button" onclick="history.back()" value="돌아가기">
					&emsp;
					<input type="button" onclick="location.href='3Write_Form.jsp'" value="문의하기">
				</td>
			</tr>
		</table>
	</div>
	<%
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
</bodY>
</html>