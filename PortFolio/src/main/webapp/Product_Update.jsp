<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.util.*"%>
<%
request.setCharacterEncoding("utf-8");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품수정</title>

<style type='text/css'>
.center {
	text-align: center;
	margin: 0 auto;
}

.tablepu {
	width: 900px;
	border: none; /* 1px solid black; */
	border-collapse: collapse;
	padding: 0;
	border-spacing: 0;
	margin-left: auto;
	margin-right: auto;
}

.tablepu td {
	padding: 0;
	border: 0; /* 1px solid black; */
	text-align: center;
	vertical-align: middle;
}

.tablepu1 {
	width: 900px;
	border: 1px solid black; /* 1px solid black; */
	border-collapse: collapse;
	padding: 5px;
	border-spacing: 0;
	margin-left: auto;
	margin-right: auto;
	background-color: #FFEAD0;
}

.tablepu1 td {
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

<script>
	function Check() {
		if (Product.p_name.value.length < 1) {
			alert("상품 이름을 입력해주세요.")
			Product.p_name.focus();
			return false;
		}
		if (Product.p_file.value.length < 1) {
			alert("상품 사진을 업로드해주세요.")
			return false;
		}
		if (Product.p_pay.value.length < 1) {
			alert("상품 가격을 입력해주세요.")
			Product.p_pay.focus();
			return false;
		}
		if (Product.p_count.value.length < 1) {
            alert("등록개수를 입력해주세요.")
            Product.p_count.focus();
            return false;
        }
		if (Product.p_day.value.length < 1) {
			alert("유통기한을 입력해주세요.")
			Product.p_day.focus();
			return false;
		}
		var checkbox_keep = document.getElementsByName('p_keep');
		var isChecked_keep = false;
		for (var i = 0; i < checkbox_keep.length; i++) {
			if (checkbox_keep[i].checked) {
				isChecked_keep = true;
				break;
			}
		}
		if (!isChecked_keep) {
			alert("보관 방식을 선택해주세요.");
			return false;
		}
		var checkbox_set = document.getElementsByName('p_set');
		var isChecked_set = false;
		for (var i = 0; i < checkbox_set.length; i++) {
			if (checkbox_set[i].checked) {
				isChecked_set = true;
				break;
			}
		}
		if (!isChecked_set) {
			alert("구성 방식을 선택해주세요.");
			return false;
		}
		var checkbox_organic = document.getElementsByName('p_organic');
		var isChecked_organic = false;
		for (var i = 0; i < checkbox_organic.length; i++) {
			if (checkbox_organic[i].checked) {
				isChecked_organic = true;
				break;
			}
		}
		if (!isChecked_organic) {
			alert("유기농/친환경을 선택해주세요.");
			return false;
		}
		var category = Product.p_category.value.trim();
		if (category === "전체 카테고리") {
			alert("카테고리를 선택해주세요.");
			return false;
		}
	}

	function previewImage() {
		var file = document.querySelector('input[type=file]').files[0];
		var reader = new FileReader();
		reader.onloadend = function() {
			var img = document.getElementById('imagePreview');
			img.src = reader.result;
		}
		if (file) {
			reader.readAsDataURL(file);
		} else {
			var img = document.getElementById('imagePreview');
			img.src = "";
		}
	}
</script>
</head>

<body>
	<%
	String p_num = request.getParameter("p_num");

	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;

	String keepValue = "";
	String setValue = "";
	String organicValue = "";

	try {
		Class.forName("com.mysql.jdbc.Driver");
		String url = "jdbc:mysql://localhost:3306/product";
		conn = DriverManager.getConnection(url, "product", "product");

		String strSQL = "SELECT*FROM product WHERE p_num=?";
		pstmt = conn.prepareStatement(strSQL);
		pstmt.setInt(1, Integer.parseInt(p_num));

		rs = pstmt.executeQuery();

		if (rs.next()) {
			String p_img = rs.getString("p_img");
			String p_name = rs.getString("p_name");
			String p_pay = rs.getString("p_pay");
			String p_count = rs.getString("p_count");
			String p_category = rs.getString("p_category");
			keepValue = rs.getString("p_keep");
			setValue = rs.getString("p_set");
			organicValue = rs.getString("p_organic");
			String p_explan = rs.getString("p_explan");
			java.sql.Date p_day = rs.getDate("p_day");
			java.util.Date utilDate = new java.util.Date(p_day.getTime());
			java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyy-MM-dd");
			
	%>
	<%!
    String isChecked(String value, String target) {
        return value != null && value.contains(target) ? "checked" : "";
    }
%>
		<table class="tablepu">
			<tr>
				<td><jsp:include page="0Main_AC.jsp" flush="false" /></td>
			</tr>
		</table>

		<table class="tablepu1">
			<tr height="50">
				<td>
					<h1 style="font-size: 20px;">상품수정</h1>
				</td>
			</tr>
		</table>

		<form Name='Product' method="post" action="ImageUpdateServlet?p_num=<%=p_num%>" enctype="multipart/form-data" OnSubmit='return Check()'>
			<input type="hidden" name="m_num" value="<%=p_num%>">
			<table class="tablepu1">
				<tr height="50">
					<td width="20%" style="border-right: none;">상품이름*</td>
					<td width="50%" style="text-align: left; border-left: none;">
						<input type="text" name="p_name" size="45%" value="<%=p_name%>">
					</td>
					<td width="30%" style="text-align: center;">
						<input type="file" name="p_file" onchange="previewImage()" />
					</td>
				</tr>

				<tr height="50">
					<td width="20%" style="border-right: none;">상품가격*</td>
					<td width="50%" style="text-align: left; border-left: none;">
						<input type="text" name="p_pay" placeholder="숫자만 입력 ( ,  . 등 기호 생략 )" size="40%" value="<%=p_pay%>">
						원
					</td>
					<td width="30%" rowspan="7" style="text-align: center;">
						<img id="imagePreview" alt="Image Preview" style="width: 250px; height: 250px;">
					</td>
				</tr>

				<tr height="50">
					<td width="20%" style="border-right: none;">등록개수*</td>
					<td width="50%" style="text-align: left; border-left: none;">
						<input type="text" name="p_count" placeholder="숫자만 입력 ( ,  . 등 기호 생략 )" size="40%" value="<%=p_count%>">
						개
					</td>
				</tr>

				<tr height="50">
					<td width="20%" style="border-right: none;">유통기한*</td>
					<td width="50%" style="text-align: left; border-left: none;">
						<input type="date" name="p_day" placeholder="유통기한을 입력하세요" style="width: 200px;">
					</td>
				</tr>

				<tr height="50">
					<td width="20%" style="border-right: none;">카테고리*</td>
					<td width="50%" style="text-align: left; border-left: none;">
						<SELECT name="p_category" style="width: 200px;">
							<option value=" 전체 카테고리">카테고리 선택</option>
							<option value="쌀·잡곡">쌀·잡곡</option>
							<option value="채소">채소</option>
							<option value="과일">과일</option>
							<option value="견과">견과</option>
							<option value="수산·건어물">수산·건어물</option>
							<option value="정육">정육</option>
							<option value="계란류·유제품">계란류·유제품</option>
							<option value="차·음료·생수">차·음료·생수</option>
							<option value="과자·간식·빵·빙과">과자·간식·빵·빙과</option>
							<option value="건강식품">건강식품</option>
						</SELECT>
					</td>
				</tr>

				<tr height="50">
					<td width="20%" style="border-right: none;">보관방식*</td>
					<td width="50%" style="text-align: left; border-left: none;">
						<input type="checkbox" name="p_keep" value="냉장보관" <%=isChecked(keepValue, "냉장보관")%>>
						냉장보관 &nbsp;&nbsp;
						<input type="checkbox" name="p_keep" value="냉동보관" <%=isChecked(keepValue, "냉동보관")%>>
						냉동보관 &nbsp;&nbsp;
						<input type="checkbox" name="p_keep" value="실온보관" <%=isChecked(keepValue, "실온보관")%>>
						실온보관 &nbsp;&nbsp;
					</td>
				</tr>

				<tr height="50">
					<td width="20%" style="border-right: none;">구성방식*</td>
					<td width="50%" style="text-align: left; border-left: none;">
						<input type="checkbox" name="p_set" value="단품구성" <%=isChecked(setValue, "단품구성")%>>
						단품구성 &nbsp;&nbsp;
						<input type="checkbox" name="p_set" value="단품세트" <%=isChecked(setValue, "단품세트")%>>
						단품세트 &nbsp;&nbsp;
						<input type="checkbox" name="p_set" value="혼합세트" <%=isChecked(setValue, "혼합세트")%>>
						혼합세트 &nbsp;&nbsp;
				</tr>

				<tr height="50">
					<td width="20%" style="border-right: none;">유기농/친환경*</td>
					<td width="50%" style="text-align: left; border-left: none;">
						<input type="checkbox" name="p_organic" value="해당없음" <%=isChecked(organicValue, "해당없음")%>>
						해당없음 &emsp;
						<input type="checkbox" name="p_organic" value="유기농/친환경" <%=isChecked(organicValue, "유기농/친환경")%>>
						유기농/친환경
					</td>
				</tr>

				<tr height="20" style="background-color: #FFFFFF;">
					<td colspan="3"></td>
				</tr>

				<tr height="50">
					<td colspan="4">상품설명</td>
				</tr>

				<tr>
					<td colspan="4">
						<textarea name="p_explan" cols="120" rows="10" placeholder="내용을 입력하세요"><%=p_explan%></textarea>
				</tr>

				<tr height="30">
					<td colspan="3">
						<input type="button" onclick="history.back()" value="취소하기">
						&emsp;
						<input type="reset" value="기존 값">
						&emsp;
						<input type="submit" value="상품등록">
					</td>
				</tr>
			</table>
		</form>
	</div>
	<%
	}
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