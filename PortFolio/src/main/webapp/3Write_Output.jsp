<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.util.*"%>
<%
request.setCharacterEncoding("utf-8");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>고객센터 선택</title>

<style type='text/css'>
.center {
	text-align: center;
	margin: 0 auto;
}

.tablewo {
	width: 45%;
	border: none; /* 1px solid black; */
	border-collapse: collapse;
	padding: 0;
	border-spacing: 0;
	margin-left: auto;
	margin-right: auto;
}

.tablewo td {
	padding: 0;
	border: 0; /* 1px solid black; */
	text-align: center;
	vertical-align: middle;
}

.tablewo1 {
	width: 45%;
	border: 1px solid black; /* 1px solid black; */
	border-collapse: collapse;
	padding: 10px;
	border-spacing: 5px;
	margin-left: auto;
	margin-right: auto;
	background-color: #cccccc;
}

.tablewo1 td {
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
	String num = request.getParameter("num");

	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;

	try {
		Class.forName("com.mysql.jdbc.Driver");
		String url = "jdbc:mysql://localhost:3306/board";
		conn = DriverManager.getConnection(url, "board", "board");

		String strSQL = "SELECT * FROM board WHERE num =?";
		pstmt = conn.prepareStatement(strSQL);
		pstmt.setInt(1, Integer.parseInt(num));
		rs = pstmt.executeQuery();
		rs.next();

		String name = rs.getString("name");
		String title = rs.getString("title");
		String contents = rs.getString("contents").trim();
		contents = contents.replaceAll("\n", "<br>");
		String writedate = rs.getString("writedate");
		int readcount = rs.getInt("readcount");
	%>
	<div class="center">
		<table class="tablewo">
			<tr>
				<td><jsp:include page="0Main_AC.jsp" flush="false" /></td>
			</tr>
		</table>

		<table class="tablewo1">
			<tr height="50">
				<td>
					<h1 style="font-size: 20px;">고객센터</h1>
				</td>
			</tr>
		</table>

		<table class="tablewo1">
			<tr height="40">
				<td style="text-align: left; padding: 5px;">
					<font size="3"> 작성자 : <%=name%>
					</font>
				</td>
				<td style="text-align: right; padding: 5px;">
					<font size="3">작성일: <%=writedate%>, 조회수: <%=readcount%></font>
				</td>
			</tr>
		</table>

		<table class="tablewo1">
			<tr height="50" bgcolor="ededed">
				<td>
					<font size="4"><b><%=title%></b></font>
				</td>
			</tr>
		</table>

		<table class="tablewo1">
			<tr height="200" bgcolor="ededed">
				<td style="text-align: left; vertical-align: top; padding: 10px;">
					<font size="3"><b><%=contents%></b></font>
				</td>
			</tr>

			<tr>
				<td height="40">
					<input type="button" onclick="location.href='3Write_Listboard.jsp'" value="목록보기">
					&emsp;
					<input type="button" onclick="location.href='3Write_Update.jsp?num=<%=num%>'" value="수정하기">
					&emsp;
					<input type="button" onclick="location.href='3Write_Delete.jsp?num=<%=num%>'" value="삭제하기">
					&emsp;
					<input type="button" onclick="location.href='3Write_Form.jsp'" value="새로작성">
				</td>
			</tr>
		</table>
		
		<table class="tablewo">
            <tr>
                <td>
                    <hr size="1" noshade>
                </td>
            </tr>
        </table>

		<table class="tablewo1">
			<tr height="200" bgcolor="ededed">
				<td>댓글기능</td>
			</tr>
		</table>

	</div>
	<%
	String strupSQL = "UPDATE board SET readcount=readcount+1 WHERE num=?";
	pstmt = conn.prepareStatement(strupSQL);
	pstmt.setInt(1, Integer.parseInt(num));
	pstmt.executeUpdate();

	} catch (SQLException e) {
	out.print("SQL에러 " + e.toString());
	} catch (Exception ex) {
	out.print("JSP에러 " + ex.toString());
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