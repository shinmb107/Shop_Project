<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*,java.util.*"%>
<%
request.setCharacterEncoding("utf-8");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품검색</title>

<style type='text/css'>

.tableps {
    width: 100%;
    border: 0; /* 1px solid black; */
    border-collapse: collapse;
    padding: 10px;
    border-spacing: 10px;
    text-align: center;
}

.tableps td {
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
	String scategory = request.getParameter("scategory");
	String sname = request.getParameter("sname");

	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;

	try {
		Class.forName("com.mysql.jdbc.Driver");
		String url = "jdbc:mysql://localhost:3306/product";
		conn = DriverManager.getConnection(url, "product", "product");

		String strs = "";

		switch (scategory) {
		case "0":
			if (sname.equals(null)) {
		strs = "SELECT * FROM product ORDER BY p_num ASC";
			} else {
		strs = "SELECT * FROM product WHERE p_name LIKE '%" + sname + "%' ORDER BY p_num ASC";
			}
			break;

		case "1":
			if (sname.equals(null)) {
		strs = "SELECT * FROM product WHERE p_category='쌀·잡곡' ORDER BY p_num ASC";
			} else {
		strs = "SELECT * FROM product WHERE p_category='쌀·잡곡' AND p_name LIKE '%" + sname + "%' ORDER BY p_num ASC";
			}
			break;

		case "2":
			if (sname.equals(null)) {
		strs = "SELECT * FROM product WHERE p_category='채소' ORDER BY p_num ASC";
			} else {
		strs = "SELECT * FROM product WHERE p_category='채소' AND p_name LIKE '%" + sname + "%' ORDER BY p_num ASC";
			}
			break;

		case "3":
			if (sname.equals(null)) {
		strs = "SELECT * FROM product WHERE p_category='과일' ORDER BY p_num ASC";
			} else {
		strs = "SELECT * FROM product WHERE p_category='과일' AND p_name LIKE '%" + sname + "%' ORDER BY p_num ASC";
			}
			break;

		case "4":
			if (sname.equals(null)) {
		strs = "SELECT * FROM product WHERE p_category='견과' ORDER BY p_num ASC";
			} else {
		strs = "SELECT * FROM product WHERE p_category='견과' AND p_name LIKE '%" + sname + "%' ORDER BY p_num ASC";
			}
			break;

		case "5":
			if (sname.equals(null)) {
		strs = "SELECT * FROM product WHERE p_category='수산·건어물' ORDER BY p_num ASC";
			} else {
		strs = "SELECT * FROM product WHERE p_category='수산·건어물' AND p_name LIKE '%" + sname
				+ "%' ORDER BY p_num ASC";
			}
			break;

		case "6":
			if (sname.equals(null)) {
		strs = "SELECT * FROM product WHERE p_category='정육' ORDER BY p_num ASC";
			} else {
		strs = "SELECT * FROM product WHERE p_category='정육' AND p_name LIKE '%" + sname + "%' ORDER BY p_num ASC";
			}
			break;

		case "7":
			if (sname.equals(null)) {
		strs = "SELECT * FROM product WHERE p_category='계란류·유제품' ORDER BY p_num ASC";
			} else {
		strs = "SELECT * FROM product WHERE p_category='계란류·유제품' AND p_name LIKE '%" + sname
				+ "%' ORDER BY p_num ASC";
			}
			break;

		case "8":
			if (sname.equals(null)) {
		strs = "SELECT * FROM product WHERE p_category='차·음료·생수' ORDER BY p_num ASC";
			} else {
		strs = "SELECT * FROM product WHERE p_category='차·음료·생수' AND p_name LIKE '%" + sname
				+ "%' ORDER BY p_num ASC";
			}
			break;

		case "9":
			if (sname.equals(null)) {
		strs = "SELECT * FROM product WHERE p_category='과자·간식·빵·빙과' ORDER BY p_num ASC";
			} else {
		strs = "SELECT * FROM product WHERE p_category='과자·간식·빵·빙과' AND p_name LIKE '%" + sname
				+ "%' ORDER BY p_num ASC";
			}
			break;

		case "10":
			if (sname.equals(null)) {
		strs = "SELECT * FROM product WHERE p_category='건강식품' ORDER BY p_num ASC";
			} else {
		strs = "SELECT * FROM product WHERE p_category='건강식품' AND p_name LIKE '%" + sname + "%' ORDER BY p_num ASC";
			}
			break;

		default:
			strs = "SELECT * FROM product ORDER BY p_num ASC";
			break;
		}

		pstmt = conn.prepareStatement(strs);
		rs = pstmt.executeQuery(strs);
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
            %><table class="tableps"><tr>
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