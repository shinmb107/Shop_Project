<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.util.*"%>
<%
request.setCharacterEncoding("utf-8");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>내정보 수정</title>

<style type='text/css'>
.center {
	text-align: center;
	margin: 0 auto;
}

.tablemb {
	width: 40%;
	border: none; /* 1px solid black; */
	border-collapse: collapse;
	padding: 0;
	border-spacing: 0;
	margin-left: auto;
	margin-right: auto;
}

.tablemb td {
	padding: 0;
	border: 0; /* 1px solid black; */
	text-align: center;
	vertical-align: middle;
}

.tablemb1 {
	width: 40%;
	border: 1px solid black; /* 1px solid black; */
	border-collapse: collapse;
	padding: 5px;
	border-spacing: 0;
	margin-left: auto;
	margin-right: auto;
	background-color: #FFEAD0;
}

.tablemb1 td {
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

<script>
	function Check() {
		if (Member.id.value.length < 1) {
			alert("아이디를 입력하세요.")
			Member.id.focus();
			return false;
		}
		if (Member.pass.value.length < 1) {
			alert("비밀번호를 입력하세요.")
			Member.pass.focus();
			return false;
		}
		if (Member.name.value.length < 1) {
			alert("이름을 입력하세요.")
			Member.name.focus();
			return false;
		}
		if (Member.email.value.indexOf("@") + "" == "-1"
				|| Member.email.value.indexOf(".") + "" == "-1"
				|| Member.email.value == "") {
			alert("E-mail을 정확히 입력하세요.('@', '.' 포함)")
			Member.email.focus();
			return false;
		}
		if (Member.address.value.length < 1) {
			alert("주소를 입력하세요.")
			Member.address.focus();
			return false;
		}
		Member.submit();
	}

	function Check_id() {
		browsing_window = window
				.open(
						"2Member_ChkID.jsp?id=" + Member.id.value,
						"_idcheck",
						"height=300, width=600, menubar=no, directories=no, resizable=no, status=no, scrollbars=yes");
		browsing_window.focus();
	}
</script>
</head>

<body>
	<%
	String logID = request.getParameter("logID");

	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;

	try {
		Class.forName("com.mysql.jdbc.Driver");
		String jdbcUrl = "jdbc:mysql://localhost:3306/member";
		conn = DriverManager.getConnection(jdbcUrl, "member", "member");

		String sql = "SELECT * FROM member WHERE id=?";
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, logID);

		rs = pstmt.executeQuery();
		rs.next();

		String id = rs.getString("id");
		String pass = rs.getString("pass");
		String name = rs.getString("name");
		String email = rs.getString("email");
		String address = rs.getString("address");
		java.sql.Date date = rs.getDate("date");
		java.util.Date utilDate = new java.util.Date(date.getTime());
		java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyy-MM-dd");
		String formattedDate = sdf.format(utilDate);
	%>
	<div class="center">
		<table class="tablemb">
			<tr>
				<td><jsp:include page="0Main_AC.jsp" flush="false" /></td>
			</tr>
		</table>

		<table class="tablemb1">
			<tr height="50">
				<td>
					<h1 style="font-size: 20px;">내정보</h1>
				</td>
			</tr>
		</table>

		<form name="Member" method="post" action="2Member_UpdatePro.jsp">
			<table class="tablemb1">
				<tr height="70">
					<td valign="middle">
						<input type="text" maxlength="50" name="id" value="<%=id%>" placeholder="아이디 입력" size="61%">
						<input type="button" OnClick="Check_id()" value="ID 중복검사">
					</td>
				</tr>

				<tr height="70">
					<td valign="middle">
						<input type="text" maxlength="50" name="pass" value="<%=pass%>" placeholder="비밀번호 입력" size="75%">
					</td>
				</tr>

				<tr height="70">
					<td>
						<input type="text" maxlength="50" name="name" value="<%=name%>" placeholder="이름 입력" size="75%">
					</td>
				</tr>

				<tr height="70">
					<td>
						<input type="text" maxlength="50" name="email" value="<%=email%>" placeholder="이메일 입력" size="75%">
					</td>
				</tr>

				<tr height="70">
					<td>
						<input type="text" maxlength="50" name="address" value="<%=address%>" placeholder="주소 입력" size="75%">
					</td>
				</tr>

				<tr height="50">
					<td>
						<input type="button" onclick="history.back()" value="취소하기">
						&emsp;
						<input type="button" onClick="Check()" value="수정하기">
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