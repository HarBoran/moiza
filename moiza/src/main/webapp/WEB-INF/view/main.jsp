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
				<p>가입중인 모임</p>

				<div id="myGroup">
					<c:forEach var="myGroup" items="${theSubscribedMgroup}">
						<div id="myGroupChild">
						<c:url value="/group_main_post"
								var="enterGroup">
							<%-- <c:url value="/group_main_post/${myGroup.mgroup_title}"
								var="enterGroup"> --%>
								<c:param name="mgroupIndex" value="${myGroup.mgroup_index}" />
							</c:url>
							<a href="${enterGroup}" style="text-decoration-line: none">
								${myGroup.mgroup_title} ${myGroup.mgroup_img} <img
								id="mgroupMainImg" src="${myGroup.mgroup_img_url}" width="200"
								height="200" alt="${myGroup.mgroup_title}" />
								${myGroup.mgroup_introduce} ${myGroup.mgroup_maincategory}
								${myGroup.mgroup_maincategory} ${myGroup.mgroup_local}
								${myGroup.mgroup_local_name} ${myGroup.mgroup_minage}
								${myGroup.mgroup_maxage} ${myGroup.mgroup_gender}
								${myGroup.mgroup_limit} ${myGroup.mgroup_out}
							</a>
						</div>
					</c:forEach>
				</div>
				<%-- <p>가입 대기중인 모임</p>

				<div id="myGroup">
					<c:forEach var="myWaitingGroup" items="${theWaitingMgroup}">
						<div id="myGroupChild">
							<c:url value="/group_main_post/${myWaitingGroup.mgroup_title}"
								var="enterWaitingGroup">
								<c:param name="mgroupIndex"
									value="${myWaitingGroup.mgroup_index}" />
							</c:url>
							<a href="${enterWaitingGroup}" style="text-decoration-line: none">
								${myWaitingGroup.mgroup_title} ${myWaitingGroup.mgroup_img} <img
								id="mgroupMainImg" src="${myWaitingGroup.mgroup_img_url}"
								width="200" height="200" alt="${myWaitingGroup.mgroup_title}" />
								${myWaitingGroup.mgroup_introduce}
								${myWaitingGroup.mgroup_maincategory}
								${myWaitingGroup.mgroup_maincategory}
								${myWaitingGroup.mgroup_local}
								${myWaitingGroup.mgroup_local_name}
								${myWaitingGroup.mgroup_minage} ${myWaitingGroup.mgroup_maxage}
								${myWaitingGroup.mgroup_gender} ${myWaitingGroup.mgroup_limit}
								${myWaitingGroup.mgroup_out}
							</a>
						</div>
					</c:forEach>
				</div> --%>
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
					<li class="nav-item"><a class="nav-link" href="#">내모임 관리하기</a></li>
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
	
	<br>

	<div class="container">
		<div class="row">
			<div class="col-sm-4">
				♥추천 모임~♥
				<div class="panel panel-danger">

					<div class="panel-heading">

						<c:url
							value="/group_main_post?mgroupIndex=${bestGroup.get(0).mgroup_index}"
							var="enterGroup" />
						모임명 : ${bestGroup.get(0).mgroup_title}


					</div>

					<div class="panel-body">

						<img src="${bestGroup.get(1).mgroup_img}" class="img-responsive"
							style="width: 100%" alt="Image">
					</div>
					<div class="panel-footer">카테고리:
						${bestGroup.get(0).mgroup_maincategory} ->
						${bestGroup.get(0).mgroup_middlecategory}</div>
				</div>
			</div>
				<div class="col-sm-4">
					♥추천 모임~♥
					<div class="panel panel-danger">
						<div class="panel-heading">모임명 :
							${bestGroup.get(1).mgroup_title}</div>
						<div class="panel-body">
							<img src="https://placehold.it/150x80?text=IMAGE"
								class="img-responsive" style="width: 100%" alt="Image">
						</div>
						<div class="panel-footer">카테고리:${bestGroup.get(1).mgroup_maincategory}
							-> ${bestGroup.get(1).mgroup_middlecategory}</div>
					</div>
				</div>
				
		 		
				<div class="col-sm-4">
					♥추천 모임~♥
					<div class="panel panel-danger">
						<div class="panel-heading">모임명:
							${bestGroup.get(2).mgroup_title}</div>
						<div class="panel-body">
							<img src="https://placehold.it/150x80?text=IMAGE"
								class="img-responsive" style="width: 100%" alt="Image">
						</div>
						<div class="panel-footer">카테고리:${bestGroup.get(2).mgroup_maincategory}
							-> ${bestGroup.get(2).mgroup_middlecategory}</div>
					</div>
				</div>
				
			</div>
		</div>

	<br>

	<br>

	<div class="container-fluid text-center">
		<p>Online Store Copyright</p>
	</div>

</body>
</html>