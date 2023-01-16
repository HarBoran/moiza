<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
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
	<jsp:useBean id="now" class="java.util.Date" />
	<script>
       $(document).ready(function(){   
      
          if($("#pwd").val() != $("#pwd_check").val()){
             alert("비밀번호가 맞지 않습니다.")
             return false;
             }
          });             
       });
    
    </script>
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
				<h1>
					<b>Sign up</b>
				</h1>
				<br>
				<div class="form-container">

					<form:form action="saveUser" method="GET">

						<input type="text" name="username" placeholder="userID">
						<input type="password" id="pwd" name="password"
							placeholder="Password">

						<!--  <input type="password"id = "pwd_check" name="user_password" placeholder="Password Check"> -->

						<input type="text" name="user_name" placeholder="Name">
						<input type="text" name="user_phone"
							placeholder="Phone number (exception - ,only number)">
						<input type="text" name="user_birth"
							placeholder="Birth (input six numbers)">
						<input type="text" name="user_gender" placeholder="Gender">
						<fmt:formatDate value="${now}" pattern="yyyyMMdd" var="now" />
						<input type="hidden" name="user_joinday" value="${now}">
						<input type="hidden" name="user_out" value="0">
						<input type="hidden" name="enabled" value="1">
						<input type="hidden" name="authority" value="ROLE_EMPLOYEE">

						<button type="submit" value="Save" class="btn-login">가입하기</button>
					</form:form>
				</div>
			</div>
		</div>
	</main>

</body>
</html>