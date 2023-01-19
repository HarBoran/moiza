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
	background-color: #f0f2f5;
	border-color: #ecf19e;
}

/* Remove the jumbotron's default bottom margin */
.jumbotron {
	margin-bottom: 0;
	background-color: #f0f2f5;
}

/* Add a gray background color and some padding to the footer */
footer {
	background-color: #f0f2f5;
	padding: 25px;
}

body {
	background-color: #f0f2f5;
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
	margin: 9px;
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
					<c:forEach var="myGroup" items="${theMyMgroup}">
						<div id="myGroupChild">
							<c:url value="/group_main_post" var="enterGroup">
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

			</div>
		</div>

	</security:authorize>
	<br>
	<br>



	<br>
	<security:authorize access="isAnonymous()">
		<div class="container">
			<div class="row">
				<c:forEach var="bestGroup" items="${bestGroup}" varStatus="status">
					<div class="col-sm-4">
						♥추천 모임~♥
						<div class="panel panel-primary">
							<div class="panel-heading">모임명 : ${bestGroup.mgroup_title}</div>
							<c:url value="/group_main_post" var="enterBestMgroup">
								<c:param name="mgroupIndex" value="${bestGroup.mgroup_index}" />
							</c:url>
							<a href="${enterBestMgroup}" style="text-decoration-line: none">
								<div class="panel-body">
									<img id="mgroupMainImg" class="img-responsive"
										src="${bestGroup.mgroup_img_url}" width="100%"
										alt="${bestGroup.mgroup_title}" />
								</div>
							</a>
							<div class="panel-footer">카테고리:
								${bestGroup.mgroup_maincategory} ->
								${bestGroup.mgroup_middlecategory}</div>
						</div>
					</div>
				</c:forEach>
			</div>
		</div>
	</security:authorize>

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
			<c:forEach var="randomGroup" items="${randomGroup}">
				<div class="col-sm-4">
					<div class="panel panel-primary">
						<div class="panel-heading">모임명 : ${randomGroup.mgroup_title}</div>
						<c:url
							value="/group_main_post?mgroupIndex=${randomGroup.mgroup_index}"
							var="enterGroup" />
						<a href="${enterGroup}" style="text-decoration-line: none">
							<div class="panel-heading">${randomGroup.mgroup_title}</div>
							<div class="panel-body">

								<img src="${randomGroup.mgroup_img_url}" class="img-responsive"
									style="width: 100%" alt="Image">
							</div>
						</a>


						<div class="panel-footer">${randomGroup.mgroup_maincategory}
							/ ${randomGroup.mgroup_middlecategory}</div>

					</div>

				</div>
			</c:forEach>
		</div>
	</div>

</body>
</html>