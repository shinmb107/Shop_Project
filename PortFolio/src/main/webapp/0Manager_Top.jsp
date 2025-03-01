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
<title>메인화면 상단</title>

<style type='text/css'>
.center {
    text-align: center;
    margin: 0 auto;
}

.tablemt {
    width: 100%;
    border: none; /* 1px solid black; */
    border-collapse: collapse;
    padding: 0;
    border-spacing: 0;
    margin-left: auto;
    margin-right: auto;
}

.tablemt td {
    padding: 0;
    border: 0; /* 1px solid black; */
    text-align: center;
    vertical-align: middle;
}

.tablemt1 {
    width: 100%;
    border: 1px solid black; /* 1px solid black; */
    border-collapse: collapse;
    padding: 0;
    border-spacing: 0;
    margin-left: auto;
    margin-right: auto;
    border-collapse: collapse;
}

.tablemt1 td {
    padding: 0;
    border: 0; /* 1px solid black; */
    text-align: center;
    vertical-align: middle;
}

.text-button {
    background: none;
    border: none;
    color: inherit;
    font: inherit;
    padding: 0;
    cursor: pointer;
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
    <div class="center">
        <form method="post" action="?pageChange=Product_Search.jsp">
            <table class="tablemt">
                <tr>
                    <td height="40" colspan="6" style="text-align: right;">
                        <%
                        if (logID != null) {
                        %>
                        <a href="2My_List.jsp?logID=<%=logID%>"> <%=logID%></a> 님 &emsp; <a href="2LogoutPro.jsp">로그아웃</a> &emsp; <a href="3Write_Listboard.jsp">고객센터</a>
                        <%
                        } else {
                        %>
                        <a href="2Login_Form.jsp">로그인</a> &emsp; <a href="2Member_Form.jsp">회원가입</a> &emsp; <a href="3Write_Listboard.jsp">고객센터</a>
                        <%
                        }
                        %>
                    </td>
                </tr>

                <tr height="40">
                    <th width="20%" bgcolor="#FFBDA3">
                        <h1 style="font-size: 35px;">
                            <a href="#" onclick="changePage('Product_Home.jsp')">Good Choice</a>
                        </h1>
                    </th>

                    <th width="50%" style="background-color: #FDF5E6;">
                        <SELECT name="scategory">
                            <option value="0">전체</option>
                            <option value="1">쌀·잡곡</option>
                            <option value="2">채소</option>
                            <option value="3">과일</option>
                            <option value="4">견과</option>
                            <option value="5">수산·건어물</option>
                            <option value="6">정육</option>
                            <option value="7">계란류·유제품</option>
                            <option value="8">차·음료·생수</option>
                            <option value="9">과자·간식·빵·빙과</option>
                            <option value="10">건강식품</option>
                        </SELECT>
                        <input type="text" name="sname" size="60%" placeholder="제품검색">
                        <input type="submit" value="검색" size="10%">
                    </th>
                    <th width="10%" style="text-align: right; background-color: #FDF5E6;">
                        <img src="img/product.jpg" width="35" height="25"> <a href="0SellerProduct_List.jsp">상품목록</a>
                    </th>
                    <th width="10%" style="text-align: right; background-color: #FDF5E6;">
                        <img src="img/singpage.jpg" width="35" height="25"> <a href="2Member_List.jsp">회원 정보</a>
                    </th>
                </tr>

                <tr>
                    <td height="50" colspan="4" style="text-align: center; background-color: #FDF5E6;">
                        <input type="button" value="쌀·잡곡" class="text-button" onclick="category(1)">
                        &emsp;&emsp;&emsp;
                        <input type="button" value="채소" class="text-button" onclick="category(2)">
                        &emsp;&emsp;&emsp;
                        <input type="button" value="과일" class="text-button" onclick="category(3)">
                        &emsp;&emsp;&emsp;
                        <input type="button" value="견과" class=" text-button" onclick="category(4)">
                        &emsp;&emsp;&emsp;
                        <input type="button" value="수산·건어물" class="text-button" onclick="category(5)">
                        &emsp;&emsp;&emsp;
                        <input type="button" value="정육" class="text-button" onclick="category(6)">
                        &emsp;&emsp;&emsp;
                        <input type="button" value="계란류·유제품" class="text-button" onclick="category(7)">
                        &emsp;&emsp;&emsp;
                        <input type="button" value="차·음료·생수" class="text-button" onclick="category(8)">
                        &emsp;&emsp;&emsp;
                        <input type="button" value="과자·간식·빵·빙과" class=" text-button" onclick="category(9)">
                        &emsp;&emsp;&emsp;
                        <input type="button" value="건강식품" class="text-button" onclick="category(10)">
                    </td>
                </tr>
            </table>
        </form>
    </div>
</body>

<script type="text/javascript">
    function category(category) {
        location.href = '?pageChange=Option_Home.jsp?category=' + category;
    }

    function changePage(page) {
        window.location.href = '1Main_Form.jsp?pageChange=' + page;
    }
</script>
</html>