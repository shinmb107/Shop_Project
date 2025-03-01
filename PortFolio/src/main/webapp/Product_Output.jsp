<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.util.*"%>
<%
String p_num = request.getParameter("p_num");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품 선택</title>

<style type='text/css'>
.center {
	text-align: center;
	margin: 0 auto;
}

.tablepo {
	width: 45%;
	border: none; /* 1px solid black; */
	border-collapse: collapse;
	padding: 0;
	border-spacing: 0;
	margin-left: auto;
	margin-right: auto;
}

.tablepo td {
	padding: 0;
	border: 0; /* 1px solid black; */
	text-align: center;
	vertical-align: middle;
}

.tablepo1 {
	width: 45%;
	border: 1px solid black; /* 1px solid black; */
	border-collapse: collapse;
	padding: 10px;
	border-spacing: 5px;
	margin-left: auto;
	margin-right: auto;
	background-color: #FFEAD0;
}

.tablepo1 td {
	padding: 5px;
	border: 0; /* 1px solid black; */
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
	function cart(){
		if(!confirm("장바구니에 담으시겠습니까?")){
     		return
     		
     	}else{
     		location.href="CartPro.jsp?p_num=<%=p_num%>";
     	}
	}
	function buy(){
        if(!confirm("바로구매 하시겠습니까?")){
            return
            
        }else{
            location.href="Cart_Buy_Now.jsp?p_num=<%=p_num%>";
        }
    }
</script>
</head>

<body>
	<%
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;

	try {
		Class.forName("com.mysql.jdbc.Driver");
		String url = "jdbc:mysql://localhost:3306/product";
		conn = DriverManager.getConnection(url, "product", "product");

		String strSQL = "SELECT*FROM product WHERE p_num=?";
		pstmt = conn.prepareStatement(strSQL);
		pstmt.setInt(1, Integer.parseInt(p_num));

		rs = pstmt.executeQuery();
		rs.next();

		String p_img = rs.getString("p_img");
		String p_name = rs.getString("p_name");
		String p_pay = rs.getString("p_pay");
		String p_keep = rs.getString("p_keep");
		String p_set = rs.getString("p_set");
		String p_organic = rs.getString("p_organic");
		String p_category = rs.getString("p_category");
		String p_count = rs.getString("p_count");
		String contents = rs.getString("p_explan").trim();
		contents = contents.replaceAll("\n", "<br>");
		java.sql.Date p_day = rs.getDate("p_day");
		java.util.Date utilDate = new java.util.Date(p_day.getTime());
		java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyy-MM-dd");
		String formattedDate = sdf.format(utilDate);
	%>
	<div class="center">
		<table class="tablepo">
			<tr>
				<td><jsp:include page="0Main_AC.jsp" flush="false" /></td>
			</tr>
		</table>

		<table class="tablepo1">
			<tr height="40">
				<td rowspan="8" width="300" style="text-align: center;">
					<img src="<%=p_img%>" alt="상품이미지" width="250" height="250">
				</td>
				<td>
					<font size="3"><b>
							상품이름 :
							<%=p_name%>
						</b></font>
				</td>
			</tr>

			<tr height="40">
				<td>
					<font size="3"><b>
							상품가격 :
							<%=p_pay%>
						</b></font>
				</td>
			</tr>

			<tr height="40">
				<td>
					<font size="3"><b>
							유통기한 :
							<%=p_day%>
						</b></font>
				</td>
			</tr>

			<tr height="40">
				<td>
					<font size="3"><b>
							보관방식 :
							<%=p_keep%>
						</b></font>
				</td>
			</tr>

			<tr height="40">
				<td>
					<font size="3"><b>
							구성방식 :
							<%=p_set%>
						</b></font>
				</td>
			</tr>

			<tr height="40">
				<td>
					<font size="3"><b>
							카테고리 :
							<%=p_category%>
						</b></font>
				</td>
			</tr>

			<tr height="40">
				<td>
					<font size="3"><b>
							유기농/친환경 :
							<%=p_organic%></b></font>
				</td>
			</tr>
			
			<tr height="40">
                <td>
                    <font size="3"><b>
                            구매량
                            <%=p_count%></b></font>
                </td>
            </tr>

			<tr>
				<td colspan="2">
					<hr size="1" noshade>
				</td>
			</tr>

			<tr height="100" bgcolor="#FFEAD0">
				<td colspan="2">
					<font size="3"><b><%=contents%></b></font>
				</td>
			</tr>

			<tr>
				<td colspan="2">
					<hr size="1" noshade>
				</td>
			</tr>

			<tr height="30">
				<td colspan="2" style="text-align: center;">
					<input type="button" onclick="cart()" value="장바구니 담기">
					&emsp;
					<input type="button" onclick="buy()" value="바로구매">
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
</body>
</html>