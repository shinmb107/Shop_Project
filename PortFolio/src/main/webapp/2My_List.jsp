<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*,java.util.*"%>
<%
request.setCharacterEncoding("utf-8");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>내 정보</title>

<style type='text/css'>
.center {
	text-align: center;
	margin: 0 auto;
}

.tableml {
	width: 600px;
	border: none; /* 1px solid black; */
	border-collapse: collapse;
	padding: 0;
	border-spacing: 0;
	margin-left: auto;
	margin-right: auto;
}

.tableml td {
	padding: 0;
	border: 0; /* 1px solid black; */
	text-align: center;
	vertical-align: middle;
}

.tableml1 {
	width: 600px;
	border: 1px solid black; /* 1px solid black; */
	border-collapse: collapse;
	padding: 0;
	border-spacing: 0;
	margin-left: auto;
	margin-right: auto;
	background-color: #FFEAD0;
}

.tableml1 td {
	padding: 10px;
	border: 1px solid black; /* 1px solid black; */
	text-align: left;
	vertical-align: middle;
}

.scrolltable-container {
	border: 1px solid black; /* 전체 테두리 스타일링 */
	width: 599px;
	height: 300px;
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
	String userType = (String) session.getAttribute("userType");

	if (logID == null) {
		response.sendRedirect("2Login_Form.jsp");
		return;
	}

	String urlc = null;
	String urlm = null;
	Connection connc = null;
	Connection connm = null;
	PreparedStatement pstmtc = null;
	PreparedStatement pstmtm = null;
	ResultSet rsc = null;
	ResultSet rsm = null;

	try {
		Class.forName("com.mysql.jdbc.Driver");
		String jdbcUrl = "jdbc:mysql://localhost:3306/member";
		connm = DriverManager.getConnection(jdbcUrl, "member", "member");

		String sql = "SELECT * FROM member WHERE id=?";
		pstmtm = connm.prepareStatement(sql);
		pstmtm.setString(1, logID);
		rsm = pstmtm.executeQuery();

		if (rsm.next()) {
			String id = rsm.getString("id");
			String name = rsm.getString("name");
			String sellers = rsm.getString("seller");
			String address = rsm.getString("address");
			String tel = rsm.getString("tel");
			String email = rsm.getString("email");
			java.sql.Date date = rsm.getDate("date");
			java.util.Date utilDatem = new java.util.Date(date.getTime());
			java.text.SimpleDateFormat sdfm = new java.text.SimpleDateFormat("yyyy-MM-dd");
			String formattedDatem = sdfm.format(utilDatem);

			Class.forName("com.mysql.jdbc.Driver");
			urlc = "jdbc:mysql://localhost:3306/cart";
			connc = DriverManager.getConnection(urlc, "cart", "cart");

			String sqlc = "SELECT * FROM buy WHERE b_id=?";
			pstmtc = connc.prepareStatement(sqlc);
			pstmtc.setString(1, logID);
			rsc = pstmtc.executeQuery();
	%>
	<div class="center">
		<%
		if ("seller".equals(userType)) {
		%>
		<table class="tableml">
            <tr>
                <td><jsp:include page="0Main_AC.jsp" flush="false" /></td>
            </tr>
        </table>

        <table class="tableml1">
            <tr height="50">
                <td style="text-align: center;">
                    <h1 style="font-size: 20px;">내 정보</h1>
                </td>
            </tr>
        </table>
		
		<table class="tableml1">
			<tr>
				<td width="120px">아이디</td>
				<td colspan="2"><%=id%></td>
			</tr>
			<tr>
				<td>사업자 이름</td>
				<td colspan="2"><%=name%></td>
			</tr>
			<tr>
				<td>사업자 번호</td>
				<td colspan="2"><%=sellers%></td>
			</tr>
			<tr>
				<td>사업자 주소</td>
				<td colspan="2"><%=address%></td>
			</tr>
			<tr>
				<td>사업자 전화번호</td>
				<td colspan="2"><%=tel%></td>
			</tr>
			<tr>
				<td>사업자 이메일</td>
				<td colspan="2"><%=email%></td>
			</tr>
			<tr>
				<td>가입날짜</td>
				<td colspan="2"><%=date.toString()%></td>
			</tr>
			<tr>
				<td colspan="3" style="text-align: center;">
					<input type="button" onclick="location.href='0Seller_Member_UpdatePro.jsp?logID=<%=logID%>'" value="정보수정">
				</td>
			</tr>
		</table>
		<%
		} else {
		%>
		<table class="tableml">
			<tr>
				<td><jsp:include page="0Main_AC.jsp" flush="false" /></td>
			</tr>
		</table>

		<table class="tableml1">
			<tr height="50">
				<td style="text-align: center;">
					<h1 style="font-size: 20px;">내 정보</h1>
				</td>
			</tr>
		</table>

		<table class="tableml1">
			<tr>
				<td width="100px">아이디</td>
				<td colspan="2"><%=id%></td>
			</tr>
			<tr>
				<td>이&emsp;름</td>
				<td colspan="2"><%=name%></td>
			</tr>
			<tr>
				<td>주&emsp;소</td>
				<td colspan="2"><%=address%></td>
			</tr>
			<tr>
				<td>전화번호</td>
				<td colspan="2"><%=tel%></td>
			</tr>
			<tr>
				<td>이메일</td>
				<td colspan="2"><%=email%></td>
			</tr>
			<tr>
				<td>가입날짜</td>
				<td colspan="2"><%=date.toString()%></td>
			</tr>
			<tr>
				<td colspan="3" style="text-align: center;">
					<input type="button" onclick="location.href='2Member_Update.jsp?logID=<%=logID%>'" value="정보수정">
				</td>
			</tr>
		</table>

		<hr style="width: 600px;" size="1" noshade>

		<table class="tableml1">
			<tr height="30">
				<td colspan="3" style="text-align: center;">
					<h1 style="font-size: 20px;">주문내역</h1>
				</td>
			</tr>
		</table>

		<div class="scrolltable-container">
			<table class="scrolltable">
				<%
				while (rsc.next()) {
					String b_num = rsc.getString("b_num");
					String b_id = rsc.getString("b_id");
					String b_name = rsc.getString("b_name");
					String b_email = rsc.getString("b_email");
					String b_address = rsc.getString("b_address");
					String b_img = rsc.getString("b_img");
					String b_cname = rsc.getString("b_cname");
					String b_pay = rsc.getString("b_pay");
					java.sql.Date b_day = rsc.getDate("b_day");
					java.util.Date utilDatec = new java.util.Date(b_day.getTime());
					java.text.SimpleDateFormat sdfc = new java.text.SimpleDateFormat("yyyy-MM-dd");
					String formattedDatec = sdfc.format(utilDatec);
					String b_keep = rsc.getString("b_keep");
				%>
				<tr>
					<td width="20%" style="text-align: center;">
						<img src="<%=b_img%>" alt="<%=b_cname%>" width="100" height="100">
						<input type="hidden" name="b_num" value="<%=b_num%>">
					</td>
					<td width="17%"><%=b_cname%></td>
					<td width="18%"><%=b_pay%></td>
					<td width="18%"><%=b_day%></td>
					<td width="17%"><%=b_keep%></td>
					<td width="10%">
						<input type="button" onclick="location.href='Cart_BuyDelete.jsp?b_num=<%=b_num%>'" value="삭제">
					</td>
				</tr>
				<%
				}
				%>
			</table>
		</div>
		<%
		}
		%>
	</div>
	<%
	}
	} catch (Exception e) {
	System.out.println(e.getMessage());
	} finally {
	try {
	rsc.close();
	rsm.close();
	pstmtm.close();
	pstmtc.close();
	connm.close();
	connc.close();
	} catch (Exception e) {
	System.out.println(e.getMessage());
	}
	}
	%>
</body>
</html>