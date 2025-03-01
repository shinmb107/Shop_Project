<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.util.*"%>
<%
request.setCharacterEncoding("utf-8");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>고객센터 작성</title>

<style type='text/css'>
.center {
	text-align: center;
	margin: 0 auto;
}

.tablewf {
	width: 45%;
	border: none; /* 1px solid black; */
	border-collapse: collapse;
	padding: 0;
	border-spacing: 0;
	margin-left: auto;
	margin-right: auto;
}

.tablewf td {
	padding: 0;
	border: 0; /* 1px solid black; */
	text-align: center;
	vertical-align: middle;
}

.tablewf1 {
	width: 45%;
	border: 1px solid black; /* 1px solid black; */
	border-collapse: collapse;
	padding: 0;
	border-spacing: 0;
	margin-left: auto;
	margin-right: auto;
	background-color: #ededed;
}

.tablewf1 td {
	padding: 0;
	border: 0; /* 1px solid black; */
	text-align: center;
	vertical-align: middle;
}

textarea {
	overflow-x: auto;
	white-space: nowrap;
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

<script>
	function Check() {
		if (Write.name.value.length < 1) {
			alert("작성자를 입력하세요.")
			Write.name.focus();
			return false;
		}
		if (Write.pass.value.length < 1) {
			alert("비밀번호를 입력하세요.")
			Write.pass.focus();
			return false;
		}
		if (Write.email.value.indexOf("@") + "" == "-1"
				|| Write.email.value.indexOf(".") + "" == "-1"
				|| Write.email.value == "") {
			alert("E-mail을 정확히 입력하세요.('@', '.' 포함)")
			Write.email.focus();
			return false;
		}
		if (Write.title.value.length < 1) {
			alert("글제목을 입력하세요.")
			Write.title.focus();
			return false;
		}
		if (Write.contents.value.length < 1) {
			alert("글내용을 입력하세요.")
			Write.contents.focus();
			return false;
		}
	}
</script>
</head>

<body>
	<div class="center">
		<table class="tablewf">
			<tr>
				<td><jsp:include page="0Main_AC.jsp" flush="false" /></td>
			</tr>
		</table>

		<table class="tablewf1">
			<tr height="50">
				<td>
					<h1 style="font-size: 20px;">고객센터 작성</h1>
				</td>
			</tr>
		</table>

		<form Name="Write" Action="3WritePro.jsp" Method="post" OnSubmit="return Check()">
			<table class="tablewf1">
				<tr>
					<td width="150">
						<font size="2"><b> 작성자 </b></font>
					</td>
					<td style="text-align: left;">
						<p>
							<input type="text" size="40" maxlength="50" name="name">
							* 필수
						</p>
					</td>
				</tr>

				<tr>
					<td>
						<font size="2"><b> 비밀번호 </b></font>
					</td>
					<td style="text-align: left;">
						<p>
							<input type="password" size="40" maxlength="50" name="pass">
							* 필수(수정/삭제시)
						</p>
					</td>
				</tr>

				<tr>
					<td>
						<font size="2"><b> E-mail </b></font>
					</td>
					<td style="text-align: left;">
						<p>
							<input type="text" size="60" maxlength="50" name="email">
						</p>
					</td>
				</tr>

				<tr>
					<td colspan="2">
						<hr size="1" noshade>
					</td>
				</tr>

				<tr>
					<td>
						<font size="2"><b> 글 제목 </b></font>
					</td>
					<td style="text-align: left;">
						<p>
							<input type="text" size="65" maxlength="50" name="title">
						</p>
					</td>
				</tr>

				<tr>
					<td>
						<font size='2'><b>글 내용</b></font>
					</td>
					<td style="text-align: left;">
						<textarea cols="65" rows="12" name="contents"></textarea>
					</td>
				</tr>

				<tr>
					<td colspan="2" style="border: none;">
						<hr size="1" noshade>
					</td>
				</tr>

				<tr height="30">
					<td colspan="2">
						<input type="button" onclick="history.back()" value="취소하기">
						&emsp;
						<input type="reset" value="초기화">
						&emsp;
						<input type="submit" value="글등록">
					</td>
				</tr>
			</table>
		</form>
	</div>
</body>
</html>