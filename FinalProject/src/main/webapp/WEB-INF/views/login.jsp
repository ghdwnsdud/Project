<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
@import url("./css/login.css");
</style>
</head>
<body>

<%@include file="./includes/header.jsp" %>

        <video id="video" preload="auto" autoplay="true" loop="loop" muted="muted" volume="0">
      <source src="./videos/animated-zed-odyssey-intro.mp4">

</video>

    <div class="login-box">
        <h2>Login</h2>
        <form onclick="kakaoLogin();">

          <a href="javascript:void(0)">
            <span></span>
            <span></span>
            <span></span>
            <span></span>
            Kakaotalk Login
          </a>
        </form>
    </div>

<!-- 카카오 스크립트 -->
<script>
//카카오로그인

function kakaoLogin() {
    Kakao.Auth.login({
      success: function (response) {
        Kakao.API.request({
          url: '/v2/user/me',
          success: function (response) {
        	  location.href = 'easylogin?m_id='+response.id
        	  
          },
          fail: function (error) {
            console.log(error)
          },
        })
      },
      fail: function (error) {
        console.log(error)
      },
    })
  }
</script>
        
</body>

</html>