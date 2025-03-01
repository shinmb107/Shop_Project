<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.util.*"%>
<%
request.setCharacterEncoding("utf-8");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>내정보 수정</title>

<style type='text/css'>
.center {
    text-align: center;
    margin: 0 auto;
}

.tablesu {
    width: 600px;
    border: none; /* 1px solid black; */
    border-collapse: collapse;
    padding: 0;
    border-spacing: 0;
    margin-left: auto;
    margin-right: auto;
}

.tablesu td {
    padding: 0;
    border: 0; /* 1px solid black; */
    text-align: center;
    vertical-align: middle;
}

.tablesu1 {
    width: 600px;
    border: 1px solid black; /* 1px solid black; */
    border-collapse: collapse;
    padding: 5px;
    border-spacing: 0;
    margin-left: auto;
    margin-right: auto;
    background-color: #FFEAD0;
}

.tablesu1 td {
    padding: 0;
    border: 0; /* 1px solid black; */
    text-align: center;
    vertical-align: middle;
}

.text {
    width: 90%;
    height: 20pt;
}

.button {
    width: 90%;
    height: 25pt;
}

.text-button {
    background: none;
    border: none;
    color: inherit;
    font: inherit;
    padding: 0;
    cursor: pointer;
    width: 20%;
    height: 25pt;
    margin: 50px;
}
</style>

<script>
	function Check() {
		if (Member.id.value.length < 1) {
			alert("아이디를 입력하세요.")
			Member.id.focus();
			return false;
		}
		if (Member.pass.value.length < 1) {
			alert("비밀번호를 입력하세요.")
			Member.pass.focus();
			return false;
		}
		if (Member.name.value.length < 1) {
			alert("사업자 이름을 입력하세요.")
			Member.name.focus();
			return false;
		}
		if (Member.number1.value.length < 1 || Member.number2.value.length < 1 || Member.number3.value.length < 1) {
	        alert("사업자 번호를 모두 입력하세요.");
	        if (Member.number1.value.length < 1) {
	            Member.number1.focus();
	        } else if (Member.number2.value.length < 1) {
	            Member.number2.focus();
	        } else {
	            Member.number3.focus();
	        }
	        return false;
	    }
		if (Member.tel1.value.length < 1 || Member.tel2.value.length < 1 || Member.tel3.value.length < 1) {
	        alert("사업자 전화번호를 모두 입력하세요.");
	        if (Member.tel1.value.length < 1) {
	            Member.tel1.focus();
	        } else if (Member.tel2.value.length < 1) {
	            Member.tel2.focus();
	        } else {
	            Member.tel3.focus();
	        }
	        return false;
	    }
		if (Member.address.value.length < 1) {
            alert("사업자 주소를 입력하세요.")
            Member.address.focus();
            return false;
        }
		if (Member.email.value.indexOf("@") + "" == "-1"
				|| Member.email.value.indexOf(".") + "" == "-1"
				|| Member.email.value == "") {
			alert("E-mail을 정확히 입력하세요.('@', '.' 포함)")
			Member.email.focus();
			return false;
		}
		Member.submit();
	}

	function Check_id() {
		browsing_window = window
				.open(
						"2Member_ChkID.jsp?id=" + Member.id.value,
						"_idcheck",
						"height=300, width=600, menubar=no, directories=no, resizable=no, status=no, scrollbars=yes");
		browsing_window.focus();
	}
</script>
</head>

<body>
	<%
	String logID = request.getParameter("logID");

	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;

	try {
		Class.forName("com.mysql.jdbc.Driver");
		String jdbcUrl = "jdbc:mysql://localhost:3306/member";
		conn = DriverManager.getConnection(jdbcUrl, "member", "member");

		String sql = "SELECT * FROM member WHERE id=?";
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, logID);

		rs = pstmt.executeQuery();
		rs.next();

		String id = rs.getString("id");
		String pass = rs.getString("pass");
		String name = rs.getString("name");
		String number = rs.getString("number");
		String tel = rs.getString("tel");
		String address = rs.getString("address");
		String email = rs.getString("email");
		java.sql.Date date = rs.getDate("date");
		java.util.Date utilDate = new java.util.Date(date.getTime());
		java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyy-MM-dd");
		String formattedDate = sdf.format(utilDate);
		
		String[] numberParts = number.split("-");
        String number1 = numberParts.length > 0 ? numberParts[0] : ""; 
        String number2 = numberParts.length > 1 ? numberParts[1] : ""; 
        String number3 = numberParts.length > 2 ? numberParts[2] : "";

        String[] telParts = tel.split("-");
        String tel1 = telParts.length > 0 ? telParts[0] : ""; 
        String tel2 = telParts.length > 1 ? telParts[1] : ""; 
        String tel3 = telParts.length > 2 ? telParts[2] : "";

	%>
	<div class="center">
        <table class="tablesu">
            <tr>
                <td><jsp:include page="0Main_AC.jsp" flush="false" /></td>
            </tr>
        </table>

        <table class="tablesu1">
            <tr height="50">
                <td>
                    <h1 style="font-size: 25px;">회원가입</h1>
                </td>
            </tr>
        </table>

        <form name="Member" method="post" action="0Seller_Member_UpdatePro.jsp">
            <table class="tablesu1">
                <tr>
                    <td>
                        <br>
                    </td>
                </tr>

                <tr height="60">
                    <td valign="middle">
                        <input type="text" maxlength="50" name="id" value="<%=id%>" class="text" style="width: 75%;">
                        <input type="button" OnClick="Check_id()" value="ID 중복검사">
                    </td>
                </tr>

                <tr height="60">
                    <td valign="middle">
                        <input type="text" maxlength="50" name="pass" value="<%=pass%>" class="text">
                    </td>
                </tr>

                <tr height="60">
                    <td>
                        <input type="text" maxlength="50" name="name" value="<%=name%>" class="text">
                    </td>
                </tr>

                <tr height="60">
                    <td>
                        <input type="text" maxlength="3" name="number1" value="<%=number1%>" class="text" style="width: 27%;">
                        -
                        <input type="text" maxlength="2" name="number2" value="<%=number2%>" class="text" style="width: 20%;">
                        -
                        <input type="text" maxlength="5" name="number3" value="<%=number3%>" class="text" style="width: 35%;">
                    </td>
                </tr>

                <tr height="60">
                    <td>
                        <input type="text" maxlength="3" name="tel1" value="<%=tel1%>" class="text" style="width: 22%;">
                        -
                        <input type="text" maxlength="4" name="tel2" value="<%=tel2%>" class="text" style="width: 30%;">
                        -
                        <input type="text" maxlength="4" name="tel3" value="<%=tel3%>" class="text" style="width: 30%;">
                    </td>
                </tr>

                <tr height="60">
                    <td>
                        <input type="text" maxlength="50" name="address" value="<%=address%>" class="text">
                    </td>
                </tr>

                <tr height="60">
                    <td>
                        <input type="text" maxlength="50" name="email" value="<%=email%>" class="text">
                    </td>
                </tr>

                <tr height="60">
                    <td>
                        <br>
                        <br>
                        <input type="button" style="background-color: #A7EEFF;" class="button" OnClick="Check()" value="가입하기">
                        <br>
                        <br>
                        <hr size="1" noshade>
                        <br>
                        <input type="button" class="button" onclick="location.href='2Login_Form.jsp'" value="로그인하기">
                        <br>
                        <br>
                    </td>
                </tr>
            </table>
        </form>
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