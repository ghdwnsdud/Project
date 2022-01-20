<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="js/jquery.serializeObject.js"></script>

<title>${board.b_title}</title>

<script type="text/javascript">
$(function() {
	let chkid = ${check_t_id};
	if (chkid == 1) { //추천한 적이 있다
		$('#thumbsdown').attr('style','display:none');
		$('#thumbsup').css('display','inline');
	}else if(chkid == 0){
		$('#thumbsdown').attr('style','display:inline');
		$('#thumbsup').css('display','none');
	}else{
		$('#thumbsdown').attr('style','display:inline');
		$('#thumbsup').css('display','none');
		
	}
	
});

	
</script>
<style type="text/css">
@import url("./css/detail.css");
</style>
</head>
<body>
	<%@include file="./includes/header.jsp"%>
	<header class="top-menu con row">
		<div id="cell-right">
			<table>
				<tr>
					<th><a href="loginboardhome"><img src="./image/list.png"></a>
					</th>
					<th>
						<!-- 글삭제 버튼 --> ${delBtn}
					</th>
				</tr>
			</table>
			<!-- 글목록 버튼  -->
		</div>
	</header>

	<section class="article-detail table-common con row">
		<table class="cell" border="1">
			<colgroup>
				<col width="100px">
			</colgroup>
			<tbody>
				<tr class="article-title">
					<th>제목</th>
					<td colspan="4">[${board.b_num}] ${board.b_title}</td>
				</tr>
				<tr class="article-info">

					<th>날짜</th>
					<td style="width: 400px;">${board.b_date}</td>
					<th>조회수</th>
					<td style="width: 100px;">${board.b_views}</td>
					<th>
						<button id="thumbsdown" onclick="addThumbs()">
							<img class="thumb-img" src="./image/thumbsdown.png">
						</button>
						<button id="thumbsup" onclick="showalert()">
							<img class="thumb-img" src="./image/thumbsup.png">
						</button>
					</th>
					<td class="showthumbs" style="width: 100px;">${board.b_thumbs}</td>

				</tr>
				<tr class="article-body">
					<td colspan="4">
						<div class="article-writer cell">
							<div class="writer-icon">
								<c:set var="files" value="${bfList}" />

								<c:if test="${empty files}">첨부된 파일이 없습니다.</c:if>
								<c:if test="${!empty files}">
									<c:forEach var="file" items="${files}">
										<img src="upload/${file.bf_sysName}" width=100%>
										<br>
									</c:forEach>
								</c:if>
							</div>
						</div> <br> <br> ${board.b_contents}
					</td>
				</tr>
			</tbody>
		</table>
	</section>

	<div class="con reply">
		<h1 class="">댓글 입력</h1>
		<section class="reply-form">
			<form id="rFrm" name="rFrm">
				<div>
					<img class="human-img" src="./image/human.png"><input
						type="text" value="${m_id}" readonly>
				</div>
				<div>
					<textarea rows="3" cols="50" name="r_contents" id="r_contents"></textarea>
					<input type="button" value="댓글전송"
						onclick="replyInsert(${board.b_num})"
						style="width: 80px; height: 40px">
				</div>
			</form>
		</section>

		<h1 class="">댓글 목록</h1>

		<table class="reply-title">
			<tr height='20' align='center'>
				<th width="238.95px">작성자</th>
				<th width="238.95px">내용</th>
				<th width="438.1px">날짜</th>
			</tr>
		</table>
		<section class="reply-list table-common">
			<table id="rTable">
				<tbody>
					<c:forEach var="reply" items="${rList}">
						<tr height="20" align="center">
							<td width='100'>${reply.r_id}</td>
							<td width='100'>${reply.r_contents}</td>
							<td width='200'>${reply.r_date}</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</section>
	</div>
<%@include file="./includes/footer.jsp" %>
</body>

<script type="text/javascript">

function replyInsert(bNum){
	if( ${check_t_id} == 2){
	      alert("로그인 후 이용해주세요");
	      return;
	}
	if($("#r_contents").val() == ""){
		alert("내용을 입력해 주세요.");
		$("#r_contents").focus();
		return;
	}
	
	//text = $("#r_contents").val()
	let obj=$("#rFrm").serializeObject(); // 폼의 모든 데이터를 js객체로 변환
	// 폼데이터 --> js객체 --> json --> 서버 --> 자바객체
	// 단, file태그로 받아오는건 변환하지 못한다.
	obj.r_bnum = bNum;
	
	let json = JSON.stringify(obj); // <--> JSON.parse(json)
	
	$.ajax({
		type:"post",
		url:"rest/replyinsert", // 'list/member/10' , 'list/board/10'
		data : json,
		//urlencoded 방식이 아닌 json형태의 데이터를 서버에 넘긴다.
		contentType:"application/json; charset=UTF-8",
		dataType:"json",
		success: function(data){
 			$("#rTable").empty();
			for (let i in data){
				str = "<tr height='20' align='center'>";
				str += "<td width='100'>"+data[i].r_id+"</td>";
				str += "<td width='100'>"+data[i].r_contents+"</td>";
				str += "<td width='200'>"+data[i].r_date+"</td></tr>";
				$("#rTable").append(str);
			}
			$('#r_contents').val("");
			$('#r_contents').focusin();

		},
		error: function(error){
			console.log(error);
		}
	});
	
};

// 회색이미지 클릭시 추천 +1

function addThumbs(){

   if( ${check_t_id} == 2){
      alert("로그인 후 이용해주세요");
      return;
   }
   
   $('#thumbsdown').attr('style','display:none');
   $('#thumbsup').css('display','inline');
      
      $.ajax({
         url: "rest/addthumbs",
            type: "post",
            data: {
                t_num: ${board.b_num},
              t_id: <%=(String)session.getAttribute("m_id")%>
            },
            
            
            success: function (count) {
                if( ${board.b_thumbs} == count){
                  return;
                
               }
               else{               
                  $(".showthumbs").html(count);
               } 
                  
            },
            error: function (err ) {
               
               console.log(err);
               
            }
      })
      
      
   };
	
function showalert(){
	alert("이미 추천한 게시글입니다.");
};

function return_img(){
	
	 if (confirm("정말 삭제하시겠습니까?")){
			document.getElementById('img-submit').submit();
		 }
};

$('#img-submit').mouseenter(function(){
	
	$('#delImg').html('<img src=\"./image/delete-open.png\">')
})
$('#img-submit').mouseleave(function(){
	
	$('#delImg').html('<img src=\"./image/delete.png\">')
})


</script>
</html>