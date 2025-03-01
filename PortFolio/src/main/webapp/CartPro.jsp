<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.util.*"%>
<%
request.setCharacterEncoding("utf-8");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>장바구니 동작</title>
</head>

<body>
    <%
    String c_id = (String) session.getAttribute("logID");
    
    if (c_id == null) {
        response.sendRedirect("2Login_Form.jsp");
        return;
    }
    
    String p_num = request.getParameter("p_num");
    
    String urlProduct = null;
    String urlCart= null;
    Connection connProduct = null;
    Connection connCart = null;
    PreparedStatement pstmtProduct = null;
    PreparedStatement pstmtCart = null;
    
    ResultSet rs = null;

    try {
        Class.forName("com.mysql.jdbc.Driver");
        urlProduct = "jdbc:mysql://localhost:3306/product";
        connProduct = DriverManager.getConnection(urlProduct, "product", "product");

        String sql = "SELECT * FROM product WHERE p_num=?";
        pstmtProduct = connProduct.prepareStatement(sql);
        pstmtProduct.setInt(1, Integer.parseInt(p_num));

        rs = pstmtProduct.executeQuery();
        rs.next();

        String c_img = rs.getString("p_img");
        String c_name = rs.getString("p_name");
        String c_pay = rs.getString("p_pay");
        String c_day = rs.getString("p_day");
        String c_keep = rs.getString("p_keep");
        
        Class.forName("com.mysql.jdbc.Driver");
        urlCart = "jdbc:mysql://localhost:3306/cart";
        connCart = DriverManager.getConnection(urlCart, "cart", "cart");
        
        String SQL = "INSERT INTO cart(c_id, c_img, c_name, c_pay, c_day, c_keep) ";
        SQL += "VALUES (?, ?, ?, ?, ?, ?)";
        pstmtCart = connCart.prepareStatement(SQL);
        
        pstmtCart.setString(1, c_id);
        pstmtCart.setString(2, c_img);
        pstmtCart.setString(3, c_name);
        pstmtCart.setString(4, c_pay);
        pstmtCart.setString(5, c_day);
        pstmtCart.setString(6, c_keep);
        pstmtCart.executeUpdate();

        response.sendRedirect("Cart_List.jsp");

	} catch (Exception e) {
		System.out.println(e.getMessage());

	} finally {
		try {
			rs.close();
			pstmtCart.close();
            connCart.close();
			pstmtProduct.close();
			connProduct.close();

		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
	}
	%>
</body>
</html>