<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<div id="header">
        <div class="logo">
          <a href="./">DHB.GG</a>
        </div>  
        <nav>
          
          <ul>
            <li>
              <a href="./">홈</a>
            </li>
            <li>
              <a href="aram">칼바람분석</a>

            </li>
            <li class="dropdown">
              <a href="loginboardhome">박제 게시판</a>
            </li>
            <li>
              <a href="test2">나는 사람인가?</a>
            </li>
            
           <c:set var = "m_id" value = "${m_id}"/>
            <c:if test="${!empty m_id}">
	              <li onclick="kakaoLogout();">
				      <a href="javascript:void(0)">
				          <span>Logout</span>
				      </a>
				 </li>
			</c:if>
			
			<c:if test="${empty m_id}">
	            <li>
	            	<a href="login">LOGIN</a>
	            </li>
            </c:if>
          </ul>
          
        </nav>
       
      </div>

<script src="https://developers.kakao.com/sdk/js/kakao.js"></script>
      <script src="./js/header.js">
      </script>