<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*,java.util.*"%>
<%
request.setCharacterEncoding("utf-8");
String logID = (String) session.getAttribute("logID");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>메인화면 상품</title>

<style type='text/css'>
.center {
	text-align: center;
	margin: 0 auto;
}

.left {
	text-align: left;
	margin: 0 auto;
}

.slide-container {
	width: 98%;
	overflow: hidden;
	position: relative;
	border: 1px solid gray;
	padding: 10px;
}

.slide {
	display: flex;
	transition: transform 0.5s ease-in-out;
	gap: 150px;
}

.slide-item {
	width: 100%;
	display: none;
}

.active {
	display: block;
}

.tableph {
	width: 100%;
	border: 0; /* 1px solid black; */
	border-collapse: collapse;
	padding: 10px;
	border-spacing: 10px;
	text-align: center;
}

.tableph td {
	width: 20%;
	padding: 10px;
	border: 0; /* 1px solid black; */
	text-align: center;
	vertical-align: middle;
}

.scrolltable-container {
	border: 1px solid gray; /* 전체 테두리 스타일링 */
	width: 100%;
	height: 550px;
	margin-left: auto;
	margin-right: auto;
	overflow: scroll;
	box-sizing: border-box;
}

.scrolltable {
	width: 100%;
}

a:link {
	color: black;
	text-decoration: none;
}

a:visited {
	color: black;
	text-decoration: underline;
}

a:hover {
	color: black;
	text-decoration: underline;
}
</style>

<script>
	let currentIndex1 = 0;
	let currentIndex2 = 0;
	let itemsPerPage = 3;

	function showSlides(slideClass, currentIndex) {
		let slides = document.querySelectorAll(slideClass + ' .slide-item');
		for (let i = 0; i < slides.length; i++) {
			slides[i].classList.remove('active');
		}

		for (let i = 0; i < itemsPerPage; i++) {
			let index = (currentIndex * itemsPerPage + i) % slides.length;
			slides[index].classList.add('active');
		}

		return (currentIndex + 1) % Math.ceil(slides.length / itemsPerPage);
	}

	function startSlides() {
		setInterval(function() {
			currentIndex1 = showSlides('#slide-container1', currentIndex1);
		}, 3000);

		setInterval(function() {
			currentIndex2 = showSlides('#slide-container2', currentIndex2);
		}, 3000);
	}
</script>

</head>
<body onload="startSlides()">
	<%
	Connection conn = null;
	PreparedStatement pstmtb = null;
	ResultSet rsb = null;
	PreparedStatement pstmtn = null;
	ResultSet rsn = null;
	PreparedStatement pstmtp = null;
	ResultSet rsp = null;

	try {
		Class.forName("com.mysql.jdbc.Driver");
		String url = "jdbc:mysql://localhost:3306/product";
		conn = DriverManager.getConnection(url, "product", "product");

		String sqlb = "SELECT * FROM product ORDER BY p_buycount ASC LIMIT 9";
		pstmtb = conn.prepareStatement(sqlb);
		rsb = pstmtb.executeQuery(sqlb);
	%>
	<h1 style="font-size: 20px; text-align: left;">
		<img src="img/best.jpg" width="35" height="35"> 인기상품
	</h1>
	<div class="center">
		<div id="slide-container1" class="slide-container">
			<div class="slide" id="slide1">
				<%
				while (rsb.next()) {
					int p_num = rsb.getInt("p_num");
					String p_name = rsb.getString("p_name");
					String p_img = rsb.getString("p_img");
				%>
				<div class="slide-item">
					<a href="Product_Output.jsp?p_num=<%=p_num%>"><img src="<%=p_img%>" alt="<%=p_name%>" width="230" height="230" style="border: 2px solid gray; padding: 5px;"></a>
				</div>
				<%
				}
				%>
			</div>
		</div>
	</div>
	<br>

	<h1 style="font-size: 20px; text-align: left;">
		<img src="img/new.jpg" width="35" height="35"> 신상품
	</h1>
	<%
	String sqln = "SELECT * FROM product ORDER BY p_regdate DESC LIMIT 9";
	pstmtn = conn.prepareStatement(sqln);
	rsn = pstmtn.executeQuery(sqln);
	%>
	<div class="center">
		<div id="slide-container2" class="slide-container">
			<div class="slide" id="slide2">
				<%
				while (rsn.next()) {
					int p_num = rsn.getInt("p_num");
					String p_name = rsn.getString("p_name");
					String p_img = rsn.getString("p_img");
				%>
				<div class="slide-item">
					<a href="Product_Output.jsp?p_num=<%=p_num%>"><img src="<%=p_img%>" alt="<%=p_name%>" width="230" height="230" style="border: 2px solid gray; padding: 5px;"></a>
				</div>
				<%
				}
				%>
			</div>
		</div>
	</div>

	<%
	String sqlp = "SELECT * FROM product ORDER BY p_num ASC";
	pstmtp = conn.prepareStatement(sqlp);
	rsp = pstmtp.executeQuery(sqlp);
	%>
	<br>
	<h1 style="font-size: 20px; text-align: left;">모든상품</h1>
	<div class="left">
		<div class="scrolltable-container">
			<div class="scrolltable">
				<%
				int count = 0;
				int totalProducts = 0;

				while (rsp.next()) {
					if (count % 4 == 0) {
						if (count != 0) {
				%></tr>
				</table>
				<%
				}
				%><table class="tableph"><tr>
						<%
						}
						int p_num = rsp.getInt("p_num");
						String p_name = rsp.getString("p_name");
						String p_img = rsp.getString("p_img");
						String p_pay = rsp.getString("p_pay");
						java.sql.Date p_day = rsp.getDate("p_day");
						java.util.Date utilDate = new java.util.Date(p_day.getTime());
						java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyy-MM-dd");
						String formattedDate = sdf.format(utilDate);
						%>
						<td>
							<a href="Product_Output.jsp?p_num=<%=p_num%>"><img src="<%=p_img%>" alt="상품이미지" width="150" height="150" style="border: 2px solid gray; padding: 5px;"></a>
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
	</div>
	<%
	} catch (Exception e) {
	e.printStackTrace();
	} finally {
	try {
		rsp.close();
		pstmtp.close();
		rsn.close();
		pstmtn.close();
		rsb.close();
		pstmtb.close();
		conn.close();
	} catch (Exception e) {
		e.printStackTrace();
	}
	}
	%>
</body>
</html>