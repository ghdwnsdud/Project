<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<style type="text/css">
@import url("./css/writeFrm.css");
</style>
</head>
<body>
	<%@include file="./includes/header.jsp"%>
	<form action="./boardwrite" id="frm" method="post"
		enctype="multipart/form-data">
		<table class="tbl_type">
			<colgroup>
				<col width="300">
				<col width="500">
			</colgroup>
			<tr>
				<td class="title">제목</td>
				<td class="box"><input type="text" id="b_title" name="b_title"
					required></td>
			</tr>
			<tr>
				<td class="title">파일첨부</td>
				<td class="box"><input type="file" name="files" id="files"
					multiple required> <!-- <input type="hidden" id="fileCheck" name="fileCheck" value="0"> -->
				</td>
			</tr>
			<tr>
				<td class="title">내용</td>
				<td class="box"><textarea rows="20" cols="60" id="b_contents"
						name="b_contents" required></textarea></td>
			</tr>
			<tr>
				<td colspan="2" align="center"><input type="submit"
					value="글작성"> <input type="reset" id="reset" value="취소">
					<input type="button" onclick="location.href='loginboardhome'"
					value="글목록"></td>
			</tr>

		</table>
	</form>

</body>


</html>








