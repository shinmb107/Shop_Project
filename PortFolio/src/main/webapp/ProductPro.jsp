<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.util.*, java.text.SimpleDateFormat"%>
<%
request.setCharacterEncoding("utf-8");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품등록 동작</title>
</head>

<body>
	<%
	String p_id = (String) session.getAttribute("logID");
	String p_img = "uploads/" + request.getAttribute("uploadedFileName");
	String p_name = request.getParameter("p_name");
	String p_pay = request.getParameter("p_pay");
	String p_count = request.getParameter("p_count");
	String p_day = request.getParameter("p_day");
	String p_category = request.getParameter("p_category");
	String[] p_keep = request.getParameterValues("p_keep");
	String[] p_set = request.getParameterValues("p_set");
	String[] p_organic = request.getParameterValues("p_organic");
	String p_explan = request.getParameter("p_explan");

	java.util.Date now = new java.util.Date();
	SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	String p_regdate = dateFormat.format(now);

	String chk_keep = "";
	if (p_keep != null) {
		for (int i = 0; i < p_keep.length; i++) {
			chk_keep += p_keep[i] + " ";
		}
	}

	String chk_set = "";
	if (p_set != null) {
		for (int i = 0; i < p_set.length; i++) {
			chk_set += p_set[i] + " ";
		}
	}

	String chk_organic = "";
	if (p_organic != null) {
		for (int i = 0; i < p_organic.length; i++) {
			chk_organic += p_organic[i] + " ";
		}
	}

	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;

	try {
		Class.forName("com.mysql.jdbc.Driver");
		String url = "jdbc:mysql://localhost:3306/product";
		conn = DriverManager.getConnection(url, "product", "product");

		String sql = "INSERT INTO product(p_id, p_img, p_name, p_pay, p_count, p_day, p_category, p_keep, p_set, p_organic, p_explan, p_regdate) ";
		sql += "VALUES(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
		pstmt = conn.prepareStatement(sql);

		pstmt.setString(1, p_id);
		pstmt.setString(2, p_img);
		pstmt.setString(3, p_name);
		pstmt.setString(4, p_pay);
		pstmt.setString(5, p_count);
		pstmt.setString(6, p_day);
		pstmt.setString(7, p_category);
		pstmt.setString(8, chk_keep);
		pstmt.setString(9, chk_set);
		pstmt.setString(10, chk_organic);
		pstmt.setString(11, p_explan);
		pstmt.setString(12, p_regdate);
		pstmt.executeUpdate();

		response.sendRedirect("Product_List.jsp");

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