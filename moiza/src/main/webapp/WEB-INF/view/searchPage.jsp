<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="security"
   uri="http://www.springframework.org/security/tags"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Bootstrap Example</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet"
   href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script
   src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
<script
   src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<style>
.active {
   left: 730px;
   color: aqua;
}
/* Remove the navbar's default rounded borders and increase the bottom margin */
.navbar {
   margin-bottom: 50px;
   border-radius: 0;
   background-color: #ecf19e;
   border-color: #ecf19e;
}

/* Remove the jumbotron's default bottom margin */
.jumbotron {
   margin-bottom: 0;
   background-color: #ecf19e;
}

/* Add a gray background color and some padding to the footer */
footer {
   background-color: #ecf19e;
   padding: 25px;
}

body {
   background-color: #ecf19e;
}

#loginSuccess {
   border: 2px solid #772181;
   border-radius: 15px;
}

#myGroup {
   display: flex;
}

#myGroupChild {
   border: 2px solid #123a2a;
   border-radius: 15px;
   flex: 0 0 200px;
}
</style>
</head>
<body>

   <div class="jumbotron">
      <div class="container text-center">
         <img src="${pageContext.request.contextPath}/img/moiza_logo.jpg" />
            
         <h1>Moiza</h1>
         <p>Mission, Vission & Values</p>
      </div>
   </div>

 <c:if test="${empty searchGroups}">
   <c:out value ="검색결과가 없습니다요"/><br/>
    <a href="${pageContext.request.contextPath}/"><span
                        class="glyphicon glyphicon-user"></span>홈으로~</a>
 </c:if>
 
   <div class="container">
   <div class="row">
<c:forEach var ="searchedGroup" items = "${searchGroups}">
         <div class="col-sm-4">
            <div class="panel panel-primary">
               <div class="panel-heading">${searchedGroup.mgroup_title}</div>
               <div class="panel-body">
                  <img src="${searchedGroup.mgroup_img_url}"
                     class="img-responsive" style="width: 100%" alt="Image">
               </div>
               <div class="panel-footer">${searchedGroup.mgroup_maincategory} / ${searchedGroup.mgroup_middlecategory}</div>
             <security:authorize access="isAuthenticated()">     
               <div class="panel-footer">
               <c:url
                     value="/group_main_post?mgroupIndex=${searchedGroup.mgroup_index}"
                     var="enterGroup" />
               <a href = "${enterGroup}" style="text-decoration-line: none">구경하기~</a>
               </div>
               </security:authorize>
                <security:authorize access="isAnonymous()"> 
                    <div class="panel-footer">
             
             <a href="${pageContext.request.contextPath}/showMyLoginPage"><span
                        class="glyphicon glyphicon-user"></span>로그인 후 구경 할 수 있어요</a>
               </div>
                </security:authorize>
            </div>
         </div>

</c:forEach>
</div>  
</div>
   <br>

   

</body>
</html>