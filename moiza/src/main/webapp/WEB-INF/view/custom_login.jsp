<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Login or Sign up</title>
<link rel="stylesheet" href="css/style.css">
</head>

<body>
	<main>
		<div class="row">
			<div class="colm-logo">

				<div class="jumbotron">
					<div class="container text-center">
						<a href="${pageContext.request.contextPath}/"><h1>Moiza</h1></a>
					</div>
				</div>
			</div>
			<div class="colm-form">
				<div class="form-container">
					<c:if test="${param.error==''}">
						<div style="color: red;">ID와 PASSWORD를 확인 해주세요</div>
					</c:if>
					<c:if test="${param.logout==''}">
						<div style="color: blue;">로그아웃 되었습니다 !</div>
					</c:if>
					<form:form action="authenticateTheUser" method="POST">
						<input type="text" name="username" placeholder="userID">
						<input type="password" name="password" placeholder="Password">
						<button type="submit" value="Login" class="btn-login">로그인하기</button>
						<a href="${pageContext.request.contextPath}/join">Create new
							Account</a>
					</form:form>
				</div>
			</div>
		</div>
	</main>

</body>
</html>