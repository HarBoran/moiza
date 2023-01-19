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
<title>Hello Moiza~</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet"
   href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
<script
   src="https://cdn.jsdelivr.net/npm/jquery@3.6.1/dist/jquery.slim.min.js"></script>
<script
   src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
<script
   src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>

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


   <div class="container">
      <div class="jumbotron">
         <div class="container text-center">
            <img src="${pageContext.request.contextPath}/img/moiza_logo.jpg" />
            <h1>Moiza</h1>
            <p>Mission, Vission & Values</p>
         </div>
      </div>
   </div>

   <security:authorize access="isAuthenticated()">
      <div class="container">
         <div id="loginSuccess">
            <div>
               안녕하세요
               <security:authentication property="principal.username" />
            </div>
            <p>내 모임 관리하기</p>
             </div>
                 </div>
 
               </security:authorize>
   
 
   <br>
   <br>
 
 
   <div class="container">
      <nav class="navbar navbar-expand-sm bg-warning navbar-dark">
         <ul class="nav justify-content-center">
            <security:authorize access="isAnonymous()">
            
               <li class="nav-item"><a class="nav-link"
                  href="${pageContext.request.contextPath}/showMyLoginPage"> <span
                     class="glyphicon glyphicon-user"></span> login
               </a></li>
               <li class="nav-item"><a class="nav-link"
                  href="${pageContext.request.contextPath}/join"> <span
                     class="glyphicon glyphicon-user"></span> Your Account
               </a></li>
            </security:authorize>

            <security:authorize access="isAuthenticated()">
               <li class="nav-item"><a class="nav-link"
                  href="${pageContext.request.contextPath}/test"> <span
                     class="glyphicon glyphicon-user"></span> groupCreation
               </a></li>
               <li class="nav-item"><a class="nav-link"
                  href="${pageContext.request.contextPath}/Mypage"> <span
                     class="glyphicon glyphicon-user"></span> My Page
               </a></li>
               <li class="nav-item"><a class="nav-link"
                  href="${pageContext.request.contextPath}/test"> <span
                     class="glyphicon glyphicon-user"></span> groupCreation
               </a></li>
               
               <li><a class="nav-link"
                  href="${pageContext.request.contextPath}/logout"><span
                     class="glyphicon glyphicon-user"></span> Logout</a></li>
            </security:authorize>

            <li class="nav-item"><form:form action="search"
                  class="form-inline" method="GET">
                  <input type="text" class="form-control" size="35"
                     placeholder="원하시는 모임을 검색해보세요!" name="searchGroup">
                  <input type="submit" value="Search" class="btn btn-danger">
               </form:form></li>
         </ul>
      </nav>
   </div>
   
   <div class="container">
      <div class="row">
      
         <div class="col-sm-4">
         그룹장으로 있는 모임<br>
   <c:forEach var ="theleaderMgroup" items = "${theleaderMgroup}">
            <div class="panel panel-primary">
               <div class="panel-heading">${theleaderMgroup.mgroup_title}</div>
               <div class="panel-body">
                  <img src="${theleaderMgroup.mgroup_img_url}"
                     class="img-responsive" style="width: 50%" alt="Image">
               </div>
               <div class="panel-footer">${theleaderMgroup.mgroup_maincategory}/${theleaderMgroup.mgroup_middlecategory}</div>
             <security:authorize access="isAuthenticated()">     
               <div class="panel-footer">
               <c:url
                     value="/group_main_post?mgroupIndex=${theleaderMgroup.mgroup_index}"
                     var="enterGroup" />
               <a href = "${enterGroup}" style="text-decoration-line: none">밴드 들어가기</a>
               </div>
               </security:authorize>
               
            </div>
            </c:forEach>
         </div>
         
            <div class="col-sm-4">
              가입대기중인 모임<br>
   <c:forEach var ="theWaitingMgroup" items = "${theWaitingMgroup}">
            <div class="panel panel-primary">
               <div class="panel-heading">${theWaitingMgroup.mgroup_title}</div>
               <div class="panel-body">
                  <img src="${theWaitingMgroup.mgroup_img_url}"
                     class="img-responsive" style="width: 50%" alt="Image">
               </div>
               <div class="panel-footer">${theWaitingMgroup.mgroup_maincategory}/${theWaitingMgroup.mgroup_middlecategory}</div>
             <security:authorize access="isAuthenticated()">     
               <div class="panel-footer">
               <c:url
                     value="/group_main_post?mgroupIndex=${theWaitingMgroup.mgroup_index}"
                     var="enterGroup" />
               <a href = "${enterGroup}" style="text-decoration-line: none">밴드 들어가기</a>
               </div>
               </security:authorize>
               
            </div>
            </c:forEach>
         </div>
        
            <div class="col-sm-4">
             가입중인 모임<br>
   <c:forEach var ="thejoinMgroup" items = "${thejoinMgroup}">
            <div class="panel panel-primary">
               <div class="panel-heading">${thejoinMgroup.mgroup_title}</div>
               <div class="panel-body">
                  <img src="${theleaderMgroup.mgroup_img_url}"
                     class="img-responsive" style="width: 50%" alt="Image">
               </div>
               <div class="panel-footer">${thejoinMgroup.mgroup_maincategory}/${thejoinMgroup.mgroup_middlecategory}</div>
             <security:authorize access="isAuthenticated()">     
               <div class="panel-footer">
               <c:url
                     value="/group_main_post?mgroupIndex=${thejoinMgroup.mgroup_index}"
                     var="enterGroup" />
               <a href = "${enterGroup}" style="text-decoration-line: none">밴드 들어가기</a>
               </div>
               </security:authorize>
               
            </div>
            </c:forEach>
         </div>
      </div>
      
         
   </div>


   <br>

   <br>

   <br>
   <div class="container-fluid text-center">
      <p>Online Store Copyright</p>
   </div>

</body>
</html>