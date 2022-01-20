<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>


<style>
@import url("./css/boardList.css");
</style>

</head>
<body>
	<%@include file="./includes/header.jsp"%>

	<article>

		<div class="grid">
			<div>
				<table class="grid-1" align="right">
					<tr>
						<th id="no-border">${m_id}</th>

						<th>
							<!-- 글쓰기 --> <c:set var="m_id" value="${m_id}" /> <%-- 로그인이 돼있다면 --%>
							<c:if test="${!empty m_id}">
								<form action='writefrm'>
									<button id="writeBtn">
										<img class="writeimg" src="./image/write.png">
									</button>
								</form>
							</c:if> <%-- 로그인이 안돼있다면 --%> <c:if test="${empty m_id}">
									<button id="writeBtn" onclick="writealert()">
										<img class="writeimg" src="./image/write.png">
									</button>
							</c:if>

						</th>

					</tr>
				</table>
			</div>
			<div class="grid-2">
				<table border="1" summary="게시판 top3" class="tbl_type">
					<caption>게시판 리스트</caption>
					<colgroup>
						<col width="80">
						<col>
						<col width="115">
						<col width="85">
						<col width="60">
						<col width="60">
					</colgroup>
					<thead>
						<tr>
							<th id="top3-title" scope="col" colspan="6" align="center">추천
								Top3</th>
						</tr>
					</thead>
					<thead>
						<tr>
							<th scope="col">&nbsp;</th>
							<th scope="col">제목</th>
							<th scope="col">글쓴이</th>
							<th scope="col">날짜</th>
							<th scope="col">조회수</th>
							<th scope="col">추천수</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="board" items="${top3List}">
							<tr>

								<td class="num"><div id="hot">HOT</div></td>
								<td class="title"><a
									href="contents?b_num=${board.b_num}&b_id=${board.b_id}">
										${board.b_title}</a></td>
								<td align="center">${board.b_id}</td>
								<td align="center" class="date">${board.b_date}</td>
								<td align="center" class="hit">${board.b_views}</td>
								<td align="center">${board.b_thumbs}</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>

			<div class="grid-3">
				<table border="1" summary="게시판 전체 리스트 최신순" class="tbl_type">
					<caption>게시판 리스트</caption>
					<colgroup>
						<col width="80">
						<col>
						<col width="115">
						<col width="85">
						<col width="60">
						<col width="60">
					</colgroup>
					<thead>
						<tr>
							<th id="total-title" scope="col" colspan="6" align="center">박제
								게시판</th>
						</tr>
					</thead>
					<thead>
						<tr>

							<th scope="col">No</th>
							<th scope="col">제목</th>
							<th scope="col">글쓴이</th>
							<th scope="col">날짜</th>
							<th scope="col">조회수</th>
							<th scope="col">추천수</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="board" items="${bList}">
							<tr height="20">
								<td class="num">${board.b_num}</td>
								<td class="title"><a
									href="contents?b_num=${board.b_num}&b_id=${board.b_id}">
										${board.b_title}</a></td>
								<td align="center">${board.b_id}</td>
								<td class="date">${board.b_date}</td>
								<td class="hit">${board.b_views}</td>
								<td align="center">${board.b_thumbs}</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>

			<!-- 페이징 -->
			<div class="grid-4" align="center">${pageBtn}</div>

		</div>
	</article>
	<%@include file="./includes/footer.jsp" %>	
	
	<script type="text/javascript">
		function writealert() {
			alert("로그인 후 이용해주세요");
			return;
		}
	</script>

</body>
</html>