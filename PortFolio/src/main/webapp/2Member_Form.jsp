<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.util.*"%>
<%
request.setCharacterEncoding("utf-8");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입 화면</title>

<style type='text/css'>
.center {
    text-align: center;
    margin: 0 auto;
}

.tablemf {
    width: 600px;
    border: none; /* 1px solid black; */
    border-collapse: collapse;
    padding: 0;
    border-spacing: 0;
    margin-left: auto;
    margin-right: auto;
}

.tablemf td {
    padding: 0;
    border: 0; /* 1px solid black; */
    text-align: center;
    vertical-align: middle;
}

.tablemf1 {
    width: 600px;
    border: 1px solid black; /* 1px solid black; */
    border-collapse: collapse;
    padding: 5px;
    border-spacing: 0;
    margin-left: auto;
    margin-right: auto;
    background-color: #FFEAD0;
}

.tablemf1 td {
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
            alert("이름을 입력하세요.")
            Member.name.focus();
            return false;
        }
        if (Member.tel1.value.length < 1 || Member.tel2.value.length < 1 || Member.tel3.value.length < 1) {
            alert("전화번호를 입력하세요.");
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
            alert("주소를 입력하세요.")
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
    <div class="center">
        <table class="tablemf">
            <tr>
                <td><jsp:include page="0Main_AC.jsp" flush="false" /></td>
            </tr>
        </table>

        <table class="tablemf1">
            <tr height="50">
                <td>
                    <h1 style="font-size: 25px;">회원가입</h1>
                </td>
            </tr>
        </table>

        <form name="Member" method="post" action="2MemberPro.jsp">
            <table class="tablemf1">
                <tr>
                    <td>
                        <br>
                    </td>
                </tr>

                <tr height="60">
                    <td valign="middle">
                        <input type="text" maxlength="50" name="id" placeholder="아이디 입력" class="text" style="width: 75%;">
                        <input type="button" OnClick="Check_id()" value="ID 중복검사">
                    </td>
                </tr>

                <tr height="60">
                    <td valign="middle">
                        <input type="text" maxlength="50" name="pass" placeholder="비밀번호 입력" class="text">
                    </td>
                </tr>

                <tr height="60">
                    <td>
                        <input type="text" maxlength="50" name="name" placeholder="이름 입력" class="text">
                    </td>
                </tr>

                <tr height="60">
                    <td>
                        <input type="text" maxlength="3" name="tel1" placeholder="전화번호 입력" class="text" style="width: 22%;">
                        -
                        <input type="text" maxlength="4" name="tel2" class="text" style="width: 30%;">
                        -
                        <input type="text" maxlength="4" name="tel3" class="text" style="width: 30%;">
                    </td>
                </tr>

                <tr height="60">
                    <td>
                        <input type="text" maxlength="50" name="address" placeholder="주소 입력" class="text">
                    </td>
                </tr>

                <tr height="60">
                    <td>
                        <input type="text" maxlength="50" name="email" placeholder="이메일 입력" class="text">
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

            <table class="tablemf">
                <tr style="background-color: white;">
                    <td>
                        <input type="button" class="text-button" value="판매자 회원가입" onclick="location.href='0Seller_Member_Form.jsp'">
                    </td>
                </tr>
            </table>
        </form>
    </div>
</body>
</html>