<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*,java.util.*"%>
<%
request.setCharacterEncoding("utf-8");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품목록</title>

<style type='text/css'>
.center {
	text-align: center;
	margin: 0 auto;
}

.tablepl {
	width: 80%;
	border: none; /* 1px solid black; */
	border-collapse: collapse;
	padding: 0;
	border-spacing: 0;
	margin-left: auto;
	margin-right: auto;
}

.tablepl td {
	padding: 0;
	border: 0; /* 1px solid black; */
	text-align: center;
	vertical-align: middle;
}

.tablepl1 {
	width: 80%;
	border: 1px solid black; /* 1px solid black; */
	border-collapse: collapse;
	padding: 2px;
	border-spacing: 1px;
	margin-left: auto;
	margin-right: auto;
	background-color: #7FFFD4;
}

.tablepl1 td {
	padding: 0;
	border: 1px solid black; /* 1px solid black; */
	text-align: center;
	vertical-align: middle;
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
		String url = "jdbc:mysql://localhost:3306/product";
		conn = DriverManager.getConnection(url, "product", "product");

		String sql = "SELECT * FROM product ORDER BY p_num ASC";
		pstmt = conn.prepareStatement(sql);
		rs = pstmt.executeQuery(sql);
	%>
	<div class="center">
		<table class="tablepl">
			<tr>
				<td><jsp:include page="0Main_AC.jsp" flush="false" /></td>
			</tr>
		</table>

		<table class="tablepl1">
			<tr height="50">
				<td>
					<h1 style="font-size: 20px;">상품목록</h1>
				</td>
			</tr>
		</table>

		<table class="tablepl1">
			<tr height="30px">
				<td>
					<font size='2'><b> 등록일 </b></font>
				</td>
				<td>
					<font size='2'><b> 상품사진 </b></font>
				</td>
				<td>
					<font size='2'><b> 상품이름 </b></font>
				</td>
				<td>
					<font size='2'><b> 상품가격 </b></font>
				</td>
				<td>
					<font size='2'><b> 등록개수 </b></font>
				</td>
				<td>
					<font size='2'><b> 유통기한 </b></font>
				</td>
				<td>
					<font size='2'><b> 보관방식 </b></font>
				</td>
				<td>
					<font size='2'><b> 구성방식 </b></font>
				</td>
				<td>
					<font size='2'><b> 유기농/친환경 </b></font>
				</td>
				<td>
					<font size='2'><b> 카테고리 </b></font>
				</td>
				<td>
					<font size='2'><b> 판매량 </b></font>
				</td>
				<td>
					<font size='2'><b> 상품설명 </b></font>
				</td>
				<td>
					<font size='2'><b> 수정 / 삭제 </b></font>
				</td>
			</tr>
			<%
			while (rs.next()) {
				int p_num = rs.getInt("p_num");
				String p_img = rs.getString("p_img");
				String p_name = rs.getString("p_name");
				String p_pay = rs.getString("p_pay");
				String p_count = rs.getString("p_count");
				String p_keep = rs.getString("p_keep");
				String p_set = rs.getString("p_set");
				String p_organic = rs.getString("p_organic");
				String p_category = rs.getString("p_category");
				String p_buycount = rs.getString("p_buycount");
				String p_explan = rs.getString("p_explan");

				java.sql.Date p_day = rs.getDate("p_day");
				java.util.Date utilDate = new java.util.Date(p_day.getTime());
				java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyy-MM-dd");
				String formattedDate = sdf.format(utilDate);

				java.sql.Date p_regdate = rs.getDate("p_regdate");
				java.util.Date utilDater = new java.util.Date(p_regdate.getTime());
				java.text.SimpleDateFormat sdfr = new java.text.SimpleDateFormat("yyyy-MM-dd");
				String formattedDater = sdfr.format(utilDater);
			%>
			<tr height="50px">
				<td>
					<input type="hidden" value="<%=p_num%>">
					<font size="2" color="black"> <%=p_regdate%>
					</font>
				</td>
				<td>
					<img src="<%=p_img%>" alt="상품이미지" width="100" height="100">
				</td>
				<td>
					<font size="2" color="black"> <%=p_name%>
					</font>
				</td>
				<td>
					<font size="2" color="black"> <%=p_pay%>
					</font>
				</td>
				<td>
					<font size="2" color="black"> <%=p_day%>
					</font>
				</td>
				<td>
					<font size="2" color="black"> <%=p_keep%>
					</font>
				</td>
				<td>
					<font size="2" color="black"> <%=p_set%>
					</font>
				</td>
				<td>
					<font size="2" color="black"> <%=p_organic%>
					</font>
				</td>
				<td>
					<font size="2" color="black"> <%=p_category%>
					</font>
				</td>
				<td>
					<font size="2" color="black"> <%=p_buycount%>
					</font>
				</td>
				<td>
					<font size="2" color="black"> 
					<% if (p_explan != null && !p_explan.trim().isEmpty()) { %>
					<input type="button" onclick="location.href='Product_Update.jsp?p_num=<%=p_num%>'" value="설명확인">
					<% } else { %> 
					   설명없음
					   <br>
					   <input type="button" onclick="location.href='Product_Update.jsp?p_num=<%=p_num%>'" value="설명추가">
				    <% } %>
					</font>
				</td>
				<td>
					<input type="button" onclick="location.href='Product_Update.jsp?p_num=<%=p_num%>'" value="수정">
					<input type="button" onclick="location.href='Product_Delete.jsp?p_num=<%=p_num%>'" value="삭제">
				</td>
			</tr>
			<%
			}
			%>
			<tr height="30">
				<td colspan="13">
					<input type="button" onclick="location.href='1Main_Form.jsp'" value="메인으로">
					&emsp;
					<input type="button" onclick="location.href='Product_Form.jsp'" value="상품등록">
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