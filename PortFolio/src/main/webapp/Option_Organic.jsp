<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*,java.util.*"%>
<%
request.setCharacterEncoding("utf-8");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>친환경/유기농 정렬</title>

<style type='text/css'>
.tableoo {
	width: 100%;
	border: 0; /* 1px solid black; */
	border-collapse: collapse;
	padding: 10px;
	border-spacing: 10px;
	text-align: center;
}

.tableoo td {
	width: 22%;
	padding: 10px;
	border: 0; /* 1px solid black; */
	text-align: center;
	vertical-align: middle;
}

.scrolltable-container {
	border: none;
	width: 100%;
	height: 520px;
	margin-left: auto;
	margin-right: auto;
	overflow: scroll;
	box-sizing: border-box;
}

.scrolltable {
	width: 100%;
}
</style>
</head>

<body>
	<%
	String category = request.getParameter("category");
	String organic = request.getParameter("organic");

	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;

	try {
		Class.forName("com.mysql.jdbc.Driver");
		String url = "jdbc:mysql://localhost:3306/product";
		conn = DriverManager.getConnection(url, "product", "product");

		String sql = "";

		switch (category) {
		case "1":
			sql = "SELECT * FROM product WHERE p_category LIKE '%쌀·잡곡%' ";
			break;
		case "2":
			sql = "SELECT * FROM product WHERE p_category LIKE '%채소%' ";
			break;
		case "3":
			sql = "SELECT * FROM product WHERE p_category LIKE '%과일%' ";
			break;
		case "4":
			sql = "SELECT * FROM product WHERE p_category LIKE '%견과%' ";
			break;
		case "5":
			sql = "SELECT * FROM product WHERE p_category LIKE '%수산·건어물%' ";
			break;
		case "6":
			sql = "SELECT * FROM product WHERE p_category LIKE '%정육%' ";
			break;
		case "7":
			sql = "SELECT * FROM product WHERE p_category LIKE '%계란류·유제품%' ";
			break;
		case "8":
			sql = "SELECT * FROM product WHERE p_category LIKE '%차·음료·생수%' ";
			break;
		case "9":
			sql = "SELECT * FROM product WHERE p_category LIKE '%과자·간식·빵·빙과%' ";
			break;
		case "10":
			sql = "SELECT * FROM product WHERE p_category LIKE '%건강식품%' ";
			break;
		default:
			out.println("잘못된 요청입니다.");
			return;
		}

		switch (organic) {
		case "1":
			sql += "AND p_organic LIKE '%유기농%' ORDER BY p_num ASC";
			break;
		case "2":
			sql += "AND p_organic LIKE '%해당없음%' ORDER BY p_num ASC";
			break;
		default:
			out.println("잘못된 요청입니다.");
			return;
		}

		pstmt = conn.prepareStatement(sql);
		rs = pstmt.executeQuery(sql);
	%>
	<div class="scrolltable-container">
		<div class="scrolltable">
			<%
			int count = 0;
			int totalProducts = 0;

			while (rs.next()) {
				if (count % 4 == 0) {
					if (count != 0) {
			%>
			</tr>
			</table>
			<%
			}
			%><table class="tableoo"><tr>
					<%
					}
					int p_num = rs.getInt("p_num");
					String p_name = rs.getString("p_name");
					String p_img = rs.getString("p_img");
					String p_pay = rs.getString("p_pay");
					java.sql.Date p_day = rs.getDate("p_day");
					java.util.Date utilDate = new java.util.Date(p_day.getTime());
					java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyy-MM-dd");
					String formattedDate = sdf.format(utilDate);
					%>
					<td>
						<a href="Product_Output.jsp?p_num=<%=p_num%>"><img src="<%=p_img%>" alt="상품이미지" width="120" height="120"></a>
						<br>
						<a href="Product_Output.jsp?p_num=<%=p_num%>"><font size='4'><%=p_name%></font></a>
						<br>
						<font size='3'><%=p_pay%></font>
						<br>
						<font size='3'><%=p_day%></font>
					</td>
					<%
					count++;
					totalProducts++;
					}
					if (totalProducts % 4 != 0) {
					int remainingCells = 4 - (count % 4);
					for (int i = 0; i < remainingCells; i++) {
					%><td></td>
					<%
					}
					}
					%>
				</tr></table>
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