<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <title>Bootstrap Example</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
  <script src="https://cdn.jsdelivr.net/npm/jquery@3.6.1/dist/jquery.slim.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
</head>
<style>
    footer {
      background-color:#ecf19e;
      padding: 25px;
    }
    body{
      background-color: #ecf19e;
    }
    .jumbotron{
      background-color: #ecf19e;
    }
    #a{
       font-size :50px;
       font-family : "Arial";
    }
    #b{
       font-size :50px;
    }
    .nav-item{
       font-size :30px;
    }

</style>
<body>
   <div class="jumbotron">
      <div class="container text-center">
         <img src="${pageContext.request.contextPath}/img/moiza_logo.jpg" />

         <h1>Moiza</h1>
         <p>Mission, Vission & Values</p>
      </div>
   </div>


<div class="container">
  <h2>회원정보를 형식에 맞게 변경하여 주세요 </h2>
  <form:form action="userModification" method="GET">
    <div class="form-group">
      <label for="email">user_phone:</label>
      <input type = "text" name = "user_phone" class="form-control" id="user_phone" value="${users.get(0).user_phone}"/>
    </div>
     <div class="form-group">
      <label for="email">password:</label>
      <input type = "password" name = "password" class="form-control" id="user_phone" value="${users.get(0).password}"/>
    </div>    
     <input type = "hidden" name = "user_index" value="${users.get(0).user_index}"/>
      
 
    <button type="submit" class="btn btn-primary">Submit</button>
  </form:form>
 
     <c:url value="/withdraw" var="withdraw" >
      <c:param name ="user_index" value="${users.get(0).user_index}"/>   
     </c:url>   
      <a class="nav-link" href="${withdraw}">회원탈퇴</a>
 
  <a class="nav-link" href="${pageContext.request.contextPath}/">홈으로</a>
</div>

</body>
</html>