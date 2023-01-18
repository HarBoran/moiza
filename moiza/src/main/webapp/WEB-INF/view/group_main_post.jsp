<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<!-- 부트스트랩 -->
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>

<title>Group_main</title>
<style type="text/css">
header {
	border: 2px solid #772181;
	border-radius: 15px;
}

#container {
	display: flex;
	flex-flow: row nowrap;
	justify-content: center;
	align-items: stretch;
	grid-template-columns: 20% 50% 30%;
	grid-template-rows: 200px 50px;
}

aside {
	flex-basis: 200px;
	text-align: center;
}

#mgroupMainImg {
	width: 200px;
	height: 200px;
	opacity: 0.9;
}

section {
	border: 2px solid #73AD21;
	border-radius: 25px;
	word-wrap: break-word;
	flex-basis: 100px;
	flex-grow: 1;
}

bside {
	flex-basis: 200px;
}
</style>

</head>
<body>
	<div class="container">
		<header>
			Header
			<p>
				User:<security:authentication property="principal.username" />
				<br>
				Role(s):<security:authentication property="principal.authorities" />
			</p>			
			<a href="${pageContext.request.contextPath}/leaders" style = "text-decoration: none;">Leadership Meeting</a>(Only for Managers)<br>
			<input type = "button" value = "Leadership Meeting" class ="add-button" 
	         onclick="window.location.href='leaders'; return false;"/>   

			<a href="${pageContext.request.contextPath}/">Back to Home Page</a>

		</header>
	</div>


	<div class="container">
		<div id="container">

			<aside>
				<div><img id="mgroupMainImg"
					src="{mgroup[0].mgroup_img_url}"/> </div>
			 	<h2>${mgroup[0].mgroup_title}</h2>
				<h4>${mgroup[0].mgroup_introduce}</h4>
				<h5>테마 : ${mgroup[0].mgroup_maincategory}</h5>
				<h5>테마 : ${mgroup[0].mgroup_middlecategory}</h5>
				<h5>지역 : ${mgroup[0].mgroup_local_name}</h5>
				<h5>인원수 : /${mgroup[0].mgroup_limit}</h5>
				<c:url value = "/joingroup?mgroupIndex=${mgroup[0].mgroup_index}" var ="joingroup"/>
                  <a href = "${joingroup}" style = "text-decoration-line: none"><b>가입하기</b></a>

			</aside>


			<section>
			
				<c:forEach var="tempPost" items="${post}">
				<p>
					<div>작성자 : ${tempPost.post_usergroup_index} </div>
					<div>${tempPost.post_date} ${tempPost.post_time}</div>
					<div> &#x1F496; ${tempPost.post_like} &#x1f60d; ${tempPost.post_view}</div>
					<p>${tempPost.post_maintext}</p>
				</p>	
				</c:forEach>
			</section>


			<bside>
				<p>안녕하세요. <security:authentication property="principal.username"/>님. 반갑습니다.</p>
				<ul>
					<li>로그아웃</li>
					<li>마이페이지</li>
					<li>모임관리하기</li>
					<li><c:url value = "/writing_post?mgroupIndex=${mgroup[0].mgroup_index}" var ="writingPost"/>
						<a href = "${writingPost}" style = "text-decoration-line: none"> 글쓰기</a></li>
				</ul>
			</bside>
		</div>
	</div>
</body>
</html>