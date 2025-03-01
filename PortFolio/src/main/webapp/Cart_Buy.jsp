<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.util.*"%>
<%
request.setCharacterEncoding("utf-8");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>구매화면</title>

<style type='text/css'>
.center {
	text-align: center;
	margin: 0 auto;
}

.tablecb {
	width: 40%;
	border: none; /* 1px solid black; */
	border-collapse: collapse;
	padding: 0; /* 1px; */
	border-spacing: 0;
	margin-left: auto;
	margin-right: auto;
}

.tablecb td {
	padding: 0;
	border: 0; /* 1px solid black; */
	text-align: center;
	vertical-align: middle;
}

.tablecb1 {
	width: 40%;
	border: 1px solid black; /* 1px solid black; */
	border-collapse: collapse;
	padding: 5px;
	border-spacing: 0;
	margin-left: auto;
	margin-right: auto;
	background-color: #FFEAD0;
}

.tablecb1 td {
	padding: 10px;
	border: 1px solid black; /* 1px solid black; */
	text-align: left;
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
        if (Cart.b_email.value.indexOf("@") + "" == "-1"
                || Cart.b_email.value.indexOf(".") + "" == "-1"
                || Cart.b_email.value == "") {
            alert("E-mail을 정확히 입력하세요.('@', '.' 포함)")
            Cart.b_email.focus();
            return false;
        }
        if (Cart.b_address.value.length < 1) {
            alert("주소를 입력하세요.")
            Cart.b_address.focus();
            return false;
        }
        Cart.submit();
    }
</script>
</head>

<body>
	<%
	String c_num = request.getParameter("c_num");

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
		urlc = "jdbc:mysql://localhost:3306/cart";
		connc = DriverManager.getConnection(urlc, "cart", "cart");

		String sqlc = "SELECT * FROM cart WHERE c_num=?";
		pstmtc = connc.prepareStatement(sqlc);
		pstmtc.setString(1, c_num);
		rsc = pstmtc.executeQuery();

		if (rsc.next()) {
			String b_id = rsc.getString("c_id");
			String b_img = rsc.getString("c_img");
			String b_cname = rsc.getString("c_name");
			String b_pay = rsc.getString("c_pay");
			java.sql.Date b_day = rsc.getDate("c_day");
			java.util.Date utilDate = new java.util.Date(b_day.getTime());
			java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyy-MM-dd");
			String formattedDate = sdf.format(utilDate);
			String b_keep = rsc.getString("c_keep");

			Class.forName("com.mysql.jdbc.Driver");
			urlm = "jdbc:mysql://localhost:3306/member";
			connm = DriverManager.getConnection(urlm, "member", "member");

			String sqlm = "SELECT * FROM member WHERE id=?";
			pstmtm = connm.prepareStatement(sqlm);
			pstmtm.setString(1, b_id);
			rsm = pstmtm.executeQuery();

			if (rsm.next()) {
		String b_name = rsm.getString("name");
		String b_email = rsm.getString("email");
		String b_address = rsm.getString("address");
	%>
	<div class="center">
		<table class="tablecb">
			<tr>
				<td><jsp:include page="0Main_AC.jsp" flush="false" /></td>
			</tr>
		</table>

		<form name="Cart" method="post" action="Cart_BuyPro.jsp">
			<table class="tablecb1">
				<tr height="30">
					<td colspan="2" style="text-align: center;">
						<h1 style="font-size: 20px;">구매자정보</h1>
					</td>
				</tr>
				<tr height="40">
					<td width="35%">아이디</td>
					<td><%=b_id%>
						<input type="hidden" name="b_id" value="<%=b_id%>">
					</td>
				</tr>
				<tr height="40">
					<td>이름</td>
					<td><%=b_name%>
						<input type="hidden" name="b_name" value="<%=b_name%>">
					</td>
				</tr>
				<tr height="40">
					<td>이메일</td>
					<td>
						<input type="text" name="b_email" value="<%=b_email%>" size="35%" style="font-size: 16px;">
				</tr>
				<tr height="40">
					<td>주소</td>
					<td>
						<input type="text" name="b_address" value="<%=b_address%>" size="35%" style="font-size: 16px;">
					</td>
				</tr>
				<tr height="20">
					<td colspan="2" style="background-color: #FFFFFF"></td>
				</tr>
				<tr height="40">
					<td colspan="2" style="text-align: center;">
						<h1 style="font-size: 20px;">상품정보</h1>
					</td>
				</tr>
				<tr height="40">
					<td rowspan="4" style="text-align: center;">
						<img src="<%=b_img%>" alt="<%=b_cname%>" width="150" height="150">
						<input type="hidden" name="b_img" value="<%=b_img%>">
					</td>
					<td><%=b_cname%>
						<input type="hidden" name="b_cname" value="<%=b_cname%>">
					</td>
				</tr>
				<tr height="40">
					<td><%=b_pay%>
						<input type="hidden" name="b_pay" value="<%=b_pay%>">
					</td>
				</tr>
				<tr height="40">
					<td><%=b_day%>
						<input type="hidden" name="b_day" value="<%=b_day%>">
					</td>
				</tr>
				<tr height="40">
					<td><%=b_keep%>
						<input type="hidden" name="b_keep" value="<%=b_keep%>">
					</td>
				</tr>
				<tr height="40">
					<td colspan="2" style="text-align: center;">
						<input type="button" onclick="history.back()" value="취소하기">
						&emsp;
						<input type="submit" value="구매하기">
					</td>
				</tr>
			</table>
		</form>
	</div>
	<%
	}
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