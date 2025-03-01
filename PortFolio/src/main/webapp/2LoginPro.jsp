<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.util.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인 동작</title>
</head>

<body>
	<%
	String id = request.getParameter("id");
	String pw = request.getParameter("pw");

	Connection conn = null; /* 디비랑 연결할떄 */
	PreparedStatement pstmt = null; /* 디비에 값 넘길때 (반복) */
	Statement stmt = null; /* 디비에 값 넘길때 (단순) */
	ResultSet rs = null; /*디비 값 불러올떄  */

	try {
		Class.forName("com.mysql.jdbc.Driver");
		String jdbcUrl = "jdbc:mysql://localhost:3306/member";
		conn = DriverManager.getConnection(jdbcUrl, "member", "member");

        if ("manager".equals(id) && "0000".equals(pw)) {
        	session.setAttribute("logID", id);
        	session.setAttribute("userType", "manager");
            out.println("<script>alert('관리자 로그인되었습니다.'); location.href='1Main_Form.jsp';</script>");  
        } else {
            String sql = "SELECT * FROM member WHERE id=?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, id);
            rs = pstmt.executeQuery();

            if (rs.next()) {
                if (id.equals(rs.getString("id")) && pw.equals(rs.getString("pass"))) {
                    session.setAttribute("logID", id);
                    String seller = rs.getString("seller");

                    if (seller != null && !seller.isEmpty()) {
                        session.setAttribute("userType", "seller");
                        out.println("<script>alert('판매자 로그인되었습니다.'); location.href='1Main_Form.jsp';</script>");
                    } else {
                    	session.setAttribute("userType", "user");
                        out.println("<script>alert('로그인되었습니다. 환영합니다.'); history.back();");
                        out.println("setTimeout(function() { history.back();");
                        out.println("setTimeout(function() { history.back();");
                        out.println("setTimeout(function() { location.reload(); ");
                        out.println("setTimeout(function() { location.reload(); ");
                        out.println("}, 1); }, 1); }, 1); }, 1); </script>");
                    }

                } else if (id.equals(rs.getString("id")) && !pw.equals(rs.getString("pass"))) {
                    out.println("<script>alert('비밀번호가 틀렸습니다. 다시 입력해 주세요'); location.href='2Login_Form.jsp';</script>");
                } else {
                    out.println("<script>alert('아이디가 틀렸습니다. 다시 입력해 주세요'); location.href='2Login_Form.jsp';</script>");
                }
            } else {
                out.println("<script>alert('가입된 정보가 없습니다.'); location.href='2Login_Form.jsp';</script>");
            }
        }

	} catch (Exception e) {
		out.println("<script>alert('가입된 정보가 없습니다.'); location.href='2Login_Form.jsp';</script>");
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