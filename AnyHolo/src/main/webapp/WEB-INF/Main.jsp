<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="com.anyholo.model.data.MemberView"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
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
				<li class="nav-item"><a class="nav-link active" href="/Main"><strong>실시간</strong></a>
				</li>
				<li class="nav-item"><a class="nav-link" href="/Clip"><strong>클립</strong></a>
				</li>
				<!-- dropdown 메뉴 삭제 -->
				<li class="nav-item"><a class="nav-link" href="/Favorite"><strong>즐겨찾기</strong></a>
				</li>
			</ul>
		</div>
	</nav>
	<c:if test="${sessionScope.favorite ne 'null'}">
		<c:set var="favoriteLiveCheck" value="false" />
		<c:forEach var="n" items="${MemberList }">
			<c:if test="${not favoriteLiveCheck}">
				<c:if test="${fn:contains(sessionScope.favorite,n.member.krName)}">
					<h1>즐겨찾기/방송중</h1>
					<c:set var="favoriteLiveCheck" value="true" />
				</c:if>
			</c:if>
		</c:forEach>
		<main>
			<div id="justify-content" class="container-fluid">
				<div class="row row-cols-md-4">
					<c:forEach var="n" items="${MemberList}">
						<c:if test="${fn:contains(sessionScope.favorite,n.member.krName)}">
							<c:if test="${n.onAir.onAir eq 'live' }">
								<div class="row justify-content-around"
									style="margin-left: 10px; margin-top: 10px; margin-bottom: 10px">
									<div class="card shadow-sm">
										<div class="p-3 border">
											<a href="${n.onAir.onAirVideoUrl}" target="_blank"> <img
												style="width: 320px; height: 200px;" class="card-img-top"
												src="${n.onAir.onAirThumnailsUrl}" class="img-responsive">
											</a>
										</div>
										<div class="d-flex flex-row bd-highlight mb-3"
											style="height: 100px">
											<div class="order-1 p-2 bd-highlight"
												style="float: none; margin-top: 0; margin-left: 10px; margin-right: 0">
												<a
													href="https://www.youtube.com/channel/${n.member.channelId}"
													target="_blank"> <img
													style="width: 50px; height: 50px; border-radius: 70px;"
													class="card-img-top" src="${n.member.profileUrl}"
													class="img-responsive">
												</a>
											</div>
											<div class="order-2 p-2 bd-highlight">
												<p
													style="width: 200px; pxwhite-space: normal; font-size: 18px; margin-top: 0; margin-bottom: 0; margin-left: 0; overflow: hidden; text-overflow: ellipsis; word-wrap: break-word; display: -webkit-box; -webkit-line-clamp: 2; -webkit-box-orient: vertical; width: 300px line-heigth:1.0em; height: 3.0em;"" >${n.onAir.onAirTitle }</p>
												<a
													href="https://www.youtube.com/channel/${n.member.channelId}"
													style="font-size: 12px; margin-top: 0; margin-bottom: 0; margin-left: 0">${n.member.krName}
												</a>
												<p style="font-size: 10px; margin: 0">Live 방송중</p>
											</div>
										</div>
									</div>
								</div>
							</c:if>
						</c:if>
					</c:forEach>
				</div>
			</div>
		</main>
		<c:if test="${favoriteLiveCheck}">
			<hr />
		</c:if>
		<c:set var="favoriteLiveCheck" value="false" />
		<c:forEach var="n" items="${MemberList }">
			<c:if test="${not favoriteLiveCheck}">
				<c:if test="${n.onAir.onAir eq 'upcoming' }">
					<c:if test="${fn:contains(sessionScope.favorite,n.member.krName)}">
						<h1>즐겨찾기/방송예정</h1>
						<c:set var="favoriteLiveCheck" value="true" />
					</c:if>
				</c:if>
			</c:if>
		</c:forEach>
		
		<main>
			<div id="justify-content" class="container-fluid">
				<div class="row row-cols-md-4">
					<c:forEach var="n" items="${MemberList}">
						<c:if test="${fn:contains(sessionScope.favorite,n.member.krName)}">
							<c:if test="${n.onAir.onAir eq 'upcoming' }">
								<div class="row justify-content-around"
									style="margin-left: 10px; margin-top: 10px; margin-bottom: 10px">
									<div class="card shadow-sm">
										<div class="p-3 border">
											<a href="${n.onAir.onAirVideoUrl}" target="_blank"> <img
												style="width: 320px; height: 200px;" class="card-img-top"
												src="${n.onAir.onAirThumnailsUrl}" class="img-responsive">
											</a>
										</div>
										<div class="d-flex flex-row bd-highlight mb-3"
											style="height: 100px">
											<div class="order-1 p-2 bd-highlight"
												style="float: none; margin-top: 0; margin-left: 10px; margin-right: 0">
												<a
													href="https://www.youtube.com/channel/${n.member.channelId}"
													target="_blank"> <img
													style="width: 50px; height: 50px; border-radius: 70px;"
													class="card-img-top" src="${n.member.profileUrl}"
													class="img-responsive">
												</a>
											</div>
											<div class="order-2 p-2 bd-highlight">
												<p
													style="width: 200px; pxwhite-space: normal; font-size: 18px; margin-top: 0; margin-bottom: 0; margin-left: 0; overflow: hidden; text-overflow: ellipsis; word-wrap: break-word; display: -webkit-box; -webkit-line-clamp: 2; -webkit-box-orient: vertical; width: 300px line-heigth:1.0em; height: 3.0em;"" >${n.onAir.onAirTitle }</p>
												<a
													href="https://www.youtube.com/channel/${n.member.channelId}"
													style="font-size: 12px; margin-top: 0; margin-bottom: 0; margin-left: 0">${n.member.krName}
												</a>
												<p style="font-size: 10px; margin: 0">Live 방송중</p>
											</div>
										</div>
									</div>
								</div>
							</c:if>
						</c:if>
					</c:forEach>
				</div>
			</div>
		</main>
		<c:if test="${favoriteLiveCheck}">
			<hr />
		</c:if>
	</c:if>
	<h1>방송중</h1>
	<main>
		<div id="justify-content" class="container-fluid">
			<div class="row row-cols-md-4">
				<c:forEach var="n" items="${MemberList}">
					<c:if test="${n.onAir.onAir eq 'live'}">
						<div class="row justify-content-around"
							style="margin-left: 10px; margin-top: 10px; margin-bottom: 10px">
							<div class="card shadow-sm">
								<div class="p-3 border">
									<a href="${n.onAir.onAirVideoUrl}" target="_blank"> <img
										style="width: 320px; height: 200px;" class="card-img-top"
										src="${n.onAir.onAirThumnailsUrl}" class="img-responsive">
									</a>
								</div>
								<div class="d-flex flex-row bd-highlight mb-3"
									style="height: 100px">
									<div class="order-1 p-2 bd-highlight"
										style="float: none; margin-top: 0; margin-left: 10px; margin-right: 0">
										<a
											href="https://www.youtube.com/channel/${n.member.channelId}"
											target="_blank"> <img
											style="width: 50px; height: 50px; border-radius: 70px;"
											class="card-img-top" src="${n.member.profileUrl}"
											class="img-responsive">
										</a>
									</div>
									<div class="order-2 p-2 bd-highlight">
										<p
											style="width: 200px; pxwhite-space: normal; font-size: 18px; margin-top: 0; margin-bottom: 0; margin-left: 0; overflow: hidden; text-overflow: ellipsis; word-wrap: break-word; display: -webkit-box; -webkit-line-clamp: 2; -webkit-box-orient: vertical; width: 300px line-heigth:1.0em; height: 3.0em;"" >${n.onAir.onAirTitle }</p>
										<a
											href="https://www.youtube.com/channel/${n.member.channelId}"
											style="font-size: 12px; margin-top: 0; margin-bottom: 0; margin-left: 0">${n.member.krName}
										</a>
										<p style="font-size: 10px; margin: 0">Live 방송중</p>
									</div>
								</div>
							</div>
						</div>
					</c:if>
				</c:forEach>
			</div>
		</div>
	</main>
	<hr />
	<h1>방송예정</h1>
	<main>
		<div id="justify-content" class="container-fluid">
			<div class="row row-cols-md-4">
				<c:forEach var="n" items="${MemberList}">
					<c:if test="${n.onAir.onAir eq 'upcoming'}">
						<div class="row justify-content-around"
							style="margin-left: 10px; margin-top: 10px; margin-bottom: 10px">
							<div class="card shadow-sm">
								<div class="p-3 border">
									<a href="${n.onAir.onAirVideoUrl}" target="_blank"> <img
										style="width: 320px; height: 200px;" class="card-img-top"
										src="${n.onAir.onAirThumnailsUrl}" class="img-responsive">
									</a>
								</div>
								<div class="d-flex flex-row bd-highlight mb-3"
									style="height: 80px">
									<div class="order-1 p-2 bd-highlight"
										style="float: none; margin-top: 0; margin-left: 10px; margin-right: 0">
										<a
											href="https://www.youtube.com/channel/${n.member.channelId}"
											target="_blank"> <img
											style="width: 50px; height: 50px; border-radius: 70px;"
											class="card-img-top" src="${n.member.profileUrl}"
											class="img-responsive">
										</a>
									</div>
									<div class="order-2 p-2 bd-highlight">
										<p
											style="width: 200px; pxwhite-space: normal; font-size: 18px; margin-top: 0; margin-bottom: 0; margin-left: 0; overflow: hidden; text-overflow: ellipsis; word-wrap: break-word; display: -webkit-box; -webkit-line-clamp: 2; -webkit-box-orient: vertical; width: 300px line-heigth:1.0em; height: 3.0em;"" >${n.onAir.onAirTitle }</p>
										<a
											href="https://www.youtube.com/channel/${n.member.channelId}"
											style="font-size: 12px; margin-top: 0; margin-bottom: 0; margin-left: 0">${n.member.krName}
										</a>
									</div>
								</div>
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