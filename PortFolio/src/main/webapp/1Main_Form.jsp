<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>메인화면</title>

<style type='text/css'>
.center {
	text-align: center;
	margin: 0 auto;
}

.table {
	width: 1200px;
	border: none; /* 1px solid black; */
	border-collapse: collapse;
	padding: 0;
	border-spacing: 0;
	margin-left: auto;
	margin-right: auto;
}

.table td {
	padding: 0;
	border: none; /* 1px solid black; */
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
	String userType = (String)session.getAttribute("userType");
	
	String topPage = "";
	
	if ("manager".equals(userType)) {
        topPage = "0Manager_Top.jsp";
    } else if ("seller".equals(userType)) {
        topPage = "0Seller_Top.jsp";
    } else {
        topPage = "1Main_Top.jsp";
    }
	
	String select = request.getParameter("pageChange");
	String pageChange;
	if (select == null) {
		select = "Product_Home.jsp";
	}
	%>
	<div class="center">
		<table class="table">
			<tr>
				<td><jsp:include page="<%=topPage%>" flush="false" /></td>
			</tr>

			<tr>
				<td style="vertical-align: top;"><jsp:include page="<%=select%>" flush="false" /></td>
			</tr>

			<tr>
				<td><jsp:include page="1Main_Botton.jsp" flush="false" /></td>
			</tr>
		</table>
	</div>
</body>
</html>