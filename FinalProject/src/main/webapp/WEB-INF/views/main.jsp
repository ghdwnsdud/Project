<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>

<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

<style>
@import url("./css/main.css");
</style>

<body>

	<main>

		<%@include file="./includes/header.jsp"%>


		<video id="video" preload="auto" autoplay="true" loop="loop"
			muted="muted" volume="0">
			<source src="./videos/animated-kayle-morgana-login.mp4">

		</video>

		<div class="a">
			<div class="area">DHB.GG</div>
			</div>

			<div class="wrap">
				<div class="rap2">
					<input id='search_area' type="text" class="searchTerm"
						placeholder="챔피언 이름을 검색하세요" autocomplete='on'>
					<button id="search_champ" type="submit" class="searchButton">Search</button>
					<div class="searchTerm" id='autoMaker'></div>
				</div>
			</div>

	</main>

</body>

<script type="text/javascript">
	$("span").hover(function() {
		$((this)).css("background-color", "black")
	},

	function() {
		$((this)).css("background-color", "transparent");
	})

	var ref = ${champ};

	let championname = []
	for ( let i in ref) {
		championname.push(ref[i].champname)
	}

	var isComplete = false; //autoMaker 자식이 선택 되었는지 여부
	$('#search_area').keyup(
			function() {
				var txt = $(this).val();
				if (txt != '') { //빈줄이 들어오면
					$('#autoMaker').children().remove();

					ref.forEach(function(arg) {
						if (arg.champname.indexOf(txt) > -1) {
							$('#autoMaker').append(
									$('<div>').text(arg.champname).attr({
										'key' : arg.key
									}));
						}
					});
					$('#autoMaker').children().each(function() {
						$(this).click(function() {
							$('#search_area').val($(this).text());
							$('#autoMaker').children().remove();
							$("#search_area").focus();
							isComplete = true;
						});
					});
				} else {
					$('#autoMaker').children().remove();
				}
			});
	$('#search_area').keydown(function(event) {
		if (isComplete) { //autoMaker 자식이 선택 되었으면 초기화
			$('#insert_target').val('')
		}
	})

	
	$("#search_champ").click(function() {
		let champname = $("#search_area").val()

		if (champname == "" || championname.indexOf(champname) == -1) {
			alert("챔피언 이름을 한글로 알맞게 적어주세요.")
			$("#search_area").focus();
		} else {
			location.href = "./champinfo?champname=" + champname;
		}
	})
	$("input[type=text]").on('keyup', function(e)
		{ if(e.key==='Enter'||e.keyCode===13){
			$("#search_champ").trigger('click'); } })
	
	
</script>

</html>