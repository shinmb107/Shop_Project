<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*,java.util.*"%>
<%
request.setCharacterEncoding("utf-8");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>카테고리 메인</title>

<style type='text/css'>
.tableoh {
	width: 100%;
	height: 520px;
	border: 1px solid black; /* 1px solid black; */
	border-collapse: collapse;
	padding: 0;
	border-spacing: 0;
	background-color: #F0FFF0;
}

.tableoh td {
	padding: 0;
	border: 0; /* 1px solid black; */
	text-align: left;
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
</style>

</head>
<body>
	<%
	String option = request.getParameter("optionChange");
	String optionChange;
	if (option == null) {
		option = "Option_Category.jsp";
	}

	String category = request.getParameter("category");
	%>
	<table class="tableoh">
		<tr>
			<td rowspan="2" width="15%" style="padding-left: 20px; border-right: 1px solid black;">
				<br>
				<font size='3'><b> 가격 </b></font>
				<br>
				<input type="checkbox" name="pay" onclick="PayOption('1')" value="1">
				1만원 이하
				<br>
				<input type="checkbox" name="pay" onclick="PayOption('2')" value="2">
				1만원 ~ 3만원
				<br>
				<input type="checkbox" name="pay" onclick="PayOption('3')" value="3">
				3만원 ~ 5만원
				<br>
				<input type="checkbox" name="pay" onclick="PayOption('4')" value="4">
				5만원 이상
				<br>
				<br>
				<br>
				<font size='3'><b> 보관 방식 </b></font>
				<br>
				<input type="checkbox" name="keep" onclick="KeepOption('1')" value="1">
				냉장보관
				<br>
				<input type="checkbox" name="keep" onclick="KeepOption('2')" value="2">
				냉동보관
				<br>
				<input type="checkbox" name="keep" onclick="KeepOption('3')" value="3">
				실온보관
				<br>
				<br>
				<br>
				<font size='3'><b> 구성 방식 </b></font>
				<br>
				<input type="checkbox" name="set" onclick="SetOption('1')" value="1">
				단품 구성
				<br>
				<input type="checkbox" name="set" onclick="SetOption('2')" value="2">
				단품 세트
				<br>
				<input type="checkbox" name="set" onclick="SetOption('3')" value="3">
				혼합 세트
				<br>
				<br>
				<br>
				<font size='3'><b> 유기농/친환경 </b></font>
				<br>
				<input type="checkbox" name="organic" onclick="OrganicOption('1')" value="1">
				유기농/친환경
				<br>
				<input type="checkbox" name="organic" onclick="OrganicOption('2')" value="2">
				해당없음
				<br>
				<br>
			</td>

			<td height="50px">
				&emsp;&emsp;&emsp; | &emsp;
				<input type="button" value="인기순" class="text-button" onclick="ArrayOption(1)">
				&emsp; | &emsp;
				<input type="button" value="최신순" class="text-button" onclick="ArrayOption(2)">
				&emsp; | &emsp;
				<input type="button" value="유통기한 많은순" class="text-button" onclick="ArrayOption(3)">
				&emsp; | &emsp;
				<input type="button" value="낮은가격순" class="text-button" onclick="ArrayOption(4)">
				&emsp; | &emsp;
				<input type="button" value="높은가격순" class="text-button" onclick="ArrayOption(5)">
				&emsp; | &emsp;
			</td>
		</tr>

		<tr>
			<td width="85%" style="vertical-align: top;">
				<jsp:include page="<%=option%>" flush="false">
					<jsp:param name="category" value="<%=category%>" />
				</jsp:include>
			</td>
		</tr>
	</table>
</body>

<script>
    function PayOption(pay) {
        const category = encodeURIComponent('<%=category%>');
        location.href = '1Main_Form.jsp?pageChange=Option_Home.jsp&optionChange=Option_Pay.jsp&category=' + category + '&pay=' + pay;
    }

    function KeepOption(keep) {
        const category = encodeURIComponent('<%=category%>');
        location.href = '1Main_Form.jsp?pageChange=Option_Home.jsp&optionChange=Option_Keep.jsp&category=' + category + '&keep=' + keep;
    }

    function SetOption(set) {
        const category = encodeURIComponent('<%=category%>');
        location.href = '1Main_Form.jsp?pageChange=Option_Home.jsp&optionChange=Option_Set.jsp&category=' + category + '&set=' + set;
    }
    
    function OrganicOption(organic) {
        const category = encodeURIComponent('<%=category%>');
		location.href = '1Main_Form.jsp?pageChange=Option_Home.jsp&optionChange=Option_Organic.jsp&category=' + category + '&organic=' + organic;
	}

	function ArrayOption(array) {
		const category = encodeURIComponent('<%=category%>');
		location.href = '1Main_Form.jsp?pageChange=Option_Home.jsp&optionChange=Option_Array.jsp&category=' + category + '&array=' + array;
	}
</script>
</html>