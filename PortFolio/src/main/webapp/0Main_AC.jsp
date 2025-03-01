<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.util.*"%>
<%
request.setCharacterEncoding("utf-8");
String logID = (String) session.getAttribute("logID");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상단로고</title>

<style type='text/css'>
.center {
	text-align: center; /* 가로 방향 중앙 정렬을 위해 추가 */
	margin: 0 auto; /* 가로 방향 중앙 정렬을 위해 추가 */
}

.tablema {
	width: 100%;
	border: none; /* 테두리 제거 (1px solid black) */
	border-collapse: collapse; /* 테두리를 겹치도록 설정 */
	padding: 0; /* 셀의 내부 여백을 제거 */
	border-spacing: 0; /* 셀 간의 간격을 제거 */
	margin-left: auto; /* 테이블을 가로 방향으로 중앙 정렬하기 위해 추가 */
	margin-right: auto; /* 테이블을 가로 방향으로 중앙 정렬하기 위해 추가 */
}

.tablema td {
	padding: 0; /* 셀의 내부 여백을 제거 */
	border: none; /* 각 셀의 테두리 없음 (1px의 검은색 줄은 - 1px solid black;) */
	text-align: center; /* 글자열을 중간으로 설정 */
	vertical-align: middle; /* 글자행을 중간으로 설정 */
}

a:link { /* 방문하지 않은 링크에 적용되는 스타일 */
	font-family: ""; /* 링크의 글꼴을 기본값 설정 */
	color: black; /* 링크의 글자색을 검은색으로 지정 */
	text-decoration: none; /* 링크의 텍스트 밑줄 제거 (밑줄은 underline) */
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
		String jdbcUrl = "jdbc:mysql://localhost:3306/member";
		conn = DriverManager.getConnection(jdbcUrl, "member", "member");

		String sql = "select*from member";
		pstmt = conn.prepareStatement(sql);
		rs = pstmt.executeQuery();
	%>
	<div class="center">
		<table class="tablema">
			<tr height="30" bgcolor="#FFFAFA">
				<td style="text-align: right; vertical-align: top;">
					<h1 style="font-size: 15px;">
						<%
						if (logID != null) {
						%>
						<a href="2My_List.jsp?logID=<%=logID%>"> <%=logID%></a> 님 &emsp; <a href="2LogoutPro.jsp">로그아웃</a> &emsp; <a href="3Write_Listboard.jsp">고객센터</a>
						<%
						} else {
						%>
						<a href="2Login_Form.jsp">로그인</a> &emsp; <a href="2Member_Form.jsp">회원가입</a> &emsp; <a href="3Write_Listboard.jsp">고객센터</a>
						<%
						}
						%>
					</h1>
				</td>
			</tr>

			<tr height="70">
				<td bgcolor="#FFBDA3">
					<h1 style="font-size: 40px;">
						<a href="1Main_Form.jsp"> Good Choice </a>
					</h1>
				</td>
			</tr>

			<tr>
				<td>
					<hr size="1" noshade>
				</td>
			</tr>
		</table>
	</div>
	<%
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