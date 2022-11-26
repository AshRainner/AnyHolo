<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="com.anyholo.model.data.MemberView"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body style="background-color: #EBECED;">

	<link rel="stylesheet"
		href="https://cdn.jsdelivr.net/npm/bootstrap@4.4.1/dist/css/bootstrap.min.css"
		integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh"
		crossorigin="anonymous">
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@4.4.1/dist/js/bootstrap.min.js"
		integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6"
		crossorigin="anonymous"></script>

	<script src="https://code.jquery.com/jquery-3.4.1.slim.min.js"
		integrity="sha384-J6qa4849blE2+poT4WnyKhv5vZF5SrPo0iEjwBvKU7imGFAV0wwj1yYfoRSJoZ+n"
		crossorigin="anonymous"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js"
		integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo"
		crossorigin="anonymous"></script>
<body>

	<header>

		<div class="navbar shadow-sm" style="background-color: #4C586F;">
			<div class="container">
				<a style="color: #FFFFFF; font-size: 2.0em" href="Homepage.jsp"
					class="navbar-brand d-flex align-items-center"> <strong>Video</strong>
				</a>
				<div class="d-grid gap-2 d-md-flex justify-content-md-end">
					<c:choose>
						<c:when test="${sessionScope.id eq null}">
							<button type="button" class="btn btn-light" button
								onclick="location.href='/Login'">
								<strong>Login</strong>
							</button>
							<button type="button" class="btn btn-light" button
								onclick="location.href='/Sighup'">
								<strong>Sign Up</strong>
							</button>
						</c:when>
						<c:when test="${sessionScope.id ne null}">
							<button type="button" class="btn btn-light" button
								onclick="location.href='/Logout?where=main'">
								<strong>Logout</strong>
							</button>
						</c:when>
					</c:choose>
				</div>
			</div>
		</div>
	</header>

	<nav class="navbar navbar-expand " style="background-color: #FFFFFF;"
		aria-label="Second navbar example">
		<!-- navbar-brand의 content 변경 -->
		<button class="navbar-toggler" type="button" data-toggle="collapse"
			data-target="#navbarSupportedContent"
			aria-controls="navbarSupportedContent" aria-expanded="false"
			aria-label="Toggle navigation">
			<span class="navbar-toggler-icon"></span>
		</button>
		<div class="collapse navbar-collapse" id="navbarSupportedContent">
			<ul class="navbar-nav nav-tabs mr-auto">
				<li class="nav-item"><a class="nav-link active"
					href="/Main"><strong>실시간</strong></a>
				</li>
				<li class="nav-item"><a class="nav-link" href="/Clip"><strong>클립</strong></a>
				</li>
				<!-- dropdown 메뉴 삭제 -->
				<li class="nav-item"><a class="nav-link" href="/Favorite"><strong>즐겨찾기</strong></a>
				</li>
			</ul>
			<form class="d-flex" role="search">
				<input class="form-control me-2" type="search" placeholder="Search"
					style="width: 400px; height: 35px; font-size: 20px;"
					aria-label="Search">
				<button class="btn btn-primary btn-circle" type="submit"
					style="width: 40px; height: 40px; color: white">
					<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16"
						fill="currentColor" class="bi bi-search" viewBox="0 0 16 16">
  	  <path
							d="M11.742 10.344a6.5 6.5 0 1 0-1.397 1.398h-.001c.03.04.062.078.098.115l3.85 3.85a1 1 0 0 0 1.415-1.414l-3.85-3.85a1.007 1.007 0 0 0-.115-.1zM12 6.5a5.5 5.5 0 1 1-11 0 5.5 5.5 0 0 1 11 0z"></path>
	 </svg>
				</button>
			</form>
		</div>
	</nav>

	<main>
		<div class="container">
			<div class="row row-cols-1 row-cols-sm-2 row-cols-md-4 g-3"
				id="mainContainer">
				<c:forEach var="n" items="${MemberList}">
					<c:if test="${n.onAir.onAir eq 'live'}">
						<div class="row">
							<div class="card shadow-sm">
								<div class="row">
									<a href="${n.onAir.onAirVideoUrl}" target="_blank"> <img
										style="width: 320px; height: 200px;"
										class="card-img img-fluid" src="${n.onAir.onAirThumnailsUrl}">
									</a>
								</div>
								<p style="width: 280px; pxwhite-space: normal; font-size: 15px"
									class="card-text pl-3 pt-3 pr-3 mx-1">${n.onAir.onAirTitle }</p>
								<a href="#" class="card-link line-height:1em ml-4"
									style="font-size: 12px;">${n.member.krName}</a>
								<p class="text-left ml-4" style="font-size: 10px;">Live 방송중</p>
							</div>
						</div>
					</c:if>
				</c:forEach>
			</div>
		</div>
	</main>
	<hr />
	<main>
		<div class="container">
			<div class="row row-cols-1 row-cols-sm-2 row-cols-md-4 g-3"
				id="mainContainer">
				<c:forEach var="n" items="${MemberList}">
					<c:if test="${n.onAir.onAir eq 'upcoming'}">
						<div class="row">
							<div class="card shadow-sm">
								<div class="row">
									<a href="${n.onAir.onAirVideoUrl}" target="_blank"> <img
										style="width: 320px; height: 200px;"
										class="card-img img-fluid" src="${n.onAir.onAirThumnailsUrl}">
									</a>
								</div>
								<p style="width: 280px; pxwhite-space: normal; font-size: 15px"
									class="card-text pl-3 pt-3 pr-3 mx-1">${n.onAir.onAirTitle }</p>
								<a href="#" class="card-link line-height:1em ml-4"
									style="font-size: 12px;">${n.member.krName}</a>
							</div>
						</div>
					</c:if>
				</c:forEach>
			</div>
		</div>
	</main>
	<script src="/docs/5.0/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM"
		crossorigin="anonymous"></script>

</body>
</body>
</html>