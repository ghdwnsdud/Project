<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<style>
@import url("./css/aram.css");
</style>

</head>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>	

<body>
	<%@include file="./includes/header.jsp" %>
    
<video id="video" preload="auto" autoplay="true" loop="loop" muted="muted" volume="0">
      <source src="./videos/animated-freljord.mp4">

</video>

      
<div id="main"> 
	
	
	<div id="champlst"><h1>Champion List</h1><br></div>
	
	
	<div id="champion">
		<h1>Champion Tier</h1>
		<table id="champ_table">
			<tr class="tier">
				<th class="th_champ">챔피언</th>
				<th class="th_rpt">승률</th>
				<th class="th_rpt">픽률</th>
				<th class="th_rpt">티어</th>
			</tr>
		</table>
		
		

	</div>
	</div>
	<%@include file="./includes/footer.jsp" %>
</body>
<script type="text/javascript">

let champlst = ${champlst}
let champtierlst = ${champtierlst}

for (let i in champlst){
	str = "<div class = 'champ'>"
	str += "<a href=./champinfo?champ_code="+champlst[i].champ_code+">";
	str += "<img class='champimg' alt="+champlst[i].champname+" src="+champlst[i].champ_img+"></a>";
	str += "<span>"+champlst[i].champname+"</span>";
	str += "</div>";
	$("#champlst").append(str);
}

for (let i in champtierlst){
	str = "<tr class='cl'>"
	str += "<td class='th_champ'>"
	str += "<a href=./champinfo?champ_code="+champtierlst[i].champ_code+">";
	str += "<img class='cpimg' alt="+champtierlst[i].champname+" src="+champtierlst[i].champ_img+">";
	str += "<span style='color: white;'>"+champtierlst[i].champname+"</span></td>";
	str += "<td class='th_rpt'>"+champtierlst[i].pick+"%</td>";
	str += "<td class='th_rpt'>"+champtierlst[i].win+"%</td>";
	var num = champtierlst[i].tier
	switch (num){
		case "1": 
			str += "<td class='th_rpt'><img src='./image/1.png'></td>";
			break;
		case "2":
			str += "<td class='th_rpt'><img src='./image/2.png'></td>";
			break;
		case "3": 
			str += "<td class='th_rpt'><img src='./image/3.png'></td>";
			break;
		case "4":
			str += "<td class='th_rpt'><img src='./image/4.png'></td>";
			break;
		case "5":
			str += "<td class='th_rpt'><img src='./image/5.png'></td>";
			break;
		}
	str += "</tr>";
	$("#champ_table").append(str);
}

</script>

</html>