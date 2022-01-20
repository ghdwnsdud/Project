<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script> 
<head>
<meta charset="UTF-8">
<title>Insert title here</title>	
</head>
<style> 
@import url("./css/test2.css");
</style>

<body>

<%@include file="./includes/header.jsp" %>	

        <video id="video" preload="auto" autoplay="true" loop="loop" muted="muted" volume="0">
      <source src="./videos/animated-mount-targon.mp4">

</video>

<div id='grid'>
<form  method="GET" target="param">
<div class="tbtb">
<div class="nn" style="display:flex;">
	<div class="vv">
	
	<span>1.자신팀의 총 킬:</span>
	</div>
	<input type="text" id="1" name="myteam_Kills" required>
	
</div>

<div class="nn" style="display:flex;">
	<div class="vv">
	<span class='textw'>2.자신팀의 총 데스:</span>
	</div>
	<input type="text" id="2" name="myteam_Deaths" required>
</div>
<div class="nn" style="display:flex;">
	<div class="vv">
	<span class='textw'>3.자신팀의 총 어시스트:</span>
	</div>
	<input type="text" id="3" name="myteam_Assists" required>
</div>
<div class="nn" style="display:flex;">
	<div class="vv">
	<span class='textw'>4.자신팀의 총 골드:</span>
	</div>
	<input type="text" id="4" name="myteam_Golds" required>
</div>
<div class="nn" style="display:flex;">
	<div class="vv">
	<span class='textw'>5.상대팀의 총 킬:</span>
	</div>
	<input type="text" id="5" name="vsteam_Kills" required>
</div>
<div class="nn" style="display:flex;">
	<div class="vv">
	<span class='textw'>6.상대팀의 총 데스:</span>
	</div>
	<input type="text" id="6" name="vsteam_Deaths" required>
</div>
<div class="nn" style="display:flex;">
	<div class="vv">
	<span class='textw'>7.상대팀의 총 어시스트:</span>
	</div>
	<input type="text" id="7" name="vsteam_Assists" required>
</div>
<div class="nn" style="display:flex;">
	<div class="vv">
	<span class='textw'>8.상대팀의 총 골드:</span>
	</div>
	<input type="text" id="8" name="vsteam_Golds" required>
</div>
<div class="nn" style="display:flex;">
	<div class="vv">
	<span class='textw'>9.자신의 골드:</span>
	</div>
	<input type="text" id="9" name="my_golds" required>
</div>
<div class="login-box">
			 <span></span>
            <span></span>
            <span></span>
            <span></span>
	<input id="submit2"type='button' value="알아보기" id='btn' onclick="ml()">
</div>
</div>

</form>
<div class="mg1">

<img id='iimg' src="./image/help.png" width="600px"></img>
</div>

 <div class="hhh">
 <h2>▶당신은 과연 사람일까요?</h2>
<div class="tess">
<div class="test1">
	
</div>
</div>
</div>

</div>




<%@include file="./includes/footer.jsp" %>	


<script>
function ml(){
	let input = $('input');
	let keyvalue = {}
	for (let i=0; i<input.length-1 ; i++){
		var key = input[i].name
		var value = input[i].value
		if(value == ""){
			alert(input[i].id + "번칸을 입력해 주세요.");
			$("#"+input[i].id).focus();
			break;
		}
		keyvalue[key] = value;			
	}
	$.ajax({
		type:'get',
		url:'http://127.0.0.1:5000/tospring',
		data:keyvalue,
		success:function(result){
			$(".test1").html(result);
		},
		error: function(err){
			console.log(err);
		}
	})
	
}
$('div').children("input[type=text]").on('keyup', function(e)
		{ if(e.key==='Enter'||e.keyCode===13){
			$("#submit2").trigger('click'); } })
	
    
</script>



</body>
</html>