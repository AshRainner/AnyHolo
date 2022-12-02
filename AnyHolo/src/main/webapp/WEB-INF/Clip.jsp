<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="com.anyholo.model.data.KirinukiView"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>PICK</title>
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
				<a style="color: #FFFFFF; font-size: 2.0em" href="/Main"
					class="navbar-brand d-flex align-items-center"> <strong>메인</strong>
				</a>
				<div class="d-grid gap-2 d-md-flex justify-content-md-end">
					<c:choose>
						<c:when test="${sessionScope.id eq null}">
							<button type="button" class="btn btn-light" button
								onclick="location.href='/Login'">
								<strong>Login</strong>
							</button>
							<button type="button" class="btn btn-light" button
								onclick="location.href='/Signup'">
								<strong>Sign Up</strong>
							</button>
						</c:when>
						<c:when test="${sessionScope.id ne null}">
							<button type="button" class="btn btn-light" button
								onclick="location.href='/Logout?where=clip'">
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
				<li class="nav-item"><a class="nav-link" href="/Main"><strong>실시간</strong></a>
				</li>
				<li class="nav-item"><a class="nav-link active" href="/Clip"><strong>클립</strong></a>
				</li>
				<!-- dropdown 메뉴 삭제 -->
				<c:if test="${sessionScope.id ne null}">
					<li class="nav-item"><a class="nav-link" href="/Favorite"><strong>즐겨찾기</strong></a>
					</li>
				</c:if>
			</ul>
			<form action="/Clip" method="get" class="d-flex" role="search">
				<input class="form-control me-2" type="search" placeholder="Search"
					style="width: 400px; height: 35px; font-size: 20px;"
					aria-label="Search" name="Keyword">
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
	<input type="hidden" name="searchKeyword" value="${Keyword}">
	<main>
		<div id="justify-content" class="container-fluid">
			<div class="row row-cols-md-4" id="mainContainer">
				<c:forEach var="n" items="${kirinukiList}">
					<div class="row justify-content-around"
						style="margin-left: 10px; margin-top: 10px; margin-bottom: 10px">
						<div class="card shadow-sm">
							<div class="p-3 border">
								<a href="https://www.youtube.com/watch?v=${n.video.videoUrl}"
									target="_blank"> <img style="width: 320px; height: 200px;"
									class="card-img-top" src="${n.video.thumnailUrl}"
									class="img-responsive">
								</a>
							</div>
							<div class="ml-5 mr-5 p-2 bd-highlight">
								<p
									style="width: 240px; pxwhite-space: normal; font-size: 18px; margin-top: 0; margin-bottom: 0; margin-left: 0; overflow: hidden; text-overflow: ellipsis; word-wrap: break-word; display: -webkit-box; -webkit-line-clamp: 2; -webkit-box-orient: vertical; width: 300px line-heigth:1.0em; height: 3.0em;"" >${n.video.videoTitle }</p>
								<a href="https://www.youtube.com/channel/${n.user.youtubeUrl}"
									style="font-size: 12px; margin-top: 0; margin-bottom: 0; margin-left: 0">${n.user.userName}
								</a>
								<p style="font-size: 10px; margin: 0">${n.video.upLoadTime}</p>
							</div>
						</div>
					</div>
				</c:forEach>
			</div>
		</div>
	</main>
	<script src="/docs/5.0/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM"
		crossorigin="anonymous"></script>
	<script src="https://code.jquery.com/jquery-3.4.1.js"></script>
	<script type="text/javascript">
		var loading = false;
		var scrollPage = 2;
		var keyword = "<c:out value='${Keyword}'/>"
		$(window).scroll(
				function() {
					if ($(window).scrollTop() + 100 >= $(document).height()
							- $(window).height()) {

						if (!loading) //실행 가능 상태라면?
						{
							surveyList(scrollPage);
						}
					}
				});
		function surveyList(page) {
			if (!loading) {
				loading = true;
				$
						.ajax({
							url : "http://52.193.142.22/ClipGet",
							type : "get",
							data : {
								"Page" : scrollPage,
								"Keyword" : keyword
							},
							dataType : "json",
							success : function(data) {
								loading = false;
								scrollPage += 1;
								data
										.forEach(function(value) {
											var row = document
													.createElement("div");
											row
													.setAttribute("class",
															"row justify-content-around");
											row
													.setAttribute("style",
															"margin-left: 10px; margin-top: 10px; margin-bottom: 10px");
											var card = document
													.createElement("div");
											card.setAttribute("class",
													"card shadow-sm");
											var secondRow = document
													.createElement("div");
											secondRow.setAttribute("class",
													"p-3 border");
											var a = document.createElement("a");
											a.setAttribute("href",
													"https://www.youtube.com/watch?v="
															+ value.youtubeUrl);
											a.setAttribute("target", "_blank");
											var img = document
													.createElement("img");
											img
													.setAttribute("style",
															"width: 320px; height: 200px;");
											img.setAttribute("class",
													"card-img-top");
											img.setAttribute("src",
													value.thumnailUrl);

											var nameTimeDiv = document
													.createElement("div");
											nameTimeDiv
													.setAttribute("class",
															"ml-5 mr-5 p-2 bd-highlight");
											var p = document.createElement("p");
											p
													.setAttribute(
															"style",
															"width: 240px; pxwhite-space: normal; font-size: 18px; margin-top: 0; margin-bottom: 0; margin-left: 0; overflow: hidden; text-overflow: ellipsis; word-wrap: break-word; display: -webkit-box; -webkit-line-clamp: 2; -webkit-box-orient: vertical; width: 300px line-heigth:1.0em; height: 3.0em;");
											p.innerHTML = value.videoTitle;
											var name = document
													.createElement("a");
											name
													.setAttribute("style",
															"font-size: 12px; margin-top: 0; margin-bottom: 0; margin-left: 0");
											name.setAttribute("href",
													"https://www.youtube.com/channel/"
															+ value.userUrl);
											name.innerHTML = value.channelName;
											var upLoadTime = document
													.createElement("p");
											upLoadTime
													.setAttribute("style",
															"font-size: 10px; margin: 0");
											upLoadTime.innerHTML = value.uploadTime;
											card.appendChild(secondRow);
											secondRow.appendChild(a);
											secondRow.appendChild(img);
											card.appendChild(nameTimeDiv);
											nameTimeDiv.appendChild(p);
											nameTimeDiv.appendChild(name);
											nameTimeDiv.appendChild(upLoadTime);
											row.appendChild(card);
											document.getElementById(
													'mainContainer')
													.appendChild(row);
										});
								loading = false;
								scrollPage++;
							},
							error : function() {
								console.log('에러');
							}
						})
			}
		}
	</script>




</body>
</body>
</html>