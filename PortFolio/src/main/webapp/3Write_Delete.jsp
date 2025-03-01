<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.util.*"%>
<%
request.setCharacterEncoding("utf-8");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>고객센터 삭제</title>

<style type='text/css'>
.center {
	text-align: center;
	margin: 0 auto;
}

.tablewd {
	width: 45%;
	border: none; /* 1px solid black; */
	border-collapse: collapse;
	padding: 0;
	border-spacing: 0;
	margin-left: auto;
	margin-right: auto;
}

.tablewd td {
	padding: 0;
	border: 0; /* 1px solid black; */
	text-align: center;
	vertical-align: middle;
}

.tablewd1 {
	width: 45%;
	border: 1px solid black; /* 1px solid black; */
	border-collapse: collapse;
	padding: 0;
	border-spacing: 0;
	margin-left: auto;
	margin-right: auto;
	background-color: #ededed;
}

.tablewd1 td {
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

<script>
if (Write.pass.value.length < 1) {
    alert("비밀번호를 입력하세요.")
    Write.pass.focus();
    return false;
}

function CheckPassword() {
    var pass = Write.pass.value; // 사용자가 입력한 비밀번호
    <%String pass_from_database = ""; // 데이터베이스에서 가져온 비밀번호
try {
	Class.forName("com.mysql.jdbc.Driver");
	String url = "jdbc:mysql://localhost:3306/board";
	Connection conn = DriverManager.getConnection(url, "board", "board");

	String strSQL = "SELECT pass FROM board WHERE num=?";
	PreparedStatement pstmt = conn.prepareStatement(strSQL);
	pstmt.setInt(1, Integer.parseInt(request.getParameter("num")));
	ResultSet rs = pstmt.executeQuery();
	if (rs.next()) {
		pass_from_database = rs.getString("pass");
	}
	rs.close();
	pstmt.close();
	conn.close();
} catch (Exception e) {
	e.printStackTrace();
}%>
    if (pass !== "<%=pass_from_database%>
			alert("비밀번호가 일치하지 않습니다.");
			Write.pass.focus();
			return false;
		}
		return true;
	}
</script>
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

		String strSQL = "SELECT * FROM board WHERE num=?";
		pstmt = conn.prepareStatement(strSQL);
		pstmt.setInt(1, Integer.parseInt(num));

		rs = pstmt.executeQuery();
		rs.next();

		String name = rs.getString("name");
		String email = rs.getString("email");
		String title = rs.getString("title");
		String contents = rs.getString("contents").trim();
	%>
	<div class="center">
		<table class="tablewd">
			<tr>
				<td><jsp:include page="0Main_AC.jsp" flush="false" /></td>
			</tr>
		</table>

		<table class="tablewd1">
			<tr height="50">
				<td>
					<h1 style="font-size: 20px;">고객센터 삭제</h1>
				</td>
			</tr>
		</table>

		<form Name="Write" Action="3Write_DeletePro.jsp?num=<%=num%>" Method="post" OnSubmit="return CheckPassword()">
			<table class="tablewd1">
				<tr>
					<td width="150">
						<font size="2"><b> 작성자 </b></font>
					</td>
					<td style="text-align: left;">
						<p>
							<input type="text" size="40" name="name" value="<%=name%>">
							* 필수
						</p>
					</td>
				</tr>

				<tr>
					<td>
						<font size="2"><b> 비밀번호 </b></font>
					</td>
					<td style="text-align: left;">
						<p>
							<input type="password" size="40" name="pass">
							* 필수(수정/삭제시)
						</p>
					</td>
				</tr>

				<tr>
					<td>
						<font size="2"><b> E-mail </b></font>
					</td>
					<td style="text-align: left;">
						<p>
							<input type="text" size="60" maxlength="50" name="email" value="<%=email%>">
						</p>
					</td>
				</tr>

				<tr>
					<td colspan="2">
						<hr size="1" noshade>
					</td>
				</tr>

				<tr>
					<td>
						<font size="2"><b> 글 제목 </b></font>
					</td>

					<td style="text-align: left;">
						<p>
							<input type="text" size="65" maxlength="50" name="title" value="<%=title%>">
						</p>
					</td>
				</tr>

				<tr>
					<td>
						<font size='2'><b>글 내용</b></font>
					</td>
					<td style="text-align: left;">
						<textarea cols="65" rows="12" name="contents"><%=contents%></textarea>
					</td>
				</tr>

				<tr>
					<td colspan="2">
						<hr size="1" noshade>
					</td>
				</tr>

				<tr height="30">
					<td colspan="2">
						<input type="button" onclick="history.back()" value="취소하기">
						&emsp;
						<input type="submit" value="삭제하기">
					</td>
				</tr>
			</table>
		</form>
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
</body>
</html>