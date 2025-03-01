<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.util.*"%>
<%
request.setCharacterEncoding("utf-8");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>판매자 로그인 화면</title>

<style type='text/css'>
.center {
	text-align: center;
	margin: 0 auto;
}

.tablelf {
	width: 600px;
	border: none; /* 1px solid black; */
	border-collapse: collapse;
	padding: 0;
	border-spacing: 0;
	margin-left: auto;
	margin-right: auto;
}

.tablelf td {
	padding: 0;
	border: 0; /* 1px solid black; */
	text-align: center;
	vertical-align: middle;
}

.tablelf1 {
	width: 600px;
	border: 1px solid black; /* 1px solid black; */
	border-collapse: collapse;
	padding: 5px;
	border-spacing: 0;
	margin-left: auto;
	margin-right: auto;
	background-color: #FFEAD0;
}

.tablelf1 td {
	padding: 0;
	border: 0; /* 1px solid black; */
	text-align: center;
	vertical-align: middle;
}

.text {
	width: 90%;
	height: 25pt;
	margin-top: 20px;
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
		if (Login.id.value.length < 1) {
			alert("아이디를 입력하세요.")
			Login.id.focus();
			return false;
		}
		if (Login.pw.value.length < 1) {
			alert("비밀번호를 입력하세요.")
			Login.pw.focus();
			return false;
		}
	}
</script>
</head>

<body>
	<div class="center">
		<table class="tablelf">
			<tr>
				<td><jsp:include page="0Main_AC.jsp" flush="false" /></td>
			</tr>
		</table>

		<table class="tablelf1">
			<tr height="50">
				<td>
					<h1 style="font-size: 25px;">로그인</h1>
				</td>
			</tr>
		</table>

		<form Name='Login' method="post" action="2LoginPro.jsp" OnSubmit='return Check()'>
			<table class="tablelf1">
				<tr height="50">
					<td>
						<br>
						<input type="text" maxlength="10" name="id" placeholder="아이디 입력" class="text">
						<input type="text" maxlength="10" name="pw" placeholder="비밀번호 입력" class="text">
					</td>
				</tr>

				<tr height="70">
					<td>
						<br>
						<br>
						<input type="submit" style="background-color: #A7EEFF;" class="button" value="로그인">
						<br>
						<br>
						<hr size="1" noshade>
						<br>
						<input type="button" class="button" value="회원가입" onclick="location.href='2Member_Form.jsp'">
						<br>
						<br>
					</td>
				</tr>
			</table>

			<table class="tablelf">
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