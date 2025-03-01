<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.util.*"%>
<%
request.setCharacterEncoding("utf-8");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>장바구니 화면</title>

<style type='text/css'>
.center {
	text-align: center;
	margin: 0 auto;
}

.tablecl {
	width: 800px;
	border: none; /* 1px solid black; */
	border-collapse: collapse;
	padding: 0;
	border-spacing: 0;
	margin-left: auto;
	margin-right: auto;
}

.tablecl td {
	padding: 0;
	border: 0; /* 1px solid black; */
	text-align: center;
	vertical-align: middle;
}

.tablecl1 {
	width: 800px;
	border: 1px solid black; /* 1px solid black; */
	border-collapse: collapse;
	padding: 0;
	border-spacing: 0;
	margin-left: auto;
	margin-right: auto;
	background-color: #FFEAD0;
}

.tablecl1 td {
	padding: 0;
	border: 1px solid black; /* 1px solid black; */
	text-align: center;
	vertical-align: middle;
}

.scrolltable-container {
    border: 1px solid black; /* 전체 테두리 스타일링 */
    width: 799px;
    height: 400px;
    border-collapse: collapse;
    padding: 0;
    border-spacing: 0;
    margin: 0 auto;
    overflow: scroll;
    box-sizing: border-box;
    background-color: #FFEAD0;
}

.scrolltable {
	width: 100%;
	border-collapse: collapse;
	padding: 0;
	border-spacing: 0;
	margin: 0 auto;
	background-color: #FFEAD0;
}

.scrolltable tr {
    border-bottom: 1px solid black; /* 행의 아래에 선 추가 */
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
	String logID = (String) session.getAttribute("logID");

	if (logID == null) {
		response.sendRedirect("2Login_Form.jsp");
		return;
	}

	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;

	try {
		Class.forName("com.mysql.jdbc.Driver");
		String url = "jdbc:mysql://localhost:3306/cart";
		conn = DriverManager.getConnection(url, "cart", "cart");

		String sql = "SELECT*FROM cart ORDER BY c_num ASC";
		pstmt = conn.prepareStatement(sql);
		rs = pstmt.executeQuery(sql);
	%>
	<div class="center">
		<table class="tablecl">
			<tr>
				<td><jsp:include page="0Main_AC.jsp" flush="false" /></td>
			</tr>
		</table>

		<table class="tablecl1">
			<tr height="50">
				<td>
					<h1 style="font-size: 20px;">장바구니</h1>
				</td>
			</tr>
		</table>

		<table class="tablecl1">
			<tr height="40">
				<td width="19%">
					<font size="3"> <b> 상품사진 </b>
					</font>
				</td>
				<td width="17%">
					<font size="3"> <b> 상품이름 </b>
					</font>
				</td>
				<td width="16%">
					<font size="3"> <b> 상품가격 </b>
					</font>
				</td>
				<td width="16%">
					<font size="3"> <b> 유통기한 </b>
					</font>
				</td>
				<td width="16%">
					<font size="3"> <b> 보관방식 </b>
					</font>
				</td>
				<td width="14%">
					<font size="3"> <b> 삭제 </b>
					</font>
				</td>
			</tr>
		</table>

		<div class="scrolltable-container">
			<table class="scrolltable">
				<%
				while (rs.next()) {
					int c_num = rs.getInt("c_num");
					String c_img = rs.getString("c_img");
					String c_name = rs.getString("c_name");
					String c_pay = rs.getString("c_pay");
					String c_keep = rs.getString("c_keep");
					java.sql.Date c_day = rs.getDate("c_day");
					java.util.Date utilDate = new java.util.Date(c_day.getTime());
					java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyy-MM-dd");
					String formattedDate = sdf.format(utilDate);
				%>
				<tr height="50">
					<td width="20%">
						<img src="<%=c_img%>" alt="<%=c_name%>" width="100" height="100">
					</td>
					<td width="17%">
						<font size="3" color="black"> <%=c_name%>
						</font>
					</td>
					<td width="17%">
						<font size="3" color="black"> <%=c_pay%>
						</font>
					</td>
					<td width="17%">
						<font size="3" color="black"> <%=c_day%>
						</font>
					</td>
					<td width="17%">
						<font size="3" color="black"> <%=c_keep%>
						</font>
					</td>
					<td width="12%">
						<input type="button" onclick="location.href='Cart_Delete.jsp?c_num=<%=c_num%>'" value="삭제하기">
						<br>
						<br>
						<input type="button" onclick="location.href='Cart_Buy.jsp?c_num=<%=c_num%>'" value="구매하기">
					</td>
				</tr>
				<%
				}
				%>
			</table>
		</div>
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