<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.util.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>메인화면 하단</title>

<style type='text/css'>
.center {
	text-align: center;
	margin: 0 auto;
}

.tablemb {
	width: 1200px;
	border: none; /* 1px solid black; */
	border-collapse: collapse;
	padding: 0;
	border-spacing: 0;
	margin-left: auto;
	margin-right: auto;
}

.tablemb td {
	padding: 0;
	border: 1px solid black; /* 1px solid black; */
	text-align: center;
	vertical-align: middle;
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
		<table class="tablemb">
			<tr>
				<td>
					<h4>
						모든 상품들의 유통기한을 확인하고 구매할 수 있는 쇼핑몰입니다.
						<br>
						"판매자는" 상품을 등록할 때에 반드시 유통기한을 입력해야 하며
						<br>
						"소비자는" 모든 상품의 유통기한을 확인하고 구매할 수 있습니다.
					</h4>
				</td>
			</tr>
		</table>
	</div>
</body>
</html>