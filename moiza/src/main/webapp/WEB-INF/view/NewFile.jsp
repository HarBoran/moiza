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
 <div class="container">
   <div id="loginSuccess">
      <p>로그인에 성공하였을 경우에만 나올 내용</p>
      <security:authorize access="isAuthenticated()">
      ${testid}
         User:<security:authentication property="principal.username" />
         <br>

         <div id="myGroup">
            <c:forEach var="myGroup" items="${theSbscribedMgroup}">
               <div id="myGroupChild">

                  <c:url
                     value="/group_main_post?mgroupIndex=${myGroup.mgroup_index}"
                     var="enterGroup" />
                  <a href="${enterGroup}" style="text-decoration-line: none">
                     ${myGroup.mgroup_title}</a> ${myGroup.mgroup_img}
                  ${myGroup.mgroup_introduce} ${myGroup.mgroup_maincategory}
                  ${myGroup.mgroup_maincategory} ${myGroup.mgroup_local}
                  ${myGroup.mgroup_minage} ${myGroup.mgroup_maxage}
                  ${myGroup.mgroup_gender} ${myGroup.mgroup_limit}
                  ${myGroup.mgroup_out}
               </div>
            </c:forEach>
         </div>
      </security:authorize>
      </div>
   </div>
   <nav class="navbar navbar-inverse">
      <div class="container-fluid">
         <div class="navbar-header">
            <button type="button" class="navbar-toggle" data-toggle="collapse"
               data-target="#myNavbar">
               <span class="icon-bar"></span> <span class="icon-bar"></span> <span
                  class="icon-bar"></span>
            </button>

         </div>
         <div class="collapse navbar-collapse" id="myNavbar">
            <ul class="nav navbar-nav">
               <li class="active"><a href="#">Home</a></li>
               <li class="active"><a href="#">Products</a></li>
               <li class="active"><a href="#">Deals</a></li>
               <li class="active"><a href="#">Stores</a></li>
               <li class="active"><a href="#">Contact</a></li>
            </ul>

            <br> <br>

         
         </div>
      </div>
   
   <ul class="nav navbar-nav navbar-right">
                          <security:authorize access="isAnonymous()">            
                  <li><a
                     href="${pageContext.request.contextPath}/showMyLoginPage"><span
                        class="glyphicon glyphicon-user"></span> login</a></li>
                  <li><a href="${pageContext.request.contextPath}/join"><span
                        class="glyphicon glyphicon-user"></span> Your Account</a></li>
               </security:authorize>
               <security:authorize access="isAuthenticated()">
                  <li><a href="${pageContext.request.contextPath}/test"><span
                     class="glyphicon glyphicon-user"></span> groupCreation</a></li>
                  <li><a href="${pageContext.request.contextPath}/Mypage"><span
                        class="glyphicon glyphicon-user"></span> My Page</a></li><br>
                  <li><form:form
                        action="${pageContext.request.contextPath}/logout" method="POST">
                        <input type="submit" value="Logout" />
                     </form:form></li>
               </security:authorize>

            </ul>
            </nav>
         <div class="container">
      <div class="row">
         <div class="col-sm-4">
            <div class="panel panel-primary">
               <div class="panel-heading">BLACK FRIDAY DEAL</div>
               <div class="panel-body">
                  <img src="https://placehold.it/150x80?text=IMAGE"
                     class="img-responsive" style="width: 100%" alt="Image">
               </div>
               <div class="panel-footer">Buy 50 mobiles and get a gift card</div>
            </div>
         </div>
         <div class="col-sm-4">
            <div class="panel panel-danger">
               <div class="panel-heading">BLACK FRIDAY DEAL</div>
               <div class="panel-body">
                  <img src="https://placehold.it/150x80?text=IMAGE"
                     class="img-responsive" style="width: 100%" alt="Image">
               </div>
               <div class="panel-footer">Buy 50 mobiles and get a gift card</div>
            </div>
         </div>
         <div class="col-sm-4">
            <div class="panel panel-success">
               <div class="panel-heading">BLACK FRIDAY DEAL</div>
               <div class="panel-body">
                  <img src="https://placehold.it/150x80?text=IMAGE"
                     class="img-responsive" style="width: 100%" alt="Image">
               </div>
               <div class="panel-footer">Buy 50 mobiles and get a gift card</div>
            </div>
         </div>
      </div>
   </div>
   <br>

   <div class="container">
      <div class="row">
         <div class="col-sm-4">
            <div class="panel panel-primary">
               <div class="panel-heading">BLACK FRIDAY DEAL</div>
               <div class="panel-body">
                  <img src="https://placehold.it/150x80?text=IMAGE"
                     class="img-responsive" style="width: 100%" alt="Image">
               </div>
               <div class="panel-footer">Buy 50 mobiles and get a gift card</div>
            </div>
         </div>
         <div class="col-sm-4">
            <div class="panel panel-primary">
               <div class="panel-heading">BLACK FRIDAY DEAL</div>
               <div class="panel-body">
                  <img src="https://placehold.it/150x80?text=IMAGE"
                     class="img-responsive" style="width: 100%" alt="Image">
               </div>
               <div class="panel-footer">Buy 50 mobiles and get a gift card</div>
            </div>
         </div>
         <div class="col-sm-4">
            <div class="panel panel-primary">
               <div class="panel-heading">BLACK FRIDAY DEAL</div>
               <div class="panel-body">
                  <img src="https://placehold.it/150x80?text=IMAGE"
                     class="img-responsive" style="width: 100%" alt="Image">
               </div>
               <div class="panel-footer">Buy 50 mobiles and get a gift card</div>
            </div>
         </div>
      </div>
   </div>
   <br>
   <br>

   <footer class="container-fluid text-center">
      <p>Online Store Copyright</p>
      <form class="form-inline">
         Get deals: <input type="email" class="form-control" size="50"
            placeholder="Email Address">
         <button type="button" class="btn btn-danger">Sign Up</button>
      </form>
   </footer>

</body>
</html>