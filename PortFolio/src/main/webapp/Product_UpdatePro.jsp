<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*,java.util.*"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>상품 수정 동작</title>
</head>
<body>
    <%
    String p_img = "updates/" + request.getAttribute("updatedFileName");
    String p_num = request.getParameter("p_num");
    String p_name = request.getParameter("p_name");
    String p_pay = request.getParameter("p_pay");
    String p_count = request.getParameter("p_count");
    String p_day = request.getParameter("p_day");
    String p_category = request.getParameter("p_category");
    String[] p_keep = request.getParameterValues("p_keep");
    String[] p_set = request.getParameterValues("p_set");
    String[] p_organic = request.getParameterValues("p_organic");
    String p_explan = request.getParameter("p_explan");

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

    try {
        Class.forName("com.mysql.jdbc.Driver");
        String url = "jdbc:mysql://localhost:3306/product";
        conn = DriverManager.getConnection(url, "product", "product");

        String sql = "UPDATE product SET p_img=?, p_name=?, p_pay=?, p_count=?, p_day=?, p_category=?, p_keep=?, p_set=?, p_organic=?, p_explan=? WHERE p_num=?";
        
        pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, p_img);
        pstmt.setString(2, p_name);
        pstmt.setString(3, p_pay);
        pstmt.setString(4, p_count);
        pstmt.setString(5, p_day);
        pstmt.setString(6, p_category);
        pstmt.setString(7, chk_keep);
        pstmt.setString(8, chk_set);
        pstmt.setString(9, chk_organic);
        pstmt.setString(10, p_explan);
        pstmt.setInt(11, Integer.parseInt(p_num));
        pstmt.executeUpdate();

        response.sendRedirect("Product_List.jsp");

    } catch (Exception e) {
    	out.println(e.getMessage());

        } finally {
        try {
            pstmt.close();
            conn.close();

        } catch (Exception e) {
        	out.println(e.getMessage());
        }
        }
    %>
</body>
</html>