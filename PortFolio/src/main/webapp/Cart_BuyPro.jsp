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
    String b_id = request.getParameter("b_id");
    String b_name = request.getParameter("b_name");
    String b_email = request.getParameter("b_email");
    String b_address = request.getParameter("b_address");
    String b_img = request.getParameter("b_img");
    String b_cname = request.getParameter("b_cname");
    String b_pay = request.getParameter("b_pay");
    String b_day = request.getParameter("b_day");
    String b_keep = request.getParameter("b_keep");

    String urlb = null;
    String urlp = null;
    Connection connb = null;
    Connection connp = null;
    PreparedStatement pstmtb = null;
    PreparedStatement pstmtp = null;
    ResultSet rsb = null;
    ResultSet rsp = null;

    try {
        Class.forName("com.mysql.jdbc.Driver");
        urlb = "jdbc:mysql://localhost:3306/cart";
        connb = DriverManager.getConnection(urlb, "cart", "cart");

        String SQL = "INSERT INTO buy(b_id, b_name, b_email, b_address, b_img, b_cname, b_pay, b_day, b_keep) ";
        SQL += "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
        pstmtb = connb.prepareStatement(SQL);
        
        pstmtb.setString(1, b_id);
        pstmtb.setString(2, b_name);
        pstmtb.setString(3, b_email);
        pstmtb.setString(4, b_address);
        pstmtb.setString(5, b_img);
        pstmtb.setString(6, b_cname);
        pstmtb.setString(7, b_pay);
        pstmtb.setString(8, b_day);
        pstmtb.setString(9, b_keep);
        pstmtb.executeUpdate();
        
        pstmtb.close();
        
        String strSQL = "DELETE FROM cart WHERE c_name=?";
        pstmtb = connb.prepareStatement(strSQL);
        pstmtb.setString(1, b_cname);
        pstmtb.executeUpdate();
        
        response.sendRedirect("2My_List.jsp");
        
        Class.forName("com.mysql.jdbc.Driver");
        urlp = "jdbc:mysql://localhost:3306/product";
        connp = DriverManager.getConnection(urlp, "product", "product");
        
        String strSQLp = "UPDATE product SET p_buycount=p_buycount+1 WHERE p_img=? AND p_name=? AND p_pay=?";
        pstmtp = connp.prepareStatement(strSQLp);
        pstmtp.setString(1, b_img);
        pstmtp.setString(2, b_cname);
        pstmtp.setString(3, b_pay);
        pstmtp.executeUpdate();

    } catch (Exception e) {
        e.printStackTrace();

    } finally {
        try {
            pstmtp.close();
            connp.close();
            pstmtb.close();
            connb.close();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    %>
</body>
</html>