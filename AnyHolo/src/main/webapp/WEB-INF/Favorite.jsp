<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="com.anyholo.model.data.MemberView"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<title>PICK</title>
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
<script
	src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
<style>
.accordion {
	margin: 15px;
}

.accordion .fa {
	margin-right: 0.2rem;
}
</style>
<script>
	$(document).ready(
			function() {
				// Add minus icon for collapse element which
				// is open by default
				$(".collapse.show").each(
						function() {
							$(this).prev(".card-header").find(".fa").addClass(
									"fa-minus").removeClass("fa-plus");
						});
				// Toggle plus minus icon on show hide
				// of collapse element
				$(".collapse").on(
						'show.bs.collapse',
						function() {
							$(this).prev(".card-header").find(".fa")
									.removeClass("fa-plus")
									.addClass("fa-minus");
						}).on(
						'hide.bs.collapse',
						function() {
							$(this).prev(".card-header").find(".fa")
									.removeClass("fa-minus")
									.addClass("fa-plus");
						});
			});
</script>
</head>

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
			<li class="nav-item"><a class="nav-link" href="/Clip"><strong>클립</strong></a>
			</li>
			<!-- dropdown 메뉴 삭제 -->
			<li class="nav-item"><a class="nav-link active" href="/Favorite"><strong>즐겨찾기</strong></a>
			</li>
		</ul>
	</div>
</nav>

<main>
	<script src="https://code.jquery.com/jquery-3.4.1.js"></script>
	<script type="text/javascript">
		function damaY(Name) {
			var dama = document.getElementById(Name);
			var id = console.log("User: " + Name);
			var updel = "up";
			if (dama.src.match("fzB7l3fCLDkAAAAASUVORK5CYII=")) {
				dama.src = "data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAADAAAAAwCAYAAABXAvmHAAAABmJLR0QA/wD/AP+gvaeTAAAFWElEQVRoge2YS4xTZRTHf6ftEGAGBMZHSDDBzHTaTpGMA23HSCAkJi7EhQTZmBAXCAswLkwEJCIuSIaNCzUkggsTDZOIO/AJBlEe007BkVimnbYBowkmBiVmRnm033ExpfTedmZ6O7cbM2d17znf+Z//+c79HufCrMzKrDRNNBFcp4ngumbG8DUTHNgHqsCZZgWQZgFrPPgkwvmJF89aiV35oRlxPM0ALSHvLz+L2dusME2pgCa7YxgzaI2kaySSOed2rOZUoFjcV62UPc0I5XoFNBnqxWiyNraJSnR0yM147lfA6FtMNjHqdX0tuFoBTYR7oHhpClzFEJG+9EW3YrpcgeKbWMmfAb6veBc8uLoWXKuAJrrDYC5jmRTP04gKqicrh2K0R/oyl92I62IFdJ8N74JEr3wrkZFTqJyt0Ase3nArqisJ6AV/CHSTVcnb5WcxB6we8oIOhVa4EdvxJ6TxYDsqfrz4UbpAO4EY8FgFbEKiIzGLXyIUB41WqK4CcZAcwihFsohmJZa+MeME9MeeRdz9x496OhH8QBeIv0R2yfRZ8pzE0icsqnhwA8LxOjj9CZIDzQKjKFnE5GiZn5Unhm9OmYDGgwcQXgYeqiPQZOyHiWR6RVCLVhGGApdAehrH5g+UIxJLl88T6xrwth4AhmcQ4DrCfjt5ABEUYT9wfQb4wyWO93HtI/T08rm0zf0M5dkaAEXgV9A8SB6VPKI51ORpa8lLODVWDwtNhdsYu9uBeDpQ6US0A7QDpAN4FPBWOQmfM3Zrk6y/dmvKBEoB5jBeHAA22kD+Qs0zbt9nynEnTvKTwIM20wkWFzaJP3fb7lNzG5Vw6g7X0ptBPrFGYDHIN5rsjtXym4loMtQLxVNUkZdP8bRurEUepjgHZDNFro28BHxksyzCmK91MNQ3U9L3RAeDqzB6Emi3Ghhg/JEXZfXFu5PynBZcEYaC7wE7bKZxhA0SSX/XCOky/lDgKVS+ABbaLB8SyWwXwUzlP+1JLIISSb8CeshmasVwXBOhtU5JlykmQmsx8hXV5A8RyWybjjzUeZWYSCKzE+Edq4E20C91MLC+ftolismuNaAnJjAslkNEMjtrbcW1pO67kAgqkfRrQL/NNB+PvF4vTlmMZy+wwKbtl2hmR73koYHLnETTe1AGrEr9ySlOlY8yING0416h0dtoi+XNiPMEqn1aao6bRhpLQHjc8u7lZ8cYqikbZkPXa8cJ6Onlc4HOClWBBwqjNcfGg10aD3bVBGovZoBChcZfwnYkzivQ2hqk8q4ikrWfkjrYuUwTgSMIKYSUJgJHdLBzWeUY8eduI5KtUHlL2I7EeQJirJ+Puf8p6PnwEh0K9OPxjYJsZeLnsQ9kKx5fXhPBD/Rcx8NlX9UrVvCC48+ogTVgwjZFSpOr5ms8tAtfIY/KLmBeDcc5wDZ8LXkdCvTr2cACwLoOEDv2tNLA73WxzpKwEjOeQ1haV4cqtKGyizlsAWz/T22bQx3iPAHDChvP5ycZeQPRgwClqrTb7EurfI3znchRU6+DnQvx+G5O4zeO6Pv45vXf62EnGhizA9E9wANThcAUFklf7u96OTlbAx7fCiYnfwc4DN5OiWR2VzbgEk6NSWzkIEpHqSr/ToIhiM/ROnCWQO3D5i6qH6MalGh6u0RTv0/qHkvfkEhmN6bQBbwLVDcpDg80ZwkolbNjEDmGkbDEMlsklrlaL4z05X6TaPpVfBIADjPRa9+zNrEClGfnFOJZLZGRzdI3kp3SYwqR3pFfJJrejvGuROQYoGBc+WNXUzQePNqMfriMn+yOaTx4tFn4szIr/0f5D1yB0iClsG6VAAAAAElFTkSuQmCC";
				updel = "del";
				$.ajax({
					url : "http://localhost:8081/FavoriteUpdate",
					type : "get",
					data : {
						"Name" : Name,
						"updel" : updel
					},
					success : function(data) {

					},
					error : function() {
						console.log('에러');
					}
				})
			} else {
				dama.src = "data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAADAAAAAwCAYAAABXAvmHAAAABmJLR0QA/wD/AP+gvaeTAAAEoElEQVRoge2Z3W8UZRTGf2eWtlBEgtJu+dIQGhED8iEsCbAbqiYSolxqIglcGk0oiNyZGLjwjiuIfwAYb42JIaBeEGMw8YOYFjEkRAhSoFAt0m7blLLv48XutjPb2e7OMqOJ6bnYd949857nOXOeOfPOLszarM1aYqbLHRn92rElSQxLKrB60u2k7DoABa209XfvJYHjJRG0GNneA1oRraXjRCyRCuhqZwvj+RtI6eIXDJBveta29Y3FjZVMBcZH9vnIA7Qxf2JvElCxJyBhyB1ClMgLJEBHpPgrHn8FLnXsQrwAFImXE5FW09v2WtxwCUhIh4uDStPShwDH+3GjxVpS9aTXgnon4/rJQykpb4NtutcTF2a8FZA+AKwkGaaTB1Q4GCdkbBVQT7oddAMxN0AcKuU0jmylbf7zThy48VVA7sA08lLYvdACvBsXbCwV0PfL59E6/geweLpkJj/8iQ3S3PSMrb878rjYkROQMH5rS1PQMpRaClqO2I6013/SFOFqcrLPwF0A+nDuNl7zLbYM3DULnB09AV1qX0UqtQyxAqclYMtRYRnYUmAFUgfQFEpQPuwIPk35JhD9wE2k20K3PNSHszuYu4lL9Vn2wbWqCejy0mPIfRQA8Q01ZNGQT6o4N7RzTflMOmrZ/LHyN3P8CSB3DRDCgqX3B62YhxGs06fo6wTedT/lQBeytf2nkO0HTQQ7SRXy4V2mpk9SdfLV1xVMvGPZodMBzoSYetOvAp8jLQgE8g3/lmRKMUZN3puWGzpTybVqF9IvHVvw3BlE238oGYBBE3ssN3whjOeMbVSX2ldR0DlEZwAkDKi+LhNpHeKGFdhlXcNXqnGs+RzQj20dNHEWaUMAxDfUL5mZ1k1L7LIVCrusa6xvJn41txKWGeinmSzYN4ErVI28zxcqmarrAuS/tfGm7bXIQ4Qnsa52tjD09ymktwIEKgn6iYf46pDhFzYn/7Zto67350hbCQnj4uLjyB0OEPAPjUsGGZ94O/LdZrh6OTW0mdNPi04gOxBTlymSh5OpXL47Kpc5tU8JMZGPUTJlG26ESmMJYFvL4I8jGb/P0NZGmER+oZHwkDYXjxvuMmG+jI5G5xP9jeyHp56X9GQDe5kpn0J9C+h6YnXyCchlJslVfXGvQr7sK88rfU6ZqHQiJ+A8ZWKRTHnuO3blixPBIt/E5iwTucvUcRODMEeyFdB55oLWhUtmmpwGDbrN0Q0MVq8IU9UyXixiJJQALQs2IZqnk/DJSTiJTy3FGsvlT9rO/EnzUp2CE4hHNeTUTGHexuQSIJWZscug84bbmMoN77Pt+cl/ZCz74H5q58hBw1sHnA2XWmnuot0HkRJwlR1oUhZ203D7vWz+ZcuN9FZbb13DV7yu0d0m9iB+nyLPZDJOllwCBpmKqzciZ8fs0dBzlh05PeNif5xXRr+0hWNrTO4QMOSXk1m0Vlr/dvq7hYtk+gtkCCc45anwoeVGH+s3Tp1rXeJSjz422X7AQ8gmxp+217lfz/r6E/gqPV+toxeBfjPviO148HOjpEPjf920WfKOg9L28OFL9gajccaftVn7v9o/fzB7l3fCLDkAAAAASUVORK5CYII=";
				$.ajax({
					url : "http://localhost:8081/FavoriteUpdate",
					type : "get",
					data : {
						"Name" : Name,
						"updel" : updel
					},
					success : function(data) {

					},
					error : function() {
						console.log('에러');
					}
				})
			}
		}
	</script>
	<style>
p {
	width: 1350px;
	margin-top: 100px;
}

img.relative {
	float: sticky;
	margin-top: 100px;
}
</style>
	<body style="background-color: #EBECED;">
	<body>
		<div class="accordion">
			<div class="accordion" id="accordionExample">
				<div class="card">
					<div class="card-header" id="headingOne">
						<h2 class="mb-0">
							<button type="button" class="btn btn-link" data-toggle="collapse"
								data-target="#gen0">
								<i class="fa fa-plus"></i> 0th Generation
							</button>
						</h2>
					</div>
					<div id="gen0" class="collapse" aria-labelledby="headingOne"
						data-parent="#accordionExample">
						<c:forEach var="i" begin="0" end="4">
							<div class="d-flex flex-row border">
								<div class="order-1 p-1">
									<a
										href="https://www.youtube.com/channel/${MemberList[i].member.channelId}"
										target="_blank"> <img
										style="width: 80px; height: 80px; border-radius: 70px;"
										class="card-img-top" src="${MemberList[i].member.profileUrl}">
									</a>
								</div>
								<div class="order-2 p-1">
									<div
										class="btn-group float-right d-flex justify-content-between"
										role="group" aria-label="Basic example">
										<c:choose>
											<c:when
												test="${fn:contains(sessionScope.favorite,MemberList[i].member.krName) }">
												<img id="${MemberList[i].member.krName}"
													onclick="damaY('${MemberList[i].member.krName}')"
													src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAADAAAAAwCAYAAABXAvmHAAAABmJLR0QA/wD/AP+gvaeTAAAEoElEQVRoge2Z3W8UZRTGf2eWtlBEgtJu+dIQGhED8iEsCbAbqiYSolxqIglcGk0oiNyZGLjwjiuIfwAYb42JIaBeEGMw8YOYFjEkRAhSoFAt0m7blLLv48XutjPb2e7OMqOJ6bnYd949857nOXOeOfPOLszarM1aYqbLHRn92rElSQxLKrB60u2k7DoABa209XfvJYHjJRG0GNneA1oRraXjRCyRCuhqZwvj+RtI6eIXDJBveta29Y3FjZVMBcZH9vnIA7Qxf2JvElCxJyBhyB1ClMgLJEBHpPgrHn8FLnXsQrwAFImXE5FW09v2WtxwCUhIh4uDStPShwDH+3GjxVpS9aTXgnon4/rJQykpb4NtutcTF2a8FZA+AKwkGaaTB1Q4GCdkbBVQT7oddAMxN0AcKuU0jmylbf7zThy48VVA7sA08lLYvdACvBsXbCwV0PfL59E6/geweLpkJj/8iQ3S3PSMrb878rjYkROQMH5rS1PQMpRaClqO2I6013/SFOFqcrLPwF0A+nDuNl7zLbYM3DULnB09AV1qX0UqtQyxAqclYMtRYRnYUmAFUgfQFEpQPuwIPk35JhD9wE2k20K3PNSHszuYu4lL9Vn2wbWqCejy0mPIfRQA8Q01ZNGQT6o4N7RzTflMOmrZ/LHyN3P8CSB3DRDCgqX3B62YhxGs06fo6wTedT/lQBeytf2nkO0HTQQ7SRXy4V2mpk9SdfLV1xVMvGPZodMBzoSYetOvAp8jLQgE8g3/lmRKMUZN3puWGzpTybVqF9IvHVvw3BlE238oGYBBE3ssN3whjOeMbVSX2ldR0DlEZwAkDKi+LhNpHeKGFdhlXcNXqnGs+RzQj20dNHEWaUMAxDfUL5mZ1k1L7LIVCrusa6xvJn41txKWGeinmSzYN4ErVI28zxcqmarrAuS/tfGm7bXIQ4Qnsa52tjD09ymktwIEKgn6iYf46pDhFzYn/7Zto67350hbCQnj4uLjyB0OEPAPjUsGGZ94O/LdZrh6OTW0mdNPi04gOxBTlymSh5OpXL47Kpc5tU8JMZGPUTJlG26ESmMJYFvL4I8jGb/P0NZGmER+oZHwkDYXjxvuMmG+jI5G5xP9jeyHp56X9GQDe5kpn0J9C+h6YnXyCchlJslVfXGvQr7sK88rfU6ZqHQiJ+A8ZWKRTHnuO3blixPBIt/E5iwTucvUcRODMEeyFdB55oLWhUtmmpwGDbrN0Q0MVq8IU9UyXixiJJQALQs2IZqnk/DJSTiJTy3FGsvlT9rO/EnzUp2CE4hHNeTUTGHexuQSIJWZscug84bbmMoN77Pt+cl/ZCz74H5q58hBw1sHnA2XWmnuot0HkRJwlR1oUhZ203D7vWz+ZcuN9FZbb13DV7yu0d0m9iB+nyLPZDJOllwCBpmKqzciZ8fs0dBzlh05PeNif5xXRr+0hWNrTO4QMOSXk1m0Vlr/dvq7hYtk+gtkCCc45anwoeVGH+s3Tp1rXeJSjz422X7AQ8gmxp+217lfz/r6E/gqPV+toxeBfjPviO148HOjpEPjf920WfKOg9L28OFL9gajccaftVn7v9o/fzB7l3fCLDkAAAAASUVORK5CYII="
													style="width: 30px; height: 30px; float: sticky; margin-top: 25px;">
											</c:when>
											<c:otherwise>
												<img id="${MemberList[i].member.krName}"
													onclick="damaY('${MemberList[i].member.krName}')"
													src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAADAAAAAwCAYAAABXAvmHAAAABmJLR0QA/wD/AP+gvaeTAAAFWElEQVRoge2YS4xTZRTHf6ftEGAGBMZHSDDBzHTaTpGMA23HSCAkJi7EhQTZmBAXCAswLkwEJCIuSIaNCzUkggsTDZOIO/AJBlEe007BkVimnbYBowkmBiVmRnm033ExpfTedmZ6O7cbM2d17znf+Z//+c79HufCrMzKrDRNNBFcp4ngumbG8DUTHNgHqsCZZgWQZgFrPPgkwvmJF89aiV35oRlxPM0ALSHvLz+L2dusME2pgCa7YxgzaI2kaySSOed2rOZUoFjcV62UPc0I5XoFNBnqxWiyNraJSnR0yM147lfA6FtMNjHqdX0tuFoBTYR7oHhpClzFEJG+9EW3YrpcgeKbWMmfAb6veBc8uLoWXKuAJrrDYC5jmRTP04gKqicrh2K0R/oyl92I62IFdJ8N74JEr3wrkZFTqJyt0Ase3nArqisJ6AV/CHSTVcnb5WcxB6we8oIOhVa4EdvxJ6TxYDsqfrz4UbpAO4EY8FgFbEKiIzGLXyIUB41WqK4CcZAcwihFsohmJZa+MeME9MeeRdz9x496OhH8QBeIv0R2yfRZ8pzE0icsqnhwA8LxOjj9CZIDzQKjKFnE5GiZn5Unhm9OmYDGgwcQXgYeqiPQZOyHiWR6RVCLVhGGApdAehrH5g+UIxJLl88T6xrwth4AhmcQ4DrCfjt5ABEUYT9wfQb4wyWO93HtI/T08rm0zf0M5dkaAEXgV9A8SB6VPKI51ORpa8lLODVWDwtNhdsYu9uBeDpQ6US0A7QDpAN4FPBWOQmfM3Zrk6y/dmvKBEoB5jBeHAA22kD+Qs0zbt9nynEnTvKTwIM20wkWFzaJP3fb7lNzG5Vw6g7X0ptBPrFGYDHIN5rsjtXym4loMtQLxVNUkZdP8bRurEUepjgHZDNFro28BHxksyzCmK91MNQ3U9L3RAeDqzB6Emi3Ghhg/JEXZfXFu5PynBZcEYaC7wE7bKZxhA0SSX/XCOky/lDgKVS+ABbaLB8SyWwXwUzlP+1JLIISSb8CeshmasVwXBOhtU5JlykmQmsx8hXV5A8RyWybjjzUeZWYSCKzE+Edq4E20C91MLC+ftolismuNaAnJjAslkNEMjtrbcW1pO67kAgqkfRrQL/NNB+PvF4vTlmMZy+wwKbtl2hmR73koYHLnETTe1AGrEr9ySlOlY8yING0416h0dtoi+XNiPMEqn1aao6bRhpLQHjc8u7lZ8cYqikbZkPXa8cJ6Onlc4HOClWBBwqjNcfGg10aD3bVBGovZoBChcZfwnYkzivQ2hqk8q4ikrWfkjrYuUwTgSMIKYSUJgJHdLBzWeUY8eduI5KtUHlL2I7EeQJirJ+Puf8p6PnwEh0K9OPxjYJsZeLnsQ9kKx5fXhPBD/Rcx8NlX9UrVvCC48+ogTVgwjZFSpOr5ms8tAtfIY/KLmBeDcc5wDZ8LXkdCvTr2cACwLoOEDv2tNLA73WxzpKwEjOeQ1haV4cqtKGyizlsAWz/T22bQx3iPAHDChvP5ycZeQPRgwClqrTb7EurfI3znchRU6+DnQvx+G5O4zeO6Pv45vXf62EnGhizA9E9wANThcAUFklf7u96OTlbAx7fCiYnfwc4DN5OiWR2VzbgEk6NSWzkIEpHqSr/ToIhiM/ROnCWQO3D5i6qH6MalGh6u0RTv0/qHkvfkEhmN6bQBbwLVDcpDg80ZwkolbNjEDmGkbDEMlsklrlaL4z05X6TaPpVfBIADjPRa9+zNrEClGfnFOJZLZGRzdI3kp3SYwqR3pFfJJrejvGuROQYoGBc+WNXUzQePNqMfriMn+yOaTx4tFn4szIr/0f5D1yB0iClsG6VAAAAAElFTkSuQmCC"
													style="width: 30px; height: 30px; float: sticky; margin-top: 25px;">
											</c:otherwise>
										</c:choose>
										<a
											href="https://www.youtube.com/channel/${MemberList[i].member.channelId}"
											target="_blank"> <img
											style="width =: 30px; height: 30px; margin-left: 10px; margin-top: 25px;"
											src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAADAAAAAwCAYAAABXAvmHAAAABmJLR0QA/wD/AP+gvaeTAAAEZ0lEQVRoge3Y32tbZRzH8fdz0nZNujZt58Sta2WTiQiCF/5gCDo2nAgiwxtlAxGd/8OYQ+cYbojOCxWc80aQ3QiCgsPRjVbETZx6oV4IbnOUbh3WtsmapmmT8/14kZPY7LQuOUm1sHxvknPOk/O8Puf7HE4SaFazmtWsZt3K5aoZNP70i53tbq7foX4n6wP6Dfow9QLdSN0S3aBORCsSoITEKiQEs07KSQA2h9w0kEKWkkg5NC5pDGPE4Y/mfV3JWedI/7lPZyMFSD+1a3PM0x6c2wFsBJIARRhIAgEIpGB3sK+ID16K4yvHLLZvic+hCUkX8fWVtfDB2m9Ojd00QGbnrhcQ7wOJigP/NV4K5iqPmTSz59d+f/rLJQNkdu7ejnQKiK0wPCqeY8bz2NJ77vQvJZpX6dShFYwH0eEXbP+iHcg+s3uD+Rqp6MrKwpeO5zKrrWfj8HCuogPm655o+OD8EnkZBbPlxANq77xuG0vMcgDn2BTtyhePZf0CuQfuJ3vfvWT8PGa2HPjitsXuLlFbFpg3Rbnypfdzvs+dr+/DtbaSPnWGqfeOkcjM0ua8xuIlfNi8eAdqwlcuEZNwra0AJJ/YzoaPj5Hf8mDQDTUMH2yHA2C2Piq+PGZBtfT20PfGq3S9tpd0YhVz8huDFzjUHwogud668KoMUKqubY/S/8lx8lseIlPIY+VzR8MjgbE2HAB1Nxq/sBsbjhwgeXAf6UScnPnR8Qjh3xYKgOioC3+TEABd2x9j4MRH+I88TKZQwGS14yUwtzocALXVg6/CDwTdePMgyUP7SXckyJvVhi/O3R4OILXVh68yQVDJx7cycOI42UQC1YIvHgsHqBtfm39B1YwHlA8FAM3Xha92DQWVHhxi5LmXiE/P4GrBF7dTpfOUn8SIeYLWRMNXF6AwMcnY4aPY0Ld0eg7PURu+OP9iATQDdEXFV9OA9OAQ44ffITGdIe5VfsWoAY+k6+EAMCVpXWT8vwQoTEwxdvhtbPgsSc/hcPXgQZoKBZBssoyoGb+0Pj04zPiRoySmZ0h4Xu03bBi/xBIyXcW56PgbMpSv+tdnSXoeHq5BeHDiWiiAw/tDiv5jBAnN53FtraRODjLx1rvEZ2ZIeLF/AA3AI+E7XQwFMOdfwkprsza8JOKeY3TvAZSbRz/8RJfn8PAajhfCK3BpkSUUuwR+JDwS7S5G4ex5QLR4XiWogXgkTK7cgfKDzC/ot2C2mvHFdSlaXHBFlhGPyGVjqcuhAGuGPxsFvouCv2GC5cTjTJ9vvnBhLhSgSNYrEoWVikfKOK9waKG5IkDPmS+GEHswsisOb5rwsWfvuPjzrwvNi/65m9r25F1m3suY24FsE5D8n/CTGL87OBkz78PbL5+/dqO1qr/X/9y6dXXMjw9gfp98r885DUi2DrQG0YMpKVM3TnFERwBqR8QDfFbSXHCzZ3xp1kkpnEs7s5Rhf2EaQ27EoVHDrpBhZP3VH7PV+JrVrGY1q1m3bv0NDRMeqgk0OuwAAAAASUVORK5CYII="
											alt=""></a> <a
											href="https://twitter.com/${MemberList[i].member.twitterId}"
											target="_blank"> <img
											style="width =: 30px; height: 30px; margin-left: 10px; margin-top: 25px;"
											src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAADAAAAAwCAYAAABXAvmHAAAABmJLR0QA/wD/AP+gvaeTAAADz0lEQVRoge2XTWgdVRiGn+/MpGnv3LRoqC4UhCz8I8RFRClSXdgqWkuV4CRpi1gqglZTuhFXkiDdCVIKBfEHo1Bzr0JRtGAqWhTBQhsaFX9ADbZisbXaJnPb5t6Z+VyotU0yc89MYlGYZzcz73fO+84ZzjcHCgoKCgoK/sfIJZ2tOnmdq+ZxYLXCNUCowvdG9b3QNbvo8Y7NLFm0O+iqry9/njRk0wDOSO2e6JvS+wxKnNv4oBr3hmBIkacBN8FKgLIt6vNe4u0Tbc65xXch8gSxfBn1eU/mC1A9Xna09JPAcNhb3prXvzMy9QIij1rKDwFdQAtwLJKoE3/Zb0likzqxercDyxQGnJHaLqrqWLv+e4xqsD6DeYBu/jR/0gj30lB13wjuTBKnBlCJO85fiD7maG0P1dOXW1tRFWJ91lr/DyHI/ljZ4bjud8bheJIwNQA66/laR51xtxqstnHRUjlzMyIdzZWzcEF7gFsQ2VT3y18kCVMDCGZijttXqzLqVKb28Nbk9Wn1Mdpp53dOfhXiVZHvvZMmSg0QLT6zHySY+6nc70TmK6cSvOtUamvZq60zFSralsXxDAbC3qWfNhMlbGl/sW75lFSCVxQGEhQCrAFd40zVJqnU9in6mREdC018VCJJ3D2aojptI2veyF5Tz22tjSlcm9tMDkS5O+wrjzbTpW+jI8EGZ1GtR2LpUxhfOHvNMYZZXXkuUj8hFW0XZEcsisDZhbFmhdbPeT/YCNNXQOTjCy6XzMtSBgS+5iGp2WhTAzT88mGEAwtjyx5FP7HVpjcywCBbgMa8HGXGpO79FymbCRq+dwjVDVy6ECcjKX1gK24aACDqa3vTqNyGcDC/LztEeRFf6rZ6qwAAsXAVyCDKq4BVk8nB2VBlZ5aC9E58MatQ3fJvnuEEdtLv/ZylxnoFIomHgF8yu7LnSNiY3p61yDoAftsJE5t1wO9ZJ7EgFuERNrZPZi20DwA0+ksHIie6Ffgw60RpqMhQ6Jf35anN/UW3VGvdkXKfiK5ESTzyWTAc+d4mRDRPcaYVuJDGg6UxgaMo3XnHAIYj8TbnNQ95VmCvtjpBrV9hmyhdOedVRZ6J/dL2+ZiHlAAtI8FNGHFVY0+FK1SlQ+AOYCUwn5PWhKCbw962j+YxxnkS+0CjtfGjW295SpGtKKUF2P5PK/JcPF163vZP04bmvnYHVxqHjcDDApkP6QrjqL4ct4av88Blp/KYTCPbi61O3ehgVhDrCgydxLockXZgKXAKZRLDBKrfouZgZMwo/pIjC226oKCgoKCg4L/CH/2pQ2x506tNAAAAAElFTkSuQmCC"
											alt=""></a>
									</div>
									<p class="m-1" style="font-size: 20px">${MemberList[i].member.krName}</p>
								</div>
							</div>
						</c:forEach>
					</div>

				</div>
				<div class="card">
					<div class="card-header" id="headingTwo">
						<h2 class="mb-0">
							<button type="button" class="btn btn-link collapsed"
								data-toggle="collapse" data-target="#gen1">
								<i class="fa fa-plus"></i> 1th Generation
							</button>
						</h2>
					</div>
					<div id="gen1" class="collapse" aria-labelledby="headingTwo"
						data-parent="#accordionExample">
						<c:forEach var="i" begin="5" end="9">
							<div class="d-flex flex-row border">
								<div class="order-1 p-1">
									<a
										href="https://www.youtube.com/channel/${MemberList[i].member.channelId}"
										target="_blank"> <img
										style="width: 80px; height: 80px; border-radius: 70px;"
										class="card-img-top" src="${MemberList[i].member.profileUrl}">
									</a>
								</div>
								<div class="order-2 p-1">
									<div
										class="btn-group float-right d-flex justify-content-between"
										role="group" aria-label="Basic example">
										<c:choose>
											<c:when
												test="${fn:contains(sessionScope.favorite,MemberList[i].member.krName) }">
												<img id="${MemberList[i].member.krName}"
													onclick="damaY('${MemberList[i].member.krName}')"
													src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAADAAAAAwCAYAAABXAvmHAAAABmJLR0QA/wD/AP+gvaeTAAAEoElEQVRoge2Z3W8UZRTGf2eWtlBEgtJu+dIQGhED8iEsCbAbqiYSolxqIglcGk0oiNyZGLjwjiuIfwAYb42JIaBeEGMw8YOYFjEkRAhSoFAt0m7blLLv48XutjPb2e7OMqOJ6bnYd949857nOXOeOfPOLszarM1aYqbLHRn92rElSQxLKrB60u2k7DoABa209XfvJYHjJRG0GNneA1oRraXjRCyRCuhqZwvj+RtI6eIXDJBveta29Y3FjZVMBcZH9vnIA7Qxf2JvElCxJyBhyB1ClMgLJEBHpPgrHn8FLnXsQrwAFImXE5FW09v2WtxwCUhIh4uDStPShwDH+3GjxVpS9aTXgnon4/rJQykpb4NtutcTF2a8FZA+AKwkGaaTB1Q4GCdkbBVQT7oddAMxN0AcKuU0jmylbf7zThy48VVA7sA08lLYvdACvBsXbCwV0PfL59E6/geweLpkJj/8iQ3S3PSMrb878rjYkROQMH5rS1PQMpRaClqO2I6013/SFOFqcrLPwF0A+nDuNl7zLbYM3DULnB09AV1qX0UqtQyxAqclYMtRYRnYUmAFUgfQFEpQPuwIPk35JhD9wE2k20K3PNSHszuYu4lL9Vn2wbWqCejy0mPIfRQA8Q01ZNGQT6o4N7RzTflMOmrZ/LHyN3P8CSB3DRDCgqX3B62YhxGs06fo6wTedT/lQBeytf2nkO0HTQQ7SRXy4V2mpk9SdfLV1xVMvGPZodMBzoSYetOvAp8jLQgE8g3/lmRKMUZN3puWGzpTybVqF9IvHVvw3BlE238oGYBBE3ssN3whjOeMbVSX2ldR0DlEZwAkDKi+LhNpHeKGFdhlXcNXqnGs+RzQj20dNHEWaUMAxDfUL5mZ1k1L7LIVCrusa6xvJn41txKWGeinmSzYN4ErVI28zxcqmarrAuS/tfGm7bXIQ4Qnsa52tjD09ymktwIEKgn6iYf46pDhFzYn/7Zto67350hbCQnj4uLjyB0OEPAPjUsGGZ94O/LdZrh6OTW0mdNPi04gOxBTlymSh5OpXL47Kpc5tU8JMZGPUTJlG26ESmMJYFvL4I8jGb/P0NZGmER+oZHwkDYXjxvuMmG+jI5G5xP9jeyHp56X9GQDe5kpn0J9C+h6YnXyCchlJslVfXGvQr7sK88rfU6ZqHQiJ+A8ZWKRTHnuO3blixPBIt/E5iwTucvUcRODMEeyFdB55oLWhUtmmpwGDbrN0Q0MVq8IU9UyXixiJJQALQs2IZqnk/DJSTiJTy3FGsvlT9rO/EnzUp2CE4hHNeTUTGHexuQSIJWZscug84bbmMoN77Pt+cl/ZCz74H5q58hBw1sHnA2XWmnuot0HkRJwlR1oUhZ203D7vWz+ZcuN9FZbb13DV7yu0d0m9iB+nyLPZDJOllwCBpmKqzciZ8fs0dBzlh05PeNif5xXRr+0hWNrTO4QMOSXk1m0Vlr/dvq7hYtk+gtkCCc45anwoeVGH+s3Tp1rXeJSjz422X7AQ8gmxp+217lfz/r6E/gqPV+toxeBfjPviO148HOjpEPjf920WfKOg9L28OFL9gajccaftVn7v9o/fzB7l3fCLDkAAAAASUVORK5CYII="
													style="width: 30px; height: 30px; float: sticky; margin-top: 25px;">
											</c:when>
											<c:otherwise>
												<img id="${MemberList[i].member.krName}"
													onclick="damaY('${MemberList[i].member.krName}')"
													src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAADAAAAAwCAYAAABXAvmHAAAABmJLR0QA/wD/AP+gvaeTAAAFWElEQVRoge2YS4xTZRTHf6ftEGAGBMZHSDDBzHTaTpGMA23HSCAkJi7EhQTZmBAXCAswLkwEJCIuSIaNCzUkggsTDZOIO/AJBlEe007BkVimnbYBowkmBiVmRnm033ExpfTedmZ6O7cbM2d17znf+Z//+c79HufCrMzKrDRNNBFcp4ngumbG8DUTHNgHqsCZZgWQZgFrPPgkwvmJF89aiV35oRlxPM0ALSHvLz+L2dusME2pgCa7YxgzaI2kaySSOed2rOZUoFjcV62UPc0I5XoFNBnqxWiyNraJSnR0yM147lfA6FtMNjHqdX0tuFoBTYR7oHhpClzFEJG+9EW3YrpcgeKbWMmfAb6veBc8uLoWXKuAJrrDYC5jmRTP04gKqicrh2K0R/oyl92I62IFdJ8N74JEr3wrkZFTqJyt0Ase3nArqisJ6AV/CHSTVcnb5WcxB6we8oIOhVa4EdvxJ6TxYDsqfrz4UbpAO4EY8FgFbEKiIzGLXyIUB41WqK4CcZAcwihFsohmJZa+MeME9MeeRdz9x496OhH8QBeIv0R2yfRZ8pzE0icsqnhwA8LxOjj9CZIDzQKjKFnE5GiZn5Unhm9OmYDGgwcQXgYeqiPQZOyHiWR6RVCLVhGGApdAehrH5g+UIxJLl88T6xrwth4AhmcQ4DrCfjt5ABEUYT9wfQb4wyWO93HtI/T08rm0zf0M5dkaAEXgV9A8SB6VPKI51ORpa8lLODVWDwtNhdsYu9uBeDpQ6US0A7QDpAN4FPBWOQmfM3Zrk6y/dmvKBEoB5jBeHAA22kD+Qs0zbt9nynEnTvKTwIM20wkWFzaJP3fb7lNzG5Vw6g7X0ptBPrFGYDHIN5rsjtXym4loMtQLxVNUkZdP8bRurEUepjgHZDNFro28BHxksyzCmK91MNQ3U9L3RAeDqzB6Emi3Ghhg/JEXZfXFu5PynBZcEYaC7wE7bKZxhA0SSX/XCOky/lDgKVS+ABbaLB8SyWwXwUzlP+1JLIISSb8CeshmasVwXBOhtU5JlykmQmsx8hXV5A8RyWybjjzUeZWYSCKzE+Edq4E20C91MLC+ftolismuNaAnJjAslkNEMjtrbcW1pO67kAgqkfRrQL/NNB+PvF4vTlmMZy+wwKbtl2hmR73koYHLnETTe1AGrEr9ySlOlY8yING0416h0dtoi+XNiPMEqn1aao6bRhpLQHjc8u7lZ8cYqikbZkPXa8cJ6Onlc4HOClWBBwqjNcfGg10aD3bVBGovZoBChcZfwnYkzivQ2hqk8q4ikrWfkjrYuUwTgSMIKYSUJgJHdLBzWeUY8eduI5KtUHlL2I7EeQJirJ+Puf8p6PnwEh0K9OPxjYJsZeLnsQ9kKx5fXhPBD/Rcx8NlX9UrVvCC48+ogTVgwjZFSpOr5ms8tAtfIY/KLmBeDcc5wDZ8LXkdCvTr2cACwLoOEDv2tNLA73WxzpKwEjOeQ1haV4cqtKGyizlsAWz/T22bQx3iPAHDChvP5ycZeQPRgwClqrTb7EurfI3znchRU6+DnQvx+G5O4zeO6Pv45vXf62EnGhizA9E9wANThcAUFklf7u96OTlbAx7fCiYnfwc4DN5OiWR2VzbgEk6NSWzkIEpHqSr/ToIhiM/ROnCWQO3D5i6qH6MalGh6u0RTv0/qHkvfkEhmN6bQBbwLVDcpDg80ZwkolbNjEDmGkbDEMlsklrlaL4z05X6TaPpVfBIADjPRa9+zNrEClGfnFOJZLZGRzdI3kp3SYwqR3pFfJJrejvGuROQYoGBc+WNXUzQePNqMfriMn+yOaTx4tFn4szIr/0f5D1yB0iClsG6VAAAAAElFTkSuQmCC"
													style="width: 30px; height: 30px; float: sticky; margin-top: 25px;">
											</c:otherwise>
										</c:choose>
										<a
											href="https://www.youtube.com/channel/${MemberList[i].member.channelId}"
											target="_blank"> <img
											style="width =: 30px; height: 30px; margin-left: 10px; margin-top: 25px;"
											src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAADAAAAAwCAYAAABXAvmHAAAABmJLR0QA/wD/AP+gvaeTAAAEZ0lEQVRoge3Y32tbZRzH8fdz0nZNujZt58Sta2WTiQiCF/5gCDo2nAgiwxtlAxGd/8OYQ+cYbojOCxWc80aQ3QiCgsPRjVbETZx6oV4IbnOUbh3WtsmapmmT8/14kZPY7LQuOUm1sHxvknPOk/O8Puf7HE4SaFazmtWsZt3K5aoZNP70i53tbq7foX4n6wP6Dfow9QLdSN0S3aBORCsSoITEKiQEs07KSQA2h9w0kEKWkkg5NC5pDGPE4Y/mfV3JWedI/7lPZyMFSD+1a3PM0x6c2wFsBJIARRhIAgEIpGB3sK+ID16K4yvHLLZvic+hCUkX8fWVtfDB2m9Ojd00QGbnrhcQ7wOJigP/NV4K5iqPmTSz59d+f/rLJQNkdu7ejnQKiK0wPCqeY8bz2NJ77vQvJZpX6dShFYwH0eEXbP+iHcg+s3uD+Rqp6MrKwpeO5zKrrWfj8HCuogPm655o+OD8EnkZBbPlxANq77xuG0vMcgDn2BTtyhePZf0CuQfuJ3vfvWT8PGa2HPjitsXuLlFbFpg3Rbnypfdzvs+dr+/DtbaSPnWGqfeOkcjM0ua8xuIlfNi8eAdqwlcuEZNwra0AJJ/YzoaPj5Hf8mDQDTUMH2yHA2C2Piq+PGZBtfT20PfGq3S9tpd0YhVz8huDFzjUHwogud668KoMUKqubY/S/8lx8lseIlPIY+VzR8MjgbE2HAB1Nxq/sBsbjhwgeXAf6UScnPnR8Qjh3xYKgOioC3+TEABd2x9j4MRH+I88TKZQwGS14yUwtzocALXVg6/CDwTdePMgyUP7SXckyJvVhi/O3R4OILXVh68yQVDJx7cycOI42UQC1YIvHgsHqBtfm39B1YwHlA8FAM3Xha92DQWVHhxi5LmXiE/P4GrBF7dTpfOUn8SIeYLWRMNXF6AwMcnY4aPY0Ld0eg7PURu+OP9iATQDdEXFV9OA9OAQ44ffITGdIe5VfsWoAY+k6+EAMCVpXWT8vwQoTEwxdvhtbPgsSc/hcPXgQZoKBZBssoyoGb+0Pj04zPiRoySmZ0h4Xu03bBi/xBIyXcW56PgbMpSv+tdnSXoeHq5BeHDiWiiAw/tDiv5jBAnN53FtraRODjLx1rvEZ2ZIeLF/AA3AI+E7XQwFMOdfwkprsza8JOKeY3TvAZSbRz/8RJfn8PAajhfCK3BpkSUUuwR+JDwS7S5G4ex5QLR4XiWogXgkTK7cgfKDzC/ot2C2mvHFdSlaXHBFlhGPyGVjqcuhAGuGPxsFvouCv2GC5cTjTJ9vvnBhLhSgSNYrEoWVikfKOK9waKG5IkDPmS+GEHswsisOb5rwsWfvuPjzrwvNi/65m9r25F1m3suY24FsE5D8n/CTGL87OBkz78PbL5+/dqO1qr/X/9y6dXXMjw9gfp98r885DUi2DrQG0YMpKVM3TnFERwBqR8QDfFbSXHCzZ3xp1kkpnEs7s5Rhf2EaQ27EoVHDrpBhZP3VH7PV+JrVrGY1q1m3bv0NDRMeqgk0OuwAAAAASUVORK5CYII="
											alt=""></a> <a
											href="https://twitter.com/${MemberList[i].member.twitterId}"
											target="_blank"> <img
											style="width =: 30px; height: 30px; margin-left: 10px; margin-top: 25px;"
											src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAADAAAAAwCAYAAABXAvmHAAAABmJLR0QA/wD/AP+gvaeTAAADz0lEQVRoge2XTWgdVRiGn+/MpGnv3LRoqC4UhCz8I8RFRClSXdgqWkuV4CRpi1gqglZTuhFXkiDdCVIKBfEHo1Bzr0JRtGAqWhTBQhsaFX9ADbZisbXaJnPb5t6Z+VyotU0yc89MYlGYZzcz73fO+84ZzjcHCgoKCgoK/sfIJZ2tOnmdq+ZxYLXCNUCowvdG9b3QNbvo8Y7NLFm0O+iqry9/njRk0wDOSO2e6JvS+wxKnNv4oBr3hmBIkacBN8FKgLIt6vNe4u0Tbc65xXch8gSxfBn1eU/mC1A9Xna09JPAcNhb3prXvzMy9QIij1rKDwFdQAtwLJKoE3/Zb0likzqxercDyxQGnJHaLqrqWLv+e4xqsD6DeYBu/jR/0gj30lB13wjuTBKnBlCJO85fiD7maG0P1dOXW1tRFWJ91lr/DyHI/ljZ4bjud8bheJIwNQA66/laR51xtxqstnHRUjlzMyIdzZWzcEF7gFsQ2VT3y18kCVMDCGZijttXqzLqVKb28Nbk9Wn1Mdpp53dOfhXiVZHvvZMmSg0QLT6zHySY+6nc70TmK6cSvOtUamvZq60zFSralsXxDAbC3qWfNhMlbGl/sW75lFSCVxQGEhQCrAFd40zVJqnU9in6mREdC018VCJJ3D2aojptI2veyF5Tz22tjSlcm9tMDkS5O+wrjzbTpW+jI8EGZ1GtR2LpUxhfOHvNMYZZXXkuUj8hFW0XZEcsisDZhbFmhdbPeT/YCNNXQOTjCy6XzMtSBgS+5iGp2WhTAzT88mGEAwtjyx5FP7HVpjcywCBbgMa8HGXGpO79FymbCRq+dwjVDVy6ECcjKX1gK24aACDqa3vTqNyGcDC/LztEeRFf6rZ6qwAAsXAVyCDKq4BVk8nB2VBlZ5aC9E58MatQ3fJvnuEEdtLv/ZylxnoFIomHgF8yu7LnSNiY3p61yDoAftsJE5t1wO9ZJ7EgFuERNrZPZi20DwA0+ksHIie6Ffgw60RpqMhQ6Jf35anN/UW3VGvdkXKfiK5ESTzyWTAc+d4mRDRPcaYVuJDGg6UxgaMo3XnHAIYj8TbnNQ95VmCvtjpBrV9hmyhdOedVRZ6J/dL2+ZiHlAAtI8FNGHFVY0+FK1SlQ+AOYCUwn5PWhKCbw962j+YxxnkS+0CjtfGjW295SpGtKKUF2P5PK/JcPF163vZP04bmvnYHVxqHjcDDApkP6QrjqL4ct4av88Blp/KYTCPbi61O3ehgVhDrCgydxLockXZgKXAKZRLDBKrfouZgZMwo/pIjC226oKCgoKCg4L/CH/2pQ2x506tNAAAAAElFTkSuQmCC"
											alt=""></a>
									</div>
									<p class="m-1" style="font-size: 20px">${MemberList[i].member.krName}</p>
								</div>
							</div>
						</c:forEach>
					</div>
				</div>
				<div class="card">
					<div class="card-header" id="headingThree">
						<h2 class="mb-0">
							<button type="button" class="btn btn-link collapsed"
								data-toggle="collapse" data-target="#gen2">
								<i class="fa fa-plus"></i> 2st Generation
							</button>
						</h2>
					</div>
					<div id="gen2" class="collapse" aria-labelledby="headingThree"
						data-parent="#accordionExample">
						<c:forEach var="i" begin="10" end="14">
							<div class="d-flex flex-row border">
								<div class="order-1 p-1">
									<a
										href="https://www.youtube.com/channel/${MemberList[i].member.channelId}"
										target="_blank"> <img
										style="width: 80px; height: 80px; border-radius: 70px;"
										class="card-img-top" src="${MemberList[i].member.profileUrl}">
									</a>
								</div>
								<div class="order-2 p-1">
									<div
										class="btn-group float-right d-flex justify-content-between"
										role="group" aria-label="Basic example">
										<c:choose>
											<c:when
												test="${fn:contains(sessionScope.favorite,MemberList[i].member.krName) }">
												<img id="${MemberList[i].member.krName}"
													onclick="damaY('${MemberList[i].member.krName}')"
													src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAADAAAAAwCAYAAABXAvmHAAAABmJLR0QA/wD/AP+gvaeTAAAEoElEQVRoge2Z3W8UZRTGf2eWtlBEgtJu+dIQGhED8iEsCbAbqiYSolxqIglcGk0oiNyZGLjwjiuIfwAYb42JIaBeEGMw8YOYFjEkRAhSoFAt0m7blLLv48XutjPb2e7OMqOJ6bnYd949857nOXOeOfPOLszarM1aYqbLHRn92rElSQxLKrB60u2k7DoABa209XfvJYHjJRG0GNneA1oRraXjRCyRCuhqZwvj+RtI6eIXDJBveta29Y3FjZVMBcZH9vnIA7Qxf2JvElCxJyBhyB1ClMgLJEBHpPgrHn8FLnXsQrwAFImXE5FW09v2WtxwCUhIh4uDStPShwDH+3GjxVpS9aTXgnon4/rJQykpb4NtutcTF2a8FZA+AKwkGaaTB1Q4GCdkbBVQT7oddAMxN0AcKuU0jmylbf7zThy48VVA7sA08lLYvdACvBsXbCwV0PfL59E6/geweLpkJj/8iQ3S3PSMrb878rjYkROQMH5rS1PQMpRaClqO2I6013/SFOFqcrLPwF0A+nDuNl7zLbYM3DULnB09AV1qX0UqtQyxAqclYMtRYRnYUmAFUgfQFEpQPuwIPk35JhD9wE2k20K3PNSHszuYu4lL9Vn2wbWqCejy0mPIfRQA8Q01ZNGQT6o4N7RzTflMOmrZ/LHyN3P8CSB3DRDCgqX3B62YhxGs06fo6wTedT/lQBeytf2nkO0HTQQ7SRXy4V2mpk9SdfLV1xVMvGPZodMBzoSYetOvAp8jLQgE8g3/lmRKMUZN3puWGzpTybVqF9IvHVvw3BlE238oGYBBE3ssN3whjOeMbVSX2ldR0DlEZwAkDKi+LhNpHeKGFdhlXcNXqnGs+RzQj20dNHEWaUMAxDfUL5mZ1k1L7LIVCrusa6xvJn41txKWGeinmSzYN4ErVI28zxcqmarrAuS/tfGm7bXIQ4Qnsa52tjD09ymktwIEKgn6iYf46pDhFzYn/7Zto67350hbCQnj4uLjyB0OEPAPjUsGGZ94O/LdZrh6OTW0mdNPi04gOxBTlymSh5OpXL47Kpc5tU8JMZGPUTJlG26ESmMJYFvL4I8jGb/P0NZGmER+oZHwkDYXjxvuMmG+jI5G5xP9jeyHp56X9GQDe5kpn0J9C+h6YnXyCchlJslVfXGvQr7sK88rfU6ZqHQiJ+A8ZWKRTHnuO3blixPBIt/E5iwTucvUcRODMEeyFdB55oLWhUtmmpwGDbrN0Q0MVq8IU9UyXixiJJQALQs2IZqnk/DJSTiJTy3FGsvlT9rO/EnzUp2CE4hHNeTUTGHexuQSIJWZscug84bbmMoN77Pt+cl/ZCz74H5q58hBw1sHnA2XWmnuot0HkRJwlR1oUhZ203D7vWz+ZcuN9FZbb13DV7yu0d0m9iB+nyLPZDJOllwCBpmKqzciZ8fs0dBzlh05PeNif5xXRr+0hWNrTO4QMOSXk1m0Vlr/dvq7hYtk+gtkCCc45anwoeVGH+s3Tp1rXeJSjz422X7AQ8gmxp+217lfz/r6E/gqPV+toxeBfjPviO148HOjpEPjf920WfKOg9L28OFL9gajccaftVn7v9o/fzB7l3fCLDkAAAAASUVORK5CYII="
													style="width: 30px; height: 30px; float: sticky; margin-top: 25px;">
											</c:when>
											<c:otherwise>
												<img id="${MemberList[i].member.krName}"
													onclick="damaY('${MemberList[i].member.krName}')"
													src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAADAAAAAwCAYAAABXAvmHAAAABmJLR0QA/wD/AP+gvaeTAAAFWElEQVRoge2YS4xTZRTHf6ftEGAGBMZHSDDBzHTaTpGMA23HSCAkJi7EhQTZmBAXCAswLkwEJCIuSIaNCzUkggsTDZOIO/AJBlEe007BkVimnbYBowkmBiVmRnm033ExpfTedmZ6O7cbM2d17znf+Z//+c79HufCrMzKrDRNNBFcp4ngumbG8DUTHNgHqsCZZgWQZgFrPPgkwvmJF89aiV35oRlxPM0ALSHvLz+L2dusME2pgCa7YxgzaI2kaySSOed2rOZUoFjcV62UPc0I5XoFNBnqxWiyNraJSnR0yM147lfA6FtMNjHqdX0tuFoBTYR7oHhpClzFEJG+9EW3YrpcgeKbWMmfAb6veBc8uLoWXKuAJrrDYC5jmRTP04gKqicrh2K0R/oyl92I62IFdJ8N74JEr3wrkZFTqJyt0Ase3nArqisJ6AV/CHSTVcnb5WcxB6we8oIOhVa4EdvxJ6TxYDsqfrz4UbpAO4EY8FgFbEKiIzGLXyIUB41WqK4CcZAcwihFsohmJZa+MeME9MeeRdz9x496OhH8QBeIv0R2yfRZ8pzE0icsqnhwA8LxOjj9CZIDzQKjKFnE5GiZn5Unhm9OmYDGgwcQXgYeqiPQZOyHiWR6RVCLVhGGApdAehrH5g+UIxJLl88T6xrwth4AhmcQ4DrCfjt5ABEUYT9wfQb4wyWO93HtI/T08rm0zf0M5dkaAEXgV9A8SB6VPKI51ORpa8lLODVWDwtNhdsYu9uBeDpQ6US0A7QDpAN4FPBWOQmfM3Zrk6y/dmvKBEoB5jBeHAA22kD+Qs0zbt9nynEnTvKTwIM20wkWFzaJP3fb7lNzG5Vw6g7X0ptBPrFGYDHIN5rsjtXym4loMtQLxVNUkZdP8bRurEUepjgHZDNFro28BHxksyzCmK91MNQ3U9L3RAeDqzB6Emi3Ghhg/JEXZfXFu5PynBZcEYaC7wE7bKZxhA0SSX/XCOky/lDgKVS+ABbaLB8SyWwXwUzlP+1JLIISSb8CeshmasVwXBOhtU5JlykmQmsx8hXV5A8RyWybjjzUeZWYSCKzE+Edq4E20C91MLC+ftolismuNaAnJjAslkNEMjtrbcW1pO67kAgqkfRrQL/NNB+PvF4vTlmMZy+wwKbtl2hmR73koYHLnETTe1AGrEr9ySlOlY8yING0416h0dtoi+XNiPMEqn1aao6bRhpLQHjc8u7lZ8cYqikbZkPXa8cJ6Onlc4HOClWBBwqjNcfGg10aD3bVBGovZoBChcZfwnYkzivQ2hqk8q4ikrWfkjrYuUwTgSMIKYSUJgJHdLBzWeUY8eduI5KtUHlL2I7EeQJirJ+Puf8p6PnwEh0K9OPxjYJsZeLnsQ9kKx5fXhPBD/Rcx8NlX9UrVvCC48+ogTVgwjZFSpOr5ms8tAtfIY/KLmBeDcc5wDZ8LXkdCvTr2cACwLoOEDv2tNLA73WxzpKwEjOeQ1haV4cqtKGyizlsAWz/T22bQx3iPAHDChvP5ycZeQPRgwClqrTb7EurfI3znchRU6+DnQvx+G5O4zeO6Pv45vXf62EnGhizA9E9wANThcAUFklf7u96OTlbAx7fCiYnfwc4DN5OiWR2VzbgEk6NSWzkIEpHqSr/ToIhiM/ROnCWQO3D5i6qH6MalGh6u0RTv0/qHkvfkEhmN6bQBbwLVDcpDg80ZwkolbNjEDmGkbDEMlsklrlaL4z05X6TaPpVfBIADjPRa9+zNrEClGfnFOJZLZGRzdI3kp3SYwqR3pFfJJrejvGuROQYoGBc+WNXUzQePNqMfriMn+yOaTx4tFn4szIr/0f5D1yB0iClsG6VAAAAAElFTkSuQmCC"
													style="width: 30px; height: 30px; float: sticky; margin-top: 25px;">
											</c:otherwise>
										</c:choose>
										<a
											href="https://www.youtube.com/channel/${MemberList[i].member.channelId}"
											target="_blank"> <img
											style="width =: 30px; height: 30px; margin-left: 10px; margin-top: 25px;"
											src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAADAAAAAwCAYAAABXAvmHAAAABmJLR0QA/wD/AP+gvaeTAAAEZ0lEQVRoge3Y32tbZRzH8fdz0nZNujZt58Sta2WTiQiCF/5gCDo2nAgiwxtlAxGd/8OYQ+cYbojOCxWc80aQ3QiCgsPRjVbETZx6oV4IbnOUbh3WtsmapmmT8/14kZPY7LQuOUm1sHxvknPOk/O8Puf7HE4SaFazmtWsZt3K5aoZNP70i53tbq7foX4n6wP6Dfow9QLdSN0S3aBORCsSoITEKiQEs07KSQA2h9w0kEKWkkg5NC5pDGPE4Y/mfV3JWedI/7lPZyMFSD+1a3PM0x6c2wFsBJIARRhIAgEIpGB3sK+ID16K4yvHLLZvic+hCUkX8fWVtfDB2m9Ojd00QGbnrhcQ7wOJigP/NV4K5iqPmTSz59d+f/rLJQNkdu7ejnQKiK0wPCqeY8bz2NJ77vQvJZpX6dShFYwH0eEXbP+iHcg+s3uD+Rqp6MrKwpeO5zKrrWfj8HCuogPm655o+OD8EnkZBbPlxANq77xuG0vMcgDn2BTtyhePZf0CuQfuJ3vfvWT8PGa2HPjitsXuLlFbFpg3Rbnypfdzvs+dr+/DtbaSPnWGqfeOkcjM0ua8xuIlfNi8eAdqwlcuEZNwra0AJJ/YzoaPj5Hf8mDQDTUMH2yHA2C2Piq+PGZBtfT20PfGq3S9tpd0YhVz8huDFzjUHwogud668KoMUKqubY/S/8lx8lseIlPIY+VzR8MjgbE2HAB1Nxq/sBsbjhwgeXAf6UScnPnR8Qjh3xYKgOioC3+TEABd2x9j4MRH+I88TKZQwGS14yUwtzocALXVg6/CDwTdePMgyUP7SXckyJvVhi/O3R4OILXVh68yQVDJx7cycOI42UQC1YIvHgsHqBtfm39B1YwHlA8FAM3Xha92DQWVHhxi5LmXiE/P4GrBF7dTpfOUn8SIeYLWRMNXF6AwMcnY4aPY0Ld0eg7PURu+OP9iATQDdEXFV9OA9OAQ44ffITGdIe5VfsWoAY+k6+EAMCVpXWT8vwQoTEwxdvhtbPgsSc/hcPXgQZoKBZBssoyoGb+0Pj04zPiRoySmZ0h4Xu03bBi/xBIyXcW56PgbMpSv+tdnSXoeHq5BeHDiWiiAw/tDiv5jBAnN53FtraRODjLx1rvEZ2ZIeLF/AA3AI+E7XQwFMOdfwkprsza8JOKeY3TvAZSbRz/8RJfn8PAajhfCK3BpkSUUuwR+JDwS7S5G4ex5QLR4XiWogXgkTK7cgfKDzC/ot2C2mvHFdSlaXHBFlhGPyGVjqcuhAGuGPxsFvouCv2GC5cTjTJ9vvnBhLhSgSNYrEoWVikfKOK9waKG5IkDPmS+GEHswsisOb5rwsWfvuPjzrwvNi/65m9r25F1m3suY24FsE5D8n/CTGL87OBkz78PbL5+/dqO1qr/X/9y6dXXMjw9gfp98r885DUi2DrQG0YMpKVM3TnFERwBqR8QDfFbSXHCzZ3xp1kkpnEs7s5Rhf2EaQ27EoVHDrpBhZP3VH7PV+JrVrGY1q1m3bv0NDRMeqgk0OuwAAAAASUVORK5CYII="
											alt=""></a> <a
											href="https://twitter.com/${MemberList[i].member.twitterId}"
											target="_blank"> <img
											style="width =: 30px; height: 30px; margin-left: 10px; margin-top: 25px;"
											src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAADAAAAAwCAYAAABXAvmHAAAABmJLR0QA/wD/AP+gvaeTAAADz0lEQVRoge2XTWgdVRiGn+/MpGnv3LRoqC4UhCz8I8RFRClSXdgqWkuV4CRpi1gqglZTuhFXkiDdCVIKBfEHo1Bzr0JRtGAqWhTBQhsaFX9ADbZisbXaJnPb5t6Z+VyotU0yc89MYlGYZzcz73fO+84ZzjcHCgoKCgoK/sfIJZ2tOnmdq+ZxYLXCNUCowvdG9b3QNbvo8Y7NLFm0O+iqry9/njRk0wDOSO2e6JvS+wxKnNv4oBr3hmBIkacBN8FKgLIt6vNe4u0Tbc65xXch8gSxfBn1eU/mC1A9Xna09JPAcNhb3prXvzMy9QIij1rKDwFdQAtwLJKoE3/Zb0likzqxercDyxQGnJHaLqrqWLv+e4xqsD6DeYBu/jR/0gj30lB13wjuTBKnBlCJO85fiD7maG0P1dOXW1tRFWJ91lr/DyHI/ljZ4bjud8bheJIwNQA66/laR51xtxqstnHRUjlzMyIdzZWzcEF7gFsQ2VT3y18kCVMDCGZijttXqzLqVKb28Nbk9Wn1Mdpp53dOfhXiVZHvvZMmSg0QLT6zHySY+6nc70TmK6cSvOtUamvZq60zFSralsXxDAbC3qWfNhMlbGl/sW75lFSCVxQGEhQCrAFd40zVJqnU9in6mREdC018VCJJ3D2aojptI2veyF5Tz22tjSlcm9tMDkS5O+wrjzbTpW+jI8EGZ1GtR2LpUxhfOHvNMYZZXXkuUj8hFW0XZEcsisDZhbFmhdbPeT/YCNNXQOTjCy6XzMtSBgS+5iGp2WhTAzT88mGEAwtjyx5FP7HVpjcywCBbgMa8HGXGpO79FymbCRq+dwjVDVy6ECcjKX1gK24aACDqa3vTqNyGcDC/LztEeRFf6rZ6qwAAsXAVyCDKq4BVk8nB2VBlZ5aC9E58MatQ3fJvnuEEdtLv/ZylxnoFIomHgF8yu7LnSNiY3p61yDoAftsJE5t1wO9ZJ7EgFuERNrZPZi20DwA0+ksHIie6Ffgw60RpqMhQ6Jf35anN/UW3VGvdkXKfiK5ESTzyWTAc+d4mRDRPcaYVuJDGg6UxgaMo3XnHAIYj8TbnNQ95VmCvtjpBrV9hmyhdOedVRZ6J/dL2+ZiHlAAtI8FNGHFVY0+FK1SlQ+AOYCUwn5PWhKCbw962j+YxxnkS+0CjtfGjW295SpGtKKUF2P5PK/JcPF163vZP04bmvnYHVxqHjcDDApkP6QrjqL4ct4av88Blp/KYTCPbi61O3ehgVhDrCgydxLockXZgKXAKZRLDBKrfouZgZMwo/pIjC226oKCgoKCg4L/CH/2pQ2x506tNAAAAAElFTkSuQmCC"
											alt=""></a>
									</div>
									<p class="m-1" style="font-size: 20px">${MemberList[i].member.krName}</p>
								</div>
							</div>
						</c:forEach>
					</div>
				</div>
				<div class="card">
					<div class="card-header" id="headingThree">
						<h2 class="mb-0">
							<button type="button" class="btn btn-link collapsed"
								data-toggle="collapse" data-target="#gengame">
								<i class="fa fa-plus"></i> Gamers
							</button>
						</h2>
					</div>
					<div id="gengame" class="collapse" aria-labelledby="headingThree"
						data-parent="#accordionExample">
						<c:forEach var="i" begin="15" end="17">
							<div class="d-flex flex-row border">
								<div class="order-1 p-1">
									<a
										href="https://www.youtube.com/channel/${MemberList[i].member.channelId}"
										target="_blank"> <img
										style="width: 80px; height: 80px; border-radius: 70px;"
										class="card-img-top" src="${MemberList[i].member.profileUrl}">
									</a>
								</div>
								<div class="order-2 p-1">
									<div
										class="btn-group float-right d-flex justify-content-between"
										role="group" aria-label="Basic example">
										<c:choose>
											<c:when
												test="${fn:contains(sessionScope.favorite,MemberList[i].member.krName) }">
												<img id="${MemberList[i].member.krName}"
													onclick="damaY('${MemberList[i].member.krName}')"
													src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAADAAAAAwCAYAAABXAvmHAAAABmJLR0QA/wD/AP+gvaeTAAAEoElEQVRoge2Z3W8UZRTGf2eWtlBEgtJu+dIQGhED8iEsCbAbqiYSolxqIglcGk0oiNyZGLjwjiuIfwAYb42JIaBeEGMw8YOYFjEkRAhSoFAt0m7blLLv48XutjPb2e7OMqOJ6bnYd949857nOXOeOfPOLszarM1aYqbLHRn92rElSQxLKrB60u2k7DoABa209XfvJYHjJRG0GNneA1oRraXjRCyRCuhqZwvj+RtI6eIXDJBveta29Y3FjZVMBcZH9vnIA7Qxf2JvElCxJyBhyB1ClMgLJEBHpPgrHn8FLnXsQrwAFImXE5FW09v2WtxwCUhIh4uDStPShwDH+3GjxVpS9aTXgnon4/rJQykpb4NtutcTF2a8FZA+AKwkGaaTB1Q4GCdkbBVQT7oddAMxN0AcKuU0jmylbf7zThy48VVA7sA08lLYvdACvBsXbCwV0PfL59E6/geweLpkJj/8iQ3S3PSMrb878rjYkROQMH5rS1PQMpRaClqO2I6013/SFOFqcrLPwF0A+nDuNl7zLbYM3DULnB09AV1qX0UqtQyxAqclYMtRYRnYUmAFUgfQFEpQPuwIPk35JhD9wE2k20K3PNSHszuYu4lL9Vn2wbWqCejy0mPIfRQA8Q01ZNGQT6o4N7RzTflMOmrZ/LHyN3P8CSB3DRDCgqX3B62YhxGs06fo6wTedT/lQBeytf2nkO0HTQQ7SRXy4V2mpk9SdfLV1xVMvGPZodMBzoSYetOvAp8jLQgE8g3/lmRKMUZN3puWGzpTybVqF9IvHVvw3BlE238oGYBBE3ssN3whjOeMbVSX2ldR0DlEZwAkDKi+LhNpHeKGFdhlXcNXqnGs+RzQj20dNHEWaUMAxDfUL5mZ1k1L7LIVCrusa6xvJn41txKWGeinmSzYN4ErVI28zxcqmarrAuS/tfGm7bXIQ4Qnsa52tjD09ymktwIEKgn6iYf46pDhFzYn/7Zto67350hbCQnj4uLjyB0OEPAPjUsGGZ94O/LdZrh6OTW0mdNPi04gOxBTlymSh5OpXL47Kpc5tU8JMZGPUTJlG26ESmMJYFvL4I8jGb/P0NZGmER+oZHwkDYXjxvuMmG+jI5G5xP9jeyHp56X9GQDe5kpn0J9C+h6YnXyCchlJslVfXGvQr7sK88rfU6ZqHQiJ+A8ZWKRTHnuO3blixPBIt/E5iwTucvUcRODMEeyFdB55oLWhUtmmpwGDbrN0Q0MVq8IU9UyXixiJJQALQs2IZqnk/DJSTiJTy3FGsvlT9rO/EnzUp2CE4hHNeTUTGHexuQSIJWZscug84bbmMoN77Pt+cl/ZCz74H5q58hBw1sHnA2XWmnuot0HkRJwlR1oUhZ203D7vWz+ZcuN9FZbb13DV7yu0d0m9iB+nyLPZDJOllwCBpmKqzciZ8fs0dBzlh05PeNif5xXRr+0hWNrTO4QMOSXk1m0Vlr/dvq7hYtk+gtkCCc45anwoeVGH+s3Tp1rXeJSjz422X7AQ8gmxp+217lfz/r6E/gqPV+toxeBfjPviO148HOjpEPjf920WfKOg9L28OFL9gajccaftVn7v9o/fzB7l3fCLDkAAAAASUVORK5CYII="
													style="width: 30px; height: 30px; float: sticky; margin-top: 25px;">
											</c:when>
											<c:otherwise>
												<img id="${MemberList[i].member.krName}"
													onclick="damaY('${MemberList[i].member.krName}')"
													src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAADAAAAAwCAYAAABXAvmHAAAABmJLR0QA/wD/AP+gvaeTAAAFWElEQVRoge2YS4xTZRTHf6ftEGAGBMZHSDDBzHTaTpGMA23HSCAkJi7EhQTZmBAXCAswLkwEJCIuSIaNCzUkggsTDZOIO/AJBlEe007BkVimnbYBowkmBiVmRnm033ExpfTedmZ6O7cbM2d17znf+Z//+c79HufCrMzKrDRNNBFcp4ngumbG8DUTHNgHqsCZZgWQZgFrPPgkwvmJF89aiV35oRlxPM0ALSHvLz+L2dusME2pgCa7YxgzaI2kaySSOed2rOZUoFjcV62UPc0I5XoFNBnqxWiyNraJSnR0yM147lfA6FtMNjHqdX0tuFoBTYR7oHhpClzFEJG+9EW3YrpcgeKbWMmfAb6veBc8uLoWXKuAJrrDYC5jmRTP04gKqicrh2K0R/oyl92I62IFdJ8N74JEr3wrkZFTqJyt0Ase3nArqisJ6AV/CHSTVcnb5WcxB6we8oIOhVa4EdvxJ6TxYDsqfrz4UbpAO4EY8FgFbEKiIzGLXyIUB41WqK4CcZAcwihFsohmJZa+MeME9MeeRdz9x496OhH8QBeIv0R2yfRZ8pzE0icsqnhwA8LxOjj9CZIDzQKjKFnE5GiZn5Unhm9OmYDGgwcQXgYeqiPQZOyHiWR6RVCLVhGGApdAehrH5g+UIxJLl88T6xrwth4AhmcQ4DrCfjt5ABEUYT9wfQb4wyWO93HtI/T08rm0zf0M5dkaAEXgV9A8SB6VPKI51ORpa8lLODVWDwtNhdsYu9uBeDpQ6US0A7QDpAN4FPBWOQmfM3Zrk6y/dmvKBEoB5jBeHAA22kD+Qs0zbt9nynEnTvKTwIM20wkWFzaJP3fb7lNzG5Vw6g7X0ptBPrFGYDHIN5rsjtXym4loMtQLxVNUkZdP8bRurEUepjgHZDNFro28BHxksyzCmK91MNQ3U9L3RAeDqzB6Emi3Ghhg/JEXZfXFu5PynBZcEYaC7wE7bKZxhA0SSX/XCOky/lDgKVS+ABbaLB8SyWwXwUzlP+1JLIISSb8CeshmasVwXBOhtU5JlykmQmsx8hXV5A8RyWybjjzUeZWYSCKzE+Edq4E20C91MLC+ftolismuNaAnJjAslkNEMjtrbcW1pO67kAgqkfRrQL/NNB+PvF4vTlmMZy+wwKbtl2hmR73koYHLnETTe1AGrEr9ySlOlY8yING0416h0dtoi+XNiPMEqn1aao6bRhpLQHjc8u7lZ8cYqikbZkPXa8cJ6Onlc4HOClWBBwqjNcfGg10aD3bVBGovZoBChcZfwnYkzivQ2hqk8q4ikrWfkjrYuUwTgSMIKYSUJgJHdLBzWeUY8eduI5KtUHlL2I7EeQJirJ+Puf8p6PnwEh0K9OPxjYJsZeLnsQ9kKx5fXhPBD/Rcx8NlX9UrVvCC48+ogTVgwjZFSpOr5ms8tAtfIY/KLmBeDcc5wDZ8LXkdCvTr2cACwLoOEDv2tNLA73WxzpKwEjOeQ1haV4cqtKGyizlsAWz/T22bQx3iPAHDChvP5ycZeQPRgwClqrTb7EurfI3znchRU6+DnQvx+G5O4zeO6Pv45vXf62EnGhizA9E9wANThcAUFklf7u96OTlbAx7fCiYnfwc4DN5OiWR2VzbgEk6NSWzkIEpHqSr/ToIhiM/ROnCWQO3D5i6qH6MalGh6u0RTv0/qHkvfkEhmN6bQBbwLVDcpDg80ZwkolbNjEDmGkbDEMlsklrlaL4z05X6TaPpVfBIADjPRa9+zNrEClGfnFOJZLZGRzdI3kp3SYwqR3pFfJJrejvGuROQYoGBc+WNXUzQePNqMfriMn+yOaTx4tFn4szIr/0f5D1yB0iClsG6VAAAAAElFTkSuQmCC"
													style="width: 30px; height: 30px; float: sticky; margin-top: 25px;">
											</c:otherwise>
										</c:choose>
										<a
											href="https://www.youtube.com/channel/${MemberList[i].member.channelId}"
											target="_blank"> <img
											style="width =: 30px; height: 30px; margin-left: 10px; margin-top: 25px;"
											src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAADAAAAAwCAYAAABXAvmHAAAABmJLR0QA/wD/AP+gvaeTAAAEZ0lEQVRoge3Y32tbZRzH8fdz0nZNujZt58Sta2WTiQiCF/5gCDo2nAgiwxtlAxGd/8OYQ+cYbojOCxWc80aQ3QiCgsPRjVbETZx6oV4IbnOUbh3WtsmapmmT8/14kZPY7LQuOUm1sHxvknPOk/O8Puf7HE4SaFazmtWsZt3K5aoZNP70i53tbq7foX4n6wP6Dfow9QLdSN0S3aBORCsSoITEKiQEs07KSQA2h9w0kEKWkkg5NC5pDGPE4Y/mfV3JWedI/7lPZyMFSD+1a3PM0x6c2wFsBJIARRhIAgEIpGB3sK+ID16K4yvHLLZvic+hCUkX8fWVtfDB2m9Ojd00QGbnrhcQ7wOJigP/NV4K5iqPmTSz59d+f/rLJQNkdu7ejnQKiK0wPCqeY8bz2NJ77vQvJZpX6dShFYwH0eEXbP+iHcg+s3uD+Rqp6MrKwpeO5zKrrWfj8HCuogPm655o+OD8EnkZBbPlxANq77xuG0vMcgDn2BTtyhePZf0CuQfuJ3vfvWT8PGa2HPjitsXuLlFbFpg3Rbnypfdzvs+dr+/DtbaSPnWGqfeOkcjM0ua8xuIlfNi8eAdqwlcuEZNwra0AJJ/YzoaPj5Hf8mDQDTUMH2yHA2C2Piq+PGZBtfT20PfGq3S9tpd0YhVz8huDFzjUHwogud668KoMUKqubY/S/8lx8lseIlPIY+VzR8MjgbE2HAB1Nxq/sBsbjhwgeXAf6UScnPnR8Qjh3xYKgOioC3+TEABd2x9j4MRH+I88TKZQwGS14yUwtzocALXVg6/CDwTdePMgyUP7SXckyJvVhi/O3R4OILXVh68yQVDJx7cycOI42UQC1YIvHgsHqBtfm39B1YwHlA8FAM3Xha92DQWVHhxi5LmXiE/P4GrBF7dTpfOUn8SIeYLWRMNXF6AwMcnY4aPY0Ld0eg7PURu+OP9iATQDdEXFV9OA9OAQ44ffITGdIe5VfsWoAY+k6+EAMCVpXWT8vwQoTEwxdvhtbPgsSc/hcPXgQZoKBZBssoyoGb+0Pj04zPiRoySmZ0h4Xu03bBi/xBIyXcW56PgbMpSv+tdnSXoeHq5BeHDiWiiAw/tDiv5jBAnN53FtraRODjLx1rvEZ2ZIeLF/AA3AI+E7XQwFMOdfwkprsza8JOKeY3TvAZSbRz/8RJfn8PAajhfCK3BpkSUUuwR+JDwS7S5G4ex5QLR4XiWogXgkTK7cgfKDzC/ot2C2mvHFdSlaXHBFlhGPyGVjqcuhAGuGPxsFvouCv2GC5cTjTJ9vvnBhLhSgSNYrEoWVikfKOK9waKG5IkDPmS+GEHswsisOb5rwsWfvuPjzrwvNi/65m9r25F1m3suY24FsE5D8n/CTGL87OBkz78PbL5+/dqO1qr/X/9y6dXXMjw9gfp98r885DUi2DrQG0YMpKVM3TnFERwBqR8QDfFbSXHCzZ3xp1kkpnEs7s5Rhf2EaQ27EoVHDrpBhZP3VH7PV+JrVrGY1q1m3bv0NDRMeqgk0OuwAAAAASUVORK5CYII="
											alt=""></a> <a
											href="https://twitter.com/${MemberList[i].member.twitterId}"
											target="_blank"> <img
											style="width =: 30px; height: 30px; margin-left: 10px; margin-top: 25px;"
											src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAADAAAAAwCAYAAABXAvmHAAAABmJLR0QA/wD/AP+gvaeTAAADz0lEQVRoge2XTWgdVRiGn+/MpGnv3LRoqC4UhCz8I8RFRClSXdgqWkuV4CRpi1gqglZTuhFXkiDdCVIKBfEHo1Bzr0JRtGAqWhTBQhsaFX9ADbZisbXaJnPb5t6Z+VyotU0yc89MYlGYZzcz73fO+84ZzjcHCgoKCgoK/sfIJZ2tOnmdq+ZxYLXCNUCowvdG9b3QNbvo8Y7NLFm0O+iqry9/njRk0wDOSO2e6JvS+wxKnNv4oBr3hmBIkacBN8FKgLIt6vNe4u0Tbc65xXch8gSxfBn1eU/mC1A9Xna09JPAcNhb3prXvzMy9QIij1rKDwFdQAtwLJKoE3/Zb0likzqxercDyxQGnJHaLqrqWLv+e4xqsD6DeYBu/jR/0gj30lB13wjuTBKnBlCJO85fiD7maG0P1dOXW1tRFWJ91lr/DyHI/ljZ4bjud8bheJIwNQA66/laR51xtxqstnHRUjlzMyIdzZWzcEF7gFsQ2VT3y18kCVMDCGZijttXqzLqVKb28Nbk9Wn1Mdpp53dOfhXiVZHvvZMmSg0QLT6zHySY+6nc70TmK6cSvOtUamvZq60zFSralsXxDAbC3qWfNhMlbGl/sW75lFSCVxQGEhQCrAFd40zVJqnU9in6mREdC018VCJJ3D2aojptI2veyF5Tz22tjSlcm9tMDkS5O+wrjzbTpW+jI8EGZ1GtR2LpUxhfOHvNMYZZXXkuUj8hFW0XZEcsisDZhbFmhdbPeT/YCNNXQOTjCy6XzMtSBgS+5iGp2WhTAzT88mGEAwtjyx5FP7HVpjcywCBbgMa8HGXGpO79FymbCRq+dwjVDVy6ECcjKX1gK24aACDqa3vTqNyGcDC/LztEeRFf6rZ6qwAAsXAVyCDKq4BVk8nB2VBlZ5aC9E58MatQ3fJvnuEEdtLv/ZylxnoFIomHgF8yu7LnSNiY3p61yDoAftsJE5t1wO9ZJ7EgFuERNrZPZi20DwA0+ksHIie6Ffgw60RpqMhQ6Jf35anN/UW3VGvdkXKfiK5ESTzyWTAc+d4mRDRPcaYVuJDGg6UxgaMo3XnHAIYj8TbnNQ95VmCvtjpBrV9hmyhdOedVRZ6J/dL2+ZiHlAAtI8FNGHFVY0+FK1SlQ+AOYCUwn5PWhKCbw962j+YxxnkS+0CjtfGjW295SpGtKKUF2P5PK/JcPF163vZP04bmvnYHVxqHjcDDApkP6QrjqL4ct4av88Blp/KYTCPbi61O3ehgVhDrCgydxLockXZgKXAKZRLDBKrfouZgZMwo/pIjC226oKCgoKCg4L/CH/2pQ2x506tNAAAAAElFTkSuQmCC"
											alt=""></a>
									</div>
									<p class="m-1" style="font-size: 20px">${MemberList[i].member.krName}</p>
								</div>
							</div>
						</c:forEach>
					</div>
				</div>
				<div class="card">
					<div class="card-header" id="headingThree">
						<h2 class="mb-0">
							<button type="button" class="btn btn-link collapsed"
								data-toggle="collapse" data-target="#gen3">
								<i class="fa fa-plus"></i> 3st Generation
							</button>
						</h2>
					</div>
					<div id="gen3" class="collapse" aria-labelledby="headingThree"
						data-parent="#accordionExample">
						<c:forEach var="i" begin="18" end="21">
							<div class="d-flex flex-row border">
								<div class="order-1 p-1">
									<a
										href="https://www.youtube.com/channel/${MemberList[i].member.channelId}"
										target="_blank"> <img
										style="width: 80px; height: 80px; border-radius: 70px;"
										class="card-img-top" src="${MemberList[i].member.profileUrl}">
									</a>
								</div>
								<div class="order-2 p-1">
									<div
										class="btn-group float-right d-flex justify-content-between"
										role="group" aria-label="Basic example">
										<c:choose>
											<c:when
												test="${fn:contains(sessionScope.favorite,MemberList[i].member.krName) }">
												<img id="${MemberList[i].member.krName}"
													onclick="damaY('${MemberList[i].member.krName}')"
													src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAADAAAAAwCAYAAABXAvmHAAAABmJLR0QA/wD/AP+gvaeTAAAEoElEQVRoge2Z3W8UZRTGf2eWtlBEgtJu+dIQGhED8iEsCbAbqiYSolxqIglcGk0oiNyZGLjwjiuIfwAYb42JIaBeEGMw8YOYFjEkRAhSoFAt0m7blLLv48XutjPb2e7OMqOJ6bnYd949857nOXOeOfPOLszarM1aYqbLHRn92rElSQxLKrB60u2k7DoABa209XfvJYHjJRG0GNneA1oRraXjRCyRCuhqZwvj+RtI6eIXDJBveta29Y3FjZVMBcZH9vnIA7Qxf2JvElCxJyBhyB1ClMgLJEBHpPgrHn8FLnXsQrwAFImXE5FW09v2WtxwCUhIh4uDStPShwDH+3GjxVpS9aTXgnon4/rJQykpb4NtutcTF2a8FZA+AKwkGaaTB1Q4GCdkbBVQT7oddAMxN0AcKuU0jmylbf7zThy48VVA7sA08lLYvdACvBsXbCwV0PfL59E6/geweLpkJj/8iQ3S3PSMrb878rjYkROQMH5rS1PQMpRaClqO2I6013/SFOFqcrLPwF0A+nDuNl7zLbYM3DULnB09AV1qX0UqtQyxAqclYMtRYRnYUmAFUgfQFEpQPuwIPk35JhD9wE2k20K3PNSHszuYu4lL9Vn2wbWqCejy0mPIfRQA8Q01ZNGQT6o4N7RzTflMOmrZ/LHyN3P8CSB3DRDCgqX3B62YhxGs06fo6wTedT/lQBeytf2nkO0HTQQ7SRXy4V2mpk9SdfLV1xVMvGPZodMBzoSYetOvAp8jLQgE8g3/lmRKMUZN3puWGzpTybVqF9IvHVvw3BlE238oGYBBE3ssN3whjOeMbVSX2ldR0DlEZwAkDKi+LhNpHeKGFdhlXcNXqnGs+RzQj20dNHEWaUMAxDfUL5mZ1k1L7LIVCrusa6xvJn41txKWGeinmSzYN4ErVI28zxcqmarrAuS/tfGm7bXIQ4Qnsa52tjD09ymktwIEKgn6iYf46pDhFzYn/7Zto67350hbCQnj4uLjyB0OEPAPjUsGGZ94O/LdZrh6OTW0mdNPi04gOxBTlymSh5OpXL47Kpc5tU8JMZGPUTJlG26ESmMJYFvL4I8jGb/P0NZGmER+oZHwkDYXjxvuMmG+jI5G5xP9jeyHp56X9GQDe5kpn0J9C+h6YnXyCchlJslVfXGvQr7sK88rfU6ZqHQiJ+A8ZWKRTHnuO3blixPBIt/E5iwTucvUcRODMEeyFdB55oLWhUtmmpwGDbrN0Q0MVq8IU9UyXixiJJQALQs2IZqnk/DJSTiJTy3FGsvlT9rO/EnzUp2CE4hHNeTUTGHexuQSIJWZscug84bbmMoN77Pt+cl/ZCz74H5q58hBw1sHnA2XWmnuot0HkRJwlR1oUhZ203D7vWz+ZcuN9FZbb13DV7yu0d0m9iB+nyLPZDJOllwCBpmKqzciZ8fs0dBzlh05PeNif5xXRr+0hWNrTO4QMOSXk1m0Vlr/dvq7hYtk+gtkCCc45anwoeVGH+s3Tp1rXeJSjz422X7AQ8gmxp+217lfz/r6E/gqPV+toxeBfjPviO148HOjpEPjf920WfKOg9L28OFL9gajccaftVn7v9o/fzB7l3fCLDkAAAAASUVORK5CYII="
													style="width: 30px; height: 30px; float: sticky; margin-top: 25px;">
											</c:when>
											<c:otherwise>
												<img id="${MemberList[i].member.krName}"
													onclick="damaY('${MemberList[i].member.krName}')"
													src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAADAAAAAwCAYAAABXAvmHAAAABmJLR0QA/wD/AP+gvaeTAAAFWElEQVRoge2YS4xTZRTHf6ftEGAGBMZHSDDBzHTaTpGMA23HSCAkJi7EhQTZmBAXCAswLkwEJCIuSIaNCzUkggsTDZOIO/AJBlEe007BkVimnbYBowkmBiVmRnm033ExpfTedmZ6O7cbM2d17znf+Z//+c79HufCrMzKrDRNNBFcp4ngumbG8DUTHNgHqsCZZgWQZgFrPPgkwvmJF89aiV35oRlxPM0ALSHvLz+L2dusME2pgCa7YxgzaI2kaySSOed2rOZUoFjcV62UPc0I5XoFNBnqxWiyNraJSnR0yM147lfA6FtMNjHqdX0tuFoBTYR7oHhpClzFEJG+9EW3YrpcgeKbWMmfAb6veBc8uLoWXKuAJrrDYC5jmRTP04gKqicrh2K0R/oyl92I62IFdJ8N74JEr3wrkZFTqJyt0Ase3nArqisJ6AV/CHSTVcnb5WcxB6we8oIOhVa4EdvxJ6TxYDsqfrz4UbpAO4EY8FgFbEKiIzGLXyIUB41WqK4CcZAcwihFsohmJZa+MeME9MeeRdz9x496OhH8QBeIv0R2yfRZ8pzE0icsqnhwA8LxOjj9CZIDzQKjKFnE5GiZn5Unhm9OmYDGgwcQXgYeqiPQZOyHiWR6RVCLVhGGApdAehrH5g+UIxJLl88T6xrwth4AhmcQ4DrCfjt5ABEUYT9wfQb4wyWO93HtI/T08rm0zf0M5dkaAEXgV9A8SB6VPKI51ORpa8lLODVWDwtNhdsYu9uBeDpQ6US0A7QDpAN4FPBWOQmfM3Zrk6y/dmvKBEoB5jBeHAA22kD+Qs0zbt9nynEnTvKTwIM20wkWFzaJP3fb7lNzG5Vw6g7X0ptBPrFGYDHIN5rsjtXym4loMtQLxVNUkZdP8bRurEUepjgHZDNFro28BHxksyzCmK91MNQ3U9L3RAeDqzB6Emi3Ghhg/JEXZfXFu5PynBZcEYaC7wE7bKZxhA0SSX/XCOky/lDgKVS+ABbaLB8SyWwXwUzlP+1JLIISSb8CeshmasVwXBOhtU5JlykmQmsx8hXV5A8RyWybjjzUeZWYSCKzE+Edq4E20C91MLC+ftolismuNaAnJjAslkNEMjtrbcW1pO67kAgqkfRrQL/NNB+PvF4vTlmMZy+wwKbtl2hmR73koYHLnETTe1AGrEr9ySlOlY8yING0416h0dtoi+XNiPMEqn1aao6bRhpLQHjc8u7lZ8cYqikbZkPXa8cJ6Onlc4HOClWBBwqjNcfGg10aD3bVBGovZoBChcZfwnYkzivQ2hqk8q4ikrWfkjrYuUwTgSMIKYSUJgJHdLBzWeUY8eduI5KtUHlL2I7EeQJirJ+Puf8p6PnwEh0K9OPxjYJsZeLnsQ9kKx5fXhPBD/Rcx8NlX9UrVvCC48+ogTVgwjZFSpOr5ms8tAtfIY/KLmBeDcc5wDZ8LXkdCvTr2cACwLoOEDv2tNLA73WxzpKwEjOeQ1haV4cqtKGyizlsAWz/T22bQx3iPAHDChvP5ycZeQPRgwClqrTb7EurfI3znchRU6+DnQvx+G5O4zeO6Pv45vXf62EnGhizA9E9wANThcAUFklf7u96OTlbAx7fCiYnfwc4DN5OiWR2VzbgEk6NSWzkIEpHqSr/ToIhiM/ROnCWQO3D5i6qH6MalGh6u0RTv0/qHkvfkEhmN6bQBbwLVDcpDg80ZwkolbNjEDmGkbDEMlsklrlaL4z05X6TaPpVfBIADjPRa9+zNrEClGfnFOJZLZGRzdI3kp3SYwqR3pFfJJrejvGuROQYoGBc+WNXUzQePNqMfriMn+yOaTx4tFn4szIr/0f5D1yB0iClsG6VAAAAAElFTkSuQmCC"
													style="width: 30px; height: 30px; float: sticky; margin-top: 25px;">
											</c:otherwise>
										</c:choose>
										<a
											href="https://www.youtube.com/channel/${MemberList[i].member.channelId}"
											target="_blank"> <img
											style="width =: 30px; height: 30px; margin-left: 10px; margin-top: 25px;"
											src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAADAAAAAwCAYAAABXAvmHAAAABmJLR0QA/wD/AP+gvaeTAAAEZ0lEQVRoge3Y32tbZRzH8fdz0nZNujZt58Sta2WTiQiCF/5gCDo2nAgiwxtlAxGd/8OYQ+cYbojOCxWc80aQ3QiCgsPRjVbETZx6oV4IbnOUbh3WtsmapmmT8/14kZPY7LQuOUm1sHxvknPOk/O8Puf7HE4SaFazmtWsZt3K5aoZNP70i53tbq7foX4n6wP6Dfow9QLdSN0S3aBORCsSoITEKiQEs07KSQA2h9w0kEKWkkg5NC5pDGPE4Y/mfV3JWedI/7lPZyMFSD+1a3PM0x6c2wFsBJIARRhIAgEIpGB3sK+ID16K4yvHLLZvic+hCUkX8fWVtfDB2m9Ojd00QGbnrhcQ7wOJigP/NV4K5iqPmTSz59d+f/rLJQNkdu7ejnQKiK0wPCqeY8bz2NJ77vQvJZpX6dShFYwH0eEXbP+iHcg+s3uD+Rqp6MrKwpeO5zKrrWfj8HCuogPm655o+OD8EnkZBbPlxANq77xuG0vMcgDn2BTtyhePZf0CuQfuJ3vfvWT8PGa2HPjitsXuLlFbFpg3Rbnypfdzvs+dr+/DtbaSPnWGqfeOkcjM0ua8xuIlfNi8eAdqwlcuEZNwra0AJJ/YzoaPj5Hf8mDQDTUMH2yHA2C2Piq+PGZBtfT20PfGq3S9tpd0YhVz8huDFzjUHwogud668KoMUKqubY/S/8lx8lseIlPIY+VzR8MjgbE2HAB1Nxq/sBsbjhwgeXAf6UScnPnR8Qjh3xYKgOioC3+TEABd2x9j4MRH+I88TKZQwGS14yUwtzocALXVg6/CDwTdePMgyUP7SXckyJvVhi/O3R4OILXVh68yQVDJx7cycOI42UQC1YIvHgsHqBtfm39B1YwHlA8FAM3Xha92DQWVHhxi5LmXiE/P4GrBF7dTpfOUn8SIeYLWRMNXF6AwMcnY4aPY0Ld0eg7PURu+OP9iATQDdEXFV9OA9OAQ44ffITGdIe5VfsWoAY+k6+EAMCVpXWT8vwQoTEwxdvhtbPgsSc/hcPXgQZoKBZBssoyoGb+0Pj04zPiRoySmZ0h4Xu03bBi/xBIyXcW56PgbMpSv+tdnSXoeHq5BeHDiWiiAw/tDiv5jBAnN53FtraRODjLx1rvEZ2ZIeLF/AA3AI+E7XQwFMOdfwkprsza8JOKeY3TvAZSbRz/8RJfn8PAajhfCK3BpkSUUuwR+JDwS7S5G4ex5QLR4XiWogXgkTK7cgfKDzC/ot2C2mvHFdSlaXHBFlhGPyGVjqcuhAGuGPxsFvouCv2GC5cTjTJ9vvnBhLhSgSNYrEoWVikfKOK9waKG5IkDPmS+GEHswsisOb5rwsWfvuPjzrwvNi/65m9r25F1m3suY24FsE5D8n/CTGL87OBkz78PbL5+/dqO1qr/X/9y6dXXMjw9gfp98r885DUi2DrQG0YMpKVM3TnFERwBqR8QDfFbSXHCzZ3xp1kkpnEs7s5Rhf2EaQ27EoVHDrpBhZP3VH7PV+JrVrGY1q1m3bv0NDRMeqgk0OuwAAAAASUVORK5CYII="
											alt=""></a> <a
											href="https://twitter.com/${MemberList[i].member.twitterId}"
											target="_blank"> <img
											style="width =: 30px; height: 30px; margin-left: 10px; margin-top: 25px;"
											src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAADAAAAAwCAYAAABXAvmHAAAABmJLR0QA/wD/AP+gvaeTAAADz0lEQVRoge2XTWgdVRiGn+/MpGnv3LRoqC4UhCz8I8RFRClSXdgqWkuV4CRpi1gqglZTuhFXkiDdCVIKBfEHo1Bzr0JRtGAqWhTBQhsaFX9ADbZisbXaJnPb5t6Z+VyotU0yc89MYlGYZzcz73fO+84ZzjcHCgoKCgoK/sfIJZ2tOnmdq+ZxYLXCNUCowvdG9b3QNbvo8Y7NLFm0O+iqry9/njRk0wDOSO2e6JvS+wxKnNv4oBr3hmBIkacBN8FKgLIt6vNe4u0Tbc65xXch8gSxfBn1eU/mC1A9Xna09JPAcNhb3prXvzMy9QIij1rKDwFdQAtwLJKoE3/Zb0likzqxercDyxQGnJHaLqrqWLv+e4xqsD6DeYBu/jR/0gj30lB13wjuTBKnBlCJO85fiD7maG0P1dOXW1tRFWJ91lr/DyHI/ljZ4bjud8bheJIwNQA66/laR51xtxqstnHRUjlzMyIdzZWzcEF7gFsQ2VT3y18kCVMDCGZijttXqzLqVKb28Nbk9Wn1Mdpp53dOfhXiVZHvvZMmSg0QLT6zHySY+6nc70TmK6cSvOtUamvZq60zFSralsXxDAbC3qWfNhMlbGl/sW75lFSCVxQGEhQCrAFd40zVJqnU9in6mREdC018VCJJ3D2aojptI2veyF5Tz22tjSlcm9tMDkS5O+wrjzbTpW+jI8EGZ1GtR2LpUxhfOHvNMYZZXXkuUj8hFW0XZEcsisDZhbFmhdbPeT/YCNNXQOTjCy6XzMtSBgS+5iGp2WhTAzT88mGEAwtjyx5FP7HVpjcywCBbgMa8HGXGpO79FymbCRq+dwjVDVy6ECcjKX1gK24aACDqa3vTqNyGcDC/LztEeRFf6rZ6qwAAsXAVyCDKq4BVk8nB2VBlZ5aC9E58MatQ3fJvnuEEdtLv/ZylxnoFIomHgF8yu7LnSNiY3p61yDoAftsJE5t1wO9ZJ7EgFuERNrZPZi20DwA0+ksHIie6Ffgw60RpqMhQ6Jf35anN/UW3VGvdkXKfiK5ESTzyWTAc+d4mRDRPcaYVuJDGg6UxgaMo3XnHAIYj8TbnNQ95VmCvtjpBrV9hmyhdOedVRZ6J/dL2+ZiHlAAtI8FNGHFVY0+FK1SlQ+AOYCUwn5PWhKCbw962j+YxxnkS+0CjtfGjW295SpGtKKUF2P5PK/JcPF163vZP04bmvnYHVxqHjcDDApkP6QrjqL4ct4av88Blp/KYTCPbi61O3ehgVhDrCgydxLockXZgKXAKZRLDBKrfouZgZMwo/pIjC226oKCgoKCg4L/CH/2pQ2x506tNAAAAAElFTkSuQmCC"
											alt=""></a>
									</div>
									<p class="m-1" style="font-size: 20px">${MemberList[i].member.krName}</p>
								</div>
							</div>
						</c:forEach>
					</div>
				</div>
				<div class="card">
					<div class="card-header" id="headingThree">
						<h2 class="mb-0">
							<button type="button" class="btn btn-link collapsed"
								data-toggle="collapse" data-target="#gen4">
								<i class="fa fa-plus"></i> 4st Generation
							</button>
						</h2>
					</div>
					<div id="gen4" class="collapse" aria-labelledby="headingThree"
						data-parent="#accordionExample">
						<c:forEach var="i" begin="22" end="25">
							<div class="d-flex flex-row border">
								<div class="order-1 p-1">
									<a
										href="https://www.youtube.com/channel/${MemberList[i].member.channelId}"
										target="_blank"> <img
										style="width: 80px; height: 80px; border-radius: 70px;"
										class="card-img-top" src="${MemberList[i].member.profileUrl}">
									</a>
								</div>
								<div class="order-2 p-1">
									<div
										class="btn-group float-right d-flex justify-content-between"
										role="group" aria-label="Basic example">
										<c:choose>
											<c:when
												test="${fn:contains(sessionScope.favorite,MemberList[i].member.krName) }">
												<img id="${MemberList[i].member.krName}"
													onclick="damaY('${MemberList[i].member.krName}')"
													src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAADAAAAAwCAYAAABXAvmHAAAABmJLR0QA/wD/AP+gvaeTAAAEoElEQVRoge2Z3W8UZRTGf2eWtlBEgtJu+dIQGhED8iEsCbAbqiYSolxqIglcGk0oiNyZGLjwjiuIfwAYb42JIaBeEGMw8YOYFjEkRAhSoFAt0m7blLLv48XutjPb2e7OMqOJ6bnYd949857nOXOeOfPOLszarM1aYqbLHRn92rElSQxLKrB60u2k7DoABa209XfvJYHjJRG0GNneA1oRraXjRCyRCuhqZwvj+RtI6eIXDJBveta29Y3FjZVMBcZH9vnIA7Qxf2JvElCxJyBhyB1ClMgLJEBHpPgrHn8FLnXsQrwAFImXE5FW09v2WtxwCUhIh4uDStPShwDH+3GjxVpS9aTXgnon4/rJQykpb4NtutcTF2a8FZA+AKwkGaaTB1Q4GCdkbBVQT7oddAMxN0AcKuU0jmylbf7zThy48VVA7sA08lLYvdACvBsXbCwV0PfL59E6/geweLpkJj/8iQ3S3PSMrb878rjYkROQMH5rS1PQMpRaClqO2I6013/SFOFqcrLPwF0A+nDuNl7zLbYM3DULnB09AV1qX0UqtQyxAqclYMtRYRnYUmAFUgfQFEpQPuwIPk35JhD9wE2k20K3PNSHszuYu4lL9Vn2wbWqCejy0mPIfRQA8Q01ZNGQT6o4N7RzTflMOmrZ/LHyN3P8CSB3DRDCgqX3B62YhxGs06fo6wTedT/lQBeytf2nkO0HTQQ7SRXy4V2mpk9SdfLV1xVMvGPZodMBzoSYetOvAp8jLQgE8g3/lmRKMUZN3puWGzpTybVqF9IvHVvw3BlE238oGYBBE3ssN3whjOeMbVSX2ldR0DlEZwAkDKi+LhNpHeKGFdhlXcNXqnGs+RzQj20dNHEWaUMAxDfUL5mZ1k1L7LIVCrusa6xvJn41txKWGeinmSzYN4ErVI28zxcqmarrAuS/tfGm7bXIQ4Qnsa52tjD09ymktwIEKgn6iYf46pDhFzYn/7Zto67350hbCQnj4uLjyB0OEPAPjUsGGZ94O/LdZrh6OTW0mdNPi04gOxBTlymSh5OpXL47Kpc5tU8JMZGPUTJlG26ESmMJYFvL4I8jGb/P0NZGmER+oZHwkDYXjxvuMmG+jI5G5xP9jeyHp56X9GQDe5kpn0J9C+h6YnXyCchlJslVfXGvQr7sK88rfU6ZqHQiJ+A8ZWKRTHnuO3blixPBIt/E5iwTucvUcRODMEeyFdB55oLWhUtmmpwGDbrN0Q0MVq8IU9UyXixiJJQALQs2IZqnk/DJSTiJTy3FGsvlT9rO/EnzUp2CE4hHNeTUTGHexuQSIJWZscug84bbmMoN77Pt+cl/ZCz74H5q58hBw1sHnA2XWmnuot0HkRJwlR1oUhZ203D7vWz+ZcuN9FZbb13DV7yu0d0m9iB+nyLPZDJOllwCBpmKqzciZ8fs0dBzlh05PeNif5xXRr+0hWNrTO4QMOSXk1m0Vlr/dvq7hYtk+gtkCCc45anwoeVGH+s3Tp1rXeJSjz422X7AQ8gmxp+217lfz/r6E/gqPV+toxeBfjPviO148HOjpEPjf920WfKOg9L28OFL9gajccaftVn7v9o/fzB7l3fCLDkAAAAASUVORK5CYII="
													style="width: 30px; height: 30px; float: sticky; margin-top: 25px;">
											</c:when>
											<c:otherwise>
												<img id="${MemberList[i].member.krName}"
													onclick="damaY('${MemberList[i].member.krName}')"
													src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAADAAAAAwCAYAAABXAvmHAAAABmJLR0QA/wD/AP+gvaeTAAAFWElEQVRoge2YS4xTZRTHf6ftEGAGBMZHSDDBzHTaTpGMA23HSCAkJi7EhQTZmBAXCAswLkwEJCIuSIaNCzUkggsTDZOIO/AJBlEe007BkVimnbYBowkmBiVmRnm033ExpfTedmZ6O7cbM2d17znf+Z//+c79HufCrMzKrDRNNBFcp4ngumbG8DUTHNgHqsCZZgWQZgFrPPgkwvmJF89aiV35oRlxPM0ALSHvLz+L2dusME2pgCa7YxgzaI2kaySSOed2rOZUoFjcV62UPc0I5XoFNBnqxWiyNraJSnR0yM147lfA6FtMNjHqdX0tuFoBTYR7oHhpClzFEJG+9EW3YrpcgeKbWMmfAb6veBc8uLoWXKuAJrrDYC5jmRTP04gKqicrh2K0R/oyl92I62IFdJ8N74JEr3wrkZFTqJyt0Ase3nArqisJ6AV/CHSTVcnb5WcxB6we8oIOhVa4EdvxJ6TxYDsqfrz4UbpAO4EY8FgFbEKiIzGLXyIUB41WqK4CcZAcwihFsohmJZa+MeME9MeeRdz9x496OhH8QBeIv0R2yfRZ8pzE0icsqnhwA8LxOjj9CZIDzQKjKFnE5GiZn5Unhm9OmYDGgwcQXgYeqiPQZOyHiWR6RVCLVhGGApdAehrH5g+UIxJLl88T6xrwth4AhmcQ4DrCfjt5ABEUYT9wfQb4wyWO93HtI/T08rm0zf0M5dkaAEXgV9A8SB6VPKI51ORpa8lLODVWDwtNhdsYu9uBeDpQ6US0A7QDpAN4FPBWOQmfM3Zrk6y/dmvKBEoB5jBeHAA22kD+Qs0zbt9nynEnTvKTwIM20wkWFzaJP3fb7lNzG5Vw6g7X0ptBPrFGYDHIN5rsjtXym4loMtQLxVNUkZdP8bRurEUepjgHZDNFro28BHxksyzCmK91MNQ3U9L3RAeDqzB6Emi3Ghhg/JEXZfXFu5PynBZcEYaC7wE7bKZxhA0SSX/XCOky/lDgKVS+ABbaLB8SyWwXwUzlP+1JLIISSb8CeshmasVwXBOhtU5JlykmQmsx8hXV5A8RyWybjjzUeZWYSCKzE+Edq4E20C91MLC+ftolismuNaAnJjAslkNEMjtrbcW1pO67kAgqkfRrQL/NNB+PvF4vTlmMZy+wwKbtl2hmR73koYHLnETTe1AGrEr9ySlOlY8yING0416h0dtoi+XNiPMEqn1aao6bRhpLQHjc8u7lZ8cYqikbZkPXa8cJ6Onlc4HOClWBBwqjNcfGg10aD3bVBGovZoBChcZfwnYkzivQ2hqk8q4ikrWfkjrYuUwTgSMIKYSUJgJHdLBzWeUY8eduI5KtUHlL2I7EeQJirJ+Puf8p6PnwEh0K9OPxjYJsZeLnsQ9kKx5fXhPBD/Rcx8NlX9UrVvCC48+ogTVgwjZFSpOr5ms8tAtfIY/KLmBeDcc5wDZ8LXkdCvTr2cACwLoOEDv2tNLA73WxzpKwEjOeQ1haV4cqtKGyizlsAWz/T22bQx3iPAHDChvP5ycZeQPRgwClqrTb7EurfI3znchRU6+DnQvx+G5O4zeO6Pv45vXf62EnGhizA9E9wANThcAUFklf7u96OTlbAx7fCiYnfwc4DN5OiWR2VzbgEk6NSWzkIEpHqSr/ToIhiM/ROnCWQO3D5i6qH6MalGh6u0RTv0/qHkvfkEhmN6bQBbwLVDcpDg80ZwkolbNjEDmGkbDEMlsklrlaL4z05X6TaPpVfBIADjPRa9+zNrEClGfnFOJZLZGRzdI3kp3SYwqR3pFfJJrejvGuROQYoGBc+WNXUzQePNqMfriMn+yOaTx4tFn4szIr/0f5D1yB0iClsG6VAAAAAElFTkSuQmCC"
													style="width: 30px; height: 30px; float: sticky; margin-top: 25px;">
											</c:otherwise>
										</c:choose>
										<a
											href="https://www.youtube.com/channel/${MemberList[i].member.channelId}"
											target="_blank"> <img
											style="width =: 30px; height: 30px; margin-left: 10px; margin-top: 25px;"
											src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAADAAAAAwCAYAAABXAvmHAAAABmJLR0QA/wD/AP+gvaeTAAAEZ0lEQVRoge3Y32tbZRzH8fdz0nZNujZt58Sta2WTiQiCF/5gCDo2nAgiwxtlAxGd/8OYQ+cYbojOCxWc80aQ3QiCgsPRjVbETZx6oV4IbnOUbh3WtsmapmmT8/14kZPY7LQuOUm1sHxvknPOk/O8Puf7HE4SaFazmtWsZt3K5aoZNP70i53tbq7foX4n6wP6Dfow9QLdSN0S3aBORCsSoITEKiQEs07KSQA2h9w0kEKWkkg5NC5pDGPE4Y/mfV3JWedI/7lPZyMFSD+1a3PM0x6c2wFsBJIARRhIAgEIpGB3sK+ID16K4yvHLLZvic+hCUkX8fWVtfDB2m9Ojd00QGbnrhcQ7wOJigP/NV4K5iqPmTSz59d+f/rLJQNkdu7ejnQKiK0wPCqeY8bz2NJ77vQvJZpX6dShFYwH0eEXbP+iHcg+s3uD+Rqp6MrKwpeO5zKrrWfj8HCuogPm655o+OD8EnkZBbPlxANq77xuG0vMcgDn2BTtyhePZf0CuQfuJ3vfvWT8PGa2HPjitsXuLlFbFpg3Rbnypfdzvs+dr+/DtbaSPnWGqfeOkcjM0ua8xuIlfNi8eAdqwlcuEZNwra0AJJ/YzoaPj5Hf8mDQDTUMH2yHA2C2Piq+PGZBtfT20PfGq3S9tpd0YhVz8huDFzjUHwogud668KoMUKqubY/S/8lx8lseIlPIY+VzR8MjgbE2HAB1Nxq/sBsbjhwgeXAf6UScnPnR8Qjh3xYKgOioC3+TEABd2x9j4MRH+I88TKZQwGS14yUwtzocALXVg6/CDwTdePMgyUP7SXckyJvVhi/O3R4OILXVh68yQVDJx7cycOI42UQC1YIvHgsHqBtfm39B1YwHlA8FAM3Xha92DQWVHhxi5LmXiE/P4GrBF7dTpfOUn8SIeYLWRMNXF6AwMcnY4aPY0Ld0eg7PURu+OP9iATQDdEXFV9OA9OAQ44ffITGdIe5VfsWoAY+k6+EAMCVpXWT8vwQoTEwxdvhtbPgsSc/hcPXgQZoKBZBssoyoGb+0Pj04zPiRoySmZ0h4Xu03bBi/xBIyXcW56PgbMpSv+tdnSXoeHq5BeHDiWiiAw/tDiv5jBAnN53FtraRODjLx1rvEZ2ZIeLF/AA3AI+E7XQwFMOdfwkprsza8JOKeY3TvAZSbRz/8RJfn8PAajhfCK3BpkSUUuwR+JDwS7S5G4ex5QLR4XiWogXgkTK7cgfKDzC/ot2C2mvHFdSlaXHBFlhGPyGVjqcuhAGuGPxsFvouCv2GC5cTjTJ9vvnBhLhSgSNYrEoWVikfKOK9waKG5IkDPmS+GEHswsisOb5rwsWfvuPjzrwvNi/65m9r25F1m3suY24FsE5D8n/CTGL87OBkz78PbL5+/dqO1qr/X/9y6dXXMjw9gfp98r885DUi2DrQG0YMpKVM3TnFERwBqR8QDfFbSXHCzZ3xp1kkpnEs7s5Rhf2EaQ27EoVHDrpBhZP3VH7PV+JrVrGY1q1m3bv0NDRMeqgk0OuwAAAAASUVORK5CYII="
											alt=""></a> <a
											href="https://twitter.com/${MemberList[i].member.twitterId}"
											target="_blank"> <img
											style="width =: 30px; height: 30px; margin-left: 10px; margin-top: 25px;"
											src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAADAAAAAwCAYAAABXAvmHAAAABmJLR0QA/wD/AP+gvaeTAAADz0lEQVRoge2XTWgdVRiGn+/MpGnv3LRoqC4UhCz8I8RFRClSXdgqWkuV4CRpi1gqglZTuhFXkiDdCVIKBfEHo1Bzr0JRtGAqWhTBQhsaFX9ADbZisbXaJnPb5t6Z+VyotU0yc89MYlGYZzcz73fO+84ZzjcHCgoKCgoK/sfIJZ2tOnmdq+ZxYLXCNUCowvdG9b3QNbvo8Y7NLFm0O+iqry9/njRk0wDOSO2e6JvS+wxKnNv4oBr3hmBIkacBN8FKgLIt6vNe4u0Tbc65xXch8gSxfBn1eU/mC1A9Xna09JPAcNhb3prXvzMy9QIij1rKDwFdQAtwLJKoE3/Zb0likzqxercDyxQGnJHaLqrqWLv+e4xqsD6DeYBu/jR/0gj30lB13wjuTBKnBlCJO85fiD7maG0P1dOXW1tRFWJ91lr/DyHI/ljZ4bjud8bheJIwNQA66/laR51xtxqstnHRUjlzMyIdzZWzcEF7gFsQ2VT3y18kCVMDCGZijttXqzLqVKb28Nbk9Wn1Mdpp53dOfhXiVZHvvZMmSg0QLT6zHySY+6nc70TmK6cSvOtUamvZq60zFSralsXxDAbC3qWfNhMlbGl/sW75lFSCVxQGEhQCrAFd40zVJqnU9in6mREdC018VCJJ3D2aojptI2veyF5Tz22tjSlcm9tMDkS5O+wrjzbTpW+jI8EGZ1GtR2LpUxhfOHvNMYZZXXkuUj8hFW0XZEcsisDZhbFmhdbPeT/YCNNXQOTjCy6XzMtSBgS+5iGp2WhTAzT88mGEAwtjyx5FP7HVpjcywCBbgMa8HGXGpO79FymbCRq+dwjVDVy6ECcjKX1gK24aACDqa3vTqNyGcDC/LztEeRFf6rZ6qwAAsXAVyCDKq4BVk8nB2VBlZ5aC9E58MatQ3fJvnuEEdtLv/ZylxnoFIomHgF8yu7LnSNiY3p61yDoAftsJE5t1wO9ZJ7EgFuERNrZPZi20DwA0+ksHIie6Ffgw60RpqMhQ6Jf35anN/UW3VGvdkXKfiK5ESTzyWTAc+d4mRDRPcaYVuJDGg6UxgaMo3XnHAIYj8TbnNQ95VmCvtjpBrV9hmyhdOedVRZ6J/dL2+ZiHlAAtI8FNGHFVY0+FK1SlQ+AOYCUwn5PWhKCbw962j+YxxnkS+0CjtfGjW295SpGtKKUF2P5PK/JcPF163vZP04bmvnYHVxqHjcDDApkP6QrjqL4ct4av88Blp/KYTCPbi61O3ehgVhDrCgydxLockXZgKXAKZRLDBKrfouZgZMwo/pIjC226oKCgoKCg4L/CH/2pQ2x506tNAAAAAElFTkSuQmCC"
											alt=""></a>
									</div>
									<p class="m-1" style="font-size: 20px">${MemberList[i].member.krName}</p>
								</div>
							</div>
						</c:forEach>
					</div>
				</div>
				<div class="card">
					<div class="card-header" id="headingThree">
						<h2 class="mb-0">
							<button type="button" class="btn btn-link collapsed"
								data-toggle="collapse" data-target="#gen5">
								<i class="fa fa-plus"></i> 5st Generation
							</button>
						</h2>
					</div>
					<div id="gen5" class="collapse" aria-labelledby="headingThree"
						data-parent="#accordionExample">
						<c:forEach var="i" begin="26" end="29">
							<div class="d-flex flex-row border">
								<div class="order-1 p-1">
									<a
										href="https://www.youtube.com/channel/${MemberList[i].member.channelId}"
										target="_blank"> <img
										style="width: 80px; height: 80px; border-radius: 70px;"
										class="card-img-top" src="${MemberList[i].member.profileUrl}">
									</a>
								</div>
								<div class="order-2 p-1">
									<div
										class="btn-group float-right d-flex justify-content-between"
										role="group" aria-label="Basic example">
										<c:choose>
											<c:when
												test="${fn:contains(sessionScope.favorite,MemberList[i].member.krName) }">
												<img id="${MemberList[i].member.krName}"
													onclick="damaY('${MemberList[i].member.krName}')"
													src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAADAAAAAwCAYAAABXAvmHAAAABmJLR0QA/wD/AP+gvaeTAAAEoElEQVRoge2Z3W8UZRTGf2eWtlBEgtJu+dIQGhED8iEsCbAbqiYSolxqIglcGk0oiNyZGLjwjiuIfwAYb42JIaBeEGMw8YOYFjEkRAhSoFAt0m7blLLv48XutjPb2e7OMqOJ6bnYd949857nOXOeOfPOLszarM1aYqbLHRn92rElSQxLKrB60u2k7DoABa209XfvJYHjJRG0GNneA1oRraXjRCyRCuhqZwvj+RtI6eIXDJBveta29Y3FjZVMBcZH9vnIA7Qxf2JvElCxJyBhyB1ClMgLJEBHpPgrHn8FLnXsQrwAFImXE5FW09v2WtxwCUhIh4uDStPShwDH+3GjxVpS9aTXgnon4/rJQykpb4NtutcTF2a8FZA+AKwkGaaTB1Q4GCdkbBVQT7oddAMxN0AcKuU0jmylbf7zThy48VVA7sA08lLYvdACvBsXbCwV0PfL59E6/geweLpkJj/8iQ3S3PSMrb878rjYkROQMH5rS1PQMpRaClqO2I6013/SFOFqcrLPwF0A+nDuNl7zLbYM3DULnB09AV1qX0UqtQyxAqclYMtRYRnYUmAFUgfQFEpQPuwIPk35JhD9wE2k20K3PNSHszuYu4lL9Vn2wbWqCejy0mPIfRQA8Q01ZNGQT6o4N7RzTflMOmrZ/LHyN3P8CSB3DRDCgqX3B62YhxGs06fo6wTedT/lQBeytf2nkO0HTQQ7SRXy4V2mpk9SdfLV1xVMvGPZodMBzoSYetOvAp8jLQgE8g3/lmRKMUZN3puWGzpTybVqF9IvHVvw3BlE238oGYBBE3ssN3whjOeMbVSX2ldR0DlEZwAkDKi+LhNpHeKGFdhlXcNXqnGs+RzQj20dNHEWaUMAxDfUL5mZ1k1L7LIVCrusa6xvJn41txKWGeinmSzYN4ErVI28zxcqmarrAuS/tfGm7bXIQ4Qnsa52tjD09ymktwIEKgn6iYf46pDhFzYn/7Zto67350hbCQnj4uLjyB0OEPAPjUsGGZ94O/LdZrh6OTW0mdNPi04gOxBTlymSh5OpXL47Kpc5tU8JMZGPUTJlG26ESmMJYFvL4I8jGb/P0NZGmER+oZHwkDYXjxvuMmG+jI5G5xP9jeyHp56X9GQDe5kpn0J9C+h6YnXyCchlJslVfXGvQr7sK88rfU6ZqHQiJ+A8ZWKRTHnuO3blixPBIt/E5iwTucvUcRODMEeyFdB55oLWhUtmmpwGDbrN0Q0MVq8IU9UyXixiJJQALQs2IZqnk/DJSTiJTy3FGsvlT9rO/EnzUp2CE4hHNeTUTGHexuQSIJWZscug84bbmMoN77Pt+cl/ZCz74H5q58hBw1sHnA2XWmnuot0HkRJwlR1oUhZ203D7vWz+ZcuN9FZbb13DV7yu0d0m9iB+nyLPZDJOllwCBpmKqzciZ8fs0dBzlh05PeNif5xXRr+0hWNrTO4QMOSXk1m0Vlr/dvq7hYtk+gtkCCc45anwoeVGH+s3Tp1rXeJSjz422X7AQ8gmxp+217lfz/r6E/gqPV+toxeBfjPviO148HOjpEPjf920WfKOg9L28OFL9gajccaftVn7v9o/fzB7l3fCLDkAAAAASUVORK5CYII="
													style="width: 30px; height: 30px; float: sticky; margin-top: 25px;">
											</c:when>
											<c:otherwise>
												<img id="${MemberList[i].member.krName}"
													onclick="damaY('${MemberList[i].member.krName}')"
													src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAADAAAAAwCAYAAABXAvmHAAAABmJLR0QA/wD/AP+gvaeTAAAFWElEQVRoge2YS4xTZRTHf6ftEGAGBMZHSDDBzHTaTpGMA23HSCAkJi7EhQTZmBAXCAswLkwEJCIuSIaNCzUkggsTDZOIO/AJBlEe007BkVimnbYBowkmBiVmRnm033ExpfTedmZ6O7cbM2d17znf+Z//+c79HufCrMzKrDRNNBFcp4ngumbG8DUTHNgHqsCZZgWQZgFrPPgkwvmJF89aiV35oRlxPM0ALSHvLz+L2dusME2pgCa7YxgzaI2kaySSOed2rOZUoFjcV62UPc0I5XoFNBnqxWiyNraJSnR0yM147lfA6FtMNjHqdX0tuFoBTYR7oHhpClzFEJG+9EW3YrpcgeKbWMmfAb6veBc8uLoWXKuAJrrDYC5jmRTP04gKqicrh2K0R/oyl92I62IFdJ8N74JEr3wrkZFTqJyt0Ase3nArqisJ6AV/CHSTVcnb5WcxB6we8oIOhVa4EdvxJ6TxYDsqfrz4UbpAO4EY8FgFbEKiIzGLXyIUB41WqK4CcZAcwihFsohmJZa+MeME9MeeRdz9x496OhH8QBeIv0R2yfRZ8pzE0icsqnhwA8LxOjj9CZIDzQKjKFnE5GiZn5Unhm9OmYDGgwcQXgYeqiPQZOyHiWR6RVCLVhGGApdAehrH5g+UIxJLl88T6xrwth4AhmcQ4DrCfjt5ABEUYT9wfQb4wyWO93HtI/T08rm0zf0M5dkaAEXgV9A8SB6VPKI51ORpa8lLODVWDwtNhdsYu9uBeDpQ6US0A7QDpAN4FPBWOQmfM3Zrk6y/dmvKBEoB5jBeHAA22kD+Qs0zbt9nynEnTvKTwIM20wkWFzaJP3fb7lNzG5Vw6g7X0ptBPrFGYDHIN5rsjtXym4loMtQLxVNUkZdP8bRurEUepjgHZDNFro28BHxksyzCmK91MNQ3U9L3RAeDqzB6Emi3Ghhg/JEXZfXFu5PynBZcEYaC7wE7bKZxhA0SSX/XCOky/lDgKVS+ABbaLB8SyWwXwUzlP+1JLIISSb8CeshmasVwXBOhtU5JlykmQmsx8hXV5A8RyWybjjzUeZWYSCKzE+Edq4E20C91MLC+ftolismuNaAnJjAslkNEMjtrbcW1pO67kAgqkfRrQL/NNB+PvF4vTlmMZy+wwKbtl2hmR73koYHLnETTe1AGrEr9ySlOlY8yING0416h0dtoi+XNiPMEqn1aao6bRhpLQHjc8u7lZ8cYqikbZkPXa8cJ6Onlc4HOClWBBwqjNcfGg10aD3bVBGovZoBChcZfwnYkzivQ2hqk8q4ikrWfkjrYuUwTgSMIKYSUJgJHdLBzWeUY8eduI5KtUHlL2I7EeQJirJ+Puf8p6PnwEh0K9OPxjYJsZeLnsQ9kKx5fXhPBD/Rcx8NlX9UrVvCC48+ogTVgwjZFSpOr5ms8tAtfIY/KLmBeDcc5wDZ8LXkdCvTr2cACwLoOEDv2tNLA73WxzpKwEjOeQ1haV4cqtKGyizlsAWz/T22bQx3iPAHDChvP5ycZeQPRgwClqrTb7EurfI3znchRU6+DnQvx+G5O4zeO6Pv45vXf62EnGhizA9E9wANThcAUFklf7u96OTlbAx7fCiYnfwc4DN5OiWR2VzbgEk6NSWzkIEpHqSr/ToIhiM/ROnCWQO3D5i6qH6MalGh6u0RTv0/qHkvfkEhmN6bQBbwLVDcpDg80ZwkolbNjEDmGkbDEMlsklrlaL4z05X6TaPpVfBIADjPRa9+zNrEClGfnFOJZLZGRzdI3kp3SYwqR3pFfJJrejvGuROQYoGBc+WNXUzQePNqMfriMn+yOaTx4tFn4szIr/0f5D1yB0iClsG6VAAAAAElFTkSuQmCC"
													style="width: 30px; height: 30px; float: sticky; margin-top: 25px;">
											</c:otherwise>
										</c:choose>
										<a
											href="https://www.youtube.com/channel/${MemberList[i].member.channelId}"
											target="_blank"> <img
											style="width =: 30px; height: 30px; margin-left: 10px; margin-top: 25px;"
											src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAADAAAAAwCAYAAABXAvmHAAAABmJLR0QA/wD/AP+gvaeTAAAEZ0lEQVRoge3Y32tbZRzH8fdz0nZNujZt58Sta2WTiQiCF/5gCDo2nAgiwxtlAxGd/8OYQ+cYbojOCxWc80aQ3QiCgsPRjVbETZx6oV4IbnOUbh3WtsmapmmT8/14kZPY7LQuOUm1sHxvknPOk/O8Puf7HE4SaFazmtWsZt3K5aoZNP70i53tbq7foX4n6wP6Dfow9QLdSN0S3aBORCsSoITEKiQEs07KSQA2h9w0kEKWkkg5NC5pDGPE4Y/mfV3JWedI/7lPZyMFSD+1a3PM0x6c2wFsBJIARRhIAgEIpGB3sK+ID16K4yvHLLZvic+hCUkX8fWVtfDB2m9Ojd00QGbnrhcQ7wOJigP/NV4K5iqPmTSz59d+f/rLJQNkdu7ejnQKiK0wPCqeY8bz2NJ77vQvJZpX6dShFYwH0eEXbP+iHcg+s3uD+Rqp6MrKwpeO5zKrrWfj8HCuogPm655o+OD8EnkZBbPlxANq77xuG0vMcgDn2BTtyhePZf0CuQfuJ3vfvWT8PGa2HPjitsXuLlFbFpg3Rbnypfdzvs+dr+/DtbaSPnWGqfeOkcjM0ua8xuIlfNi8eAdqwlcuEZNwra0AJJ/YzoaPj5Hf8mDQDTUMH2yHA2C2Piq+PGZBtfT20PfGq3S9tpd0YhVz8huDFzjUHwogud668KoMUKqubY/S/8lx8lseIlPIY+VzR8MjgbE2HAB1Nxq/sBsbjhwgeXAf6UScnPnR8Qjh3xYKgOioC3+TEABd2x9j4MRH+I88TKZQwGS14yUwtzocALXVg6/CDwTdePMgyUP7SXckyJvVhi/O3R4OILXVh68yQVDJx7cycOI42UQC1YIvHgsHqBtfm39B1YwHlA8FAM3Xha92DQWVHhxi5LmXiE/P4GrBF7dTpfOUn8SIeYLWRMNXF6AwMcnY4aPY0Ld0eg7PURu+OP9iATQDdEXFV9OA9OAQ44ffITGdIe5VfsWoAY+k6+EAMCVpXWT8vwQoTEwxdvhtbPgsSc/hcPXgQZoKBZBssoyoGb+0Pj04zPiRoySmZ0h4Xu03bBi/xBIyXcW56PgbMpSv+tdnSXoeHq5BeHDiWiiAw/tDiv5jBAnN53FtraRODjLx1rvEZ2ZIeLF/AA3AI+E7XQwFMOdfwkprsza8JOKeY3TvAZSbRz/8RJfn8PAajhfCK3BpkSUUuwR+JDwS7S5G4ex5QLR4XiWogXgkTK7cgfKDzC/ot2C2mvHFdSlaXHBFlhGPyGVjqcuhAGuGPxsFvouCv2GC5cTjTJ9vvnBhLhSgSNYrEoWVikfKOK9waKG5IkDPmS+GEHswsisOb5rwsWfvuPjzrwvNi/65m9r25F1m3suY24FsE5D8n/CTGL87OBkz78PbL5+/dqO1qr/X/9y6dXXMjw9gfp98r885DUi2DrQG0YMpKVM3TnFERwBqR8QDfFbSXHCzZ3xp1kkpnEs7s5Rhf2EaQ27EoVHDrpBhZP3VH7PV+JrVrGY1q1m3bv0NDRMeqgk0OuwAAAAASUVORK5CYII="
											alt=""></a> <a
											href="https://twitter.com/${MemberList[i].member.twitterId}"
											target="_blank"> <img
											style="width =: 30px; height: 30px; margin-left: 10px; margin-top: 25px;"
											src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAADAAAAAwCAYAAABXAvmHAAAABmJLR0QA/wD/AP+gvaeTAAADz0lEQVRoge2XTWgdVRiGn+/MpGnv3LRoqC4UhCz8I8RFRClSXdgqWkuV4CRpi1gqglZTuhFXkiDdCVIKBfEHo1Bzr0JRtGAqWhTBQhsaFX9ADbZisbXaJnPb5t6Z+VyotU0yc89MYlGYZzcz73fO+84ZzjcHCgoKCgoK/sfIJZ2tOnmdq+ZxYLXCNUCowvdG9b3QNbvo8Y7NLFm0O+iqry9/njRk0wDOSO2e6JvS+wxKnNv4oBr3hmBIkacBN8FKgLIt6vNe4u0Tbc65xXch8gSxfBn1eU/mC1A9Xna09JPAcNhb3prXvzMy9QIij1rKDwFdQAtwLJKoE3/Zb0likzqxercDyxQGnJHaLqrqWLv+e4xqsD6DeYBu/jR/0gj30lB13wjuTBKnBlCJO85fiD7maG0P1dOXW1tRFWJ91lr/DyHI/ljZ4bjud8bheJIwNQA66/laR51xtxqstnHRUjlzMyIdzZWzcEF7gFsQ2VT3y18kCVMDCGZijttXqzLqVKb28Nbk9Wn1Mdpp53dOfhXiVZHvvZMmSg0QLT6zHySY+6nc70TmK6cSvOtUamvZq60zFSralsXxDAbC3qWfNhMlbGl/sW75lFSCVxQGEhQCrAFd40zVJqnU9in6mREdC018VCJJ3D2aojptI2veyF5Tz22tjSlcm9tMDkS5O+wrjzbTpW+jI8EGZ1GtR2LpUxhfOHvNMYZZXXkuUj8hFW0XZEcsisDZhbFmhdbPeT/YCNNXQOTjCy6XzMtSBgS+5iGp2WhTAzT88mGEAwtjyx5FP7HVpjcywCBbgMa8HGXGpO79FymbCRq+dwjVDVy6ECcjKX1gK24aACDqa3vTqNyGcDC/LztEeRFf6rZ6qwAAsXAVyCDKq4BVk8nB2VBlZ5aC9E58MatQ3fJvnuEEdtLv/ZylxnoFIomHgF8yu7LnSNiY3p61yDoAftsJE5t1wO9ZJ7EgFuERNrZPZi20DwA0+ksHIie6Ffgw60RpqMhQ6Jf35anN/UW3VGvdkXKfiK5ESTzyWTAc+d4mRDRPcaYVuJDGg6UxgaMo3XnHAIYj8TbnNQ95VmCvtjpBrV9hmyhdOedVRZ6J/dL2+ZiHlAAtI8FNGHFVY0+FK1SlQ+AOYCUwn5PWhKCbw962j+YxxnkS+0CjtfGjW295SpGtKKUF2P5PK/JcPF163vZP04bmvnYHVxqHjcDDApkP6QrjqL4ct4av88Blp/KYTCPbi61O3ehgVhDrCgydxLockXZgKXAKZRLDBKrfouZgZMwo/pIjC226oKCgoKCg4L/CH/2pQ2x506tNAAAAAElFTkSuQmCC"
											alt=""></a>
									</div>
									<p class="m-1" style="font-size: 20px">${MemberList[i].member.krName}</p>
								</div>
							</div>
						</c:forEach>
					</div>
				</div>
				<div class="card">
					<div class="card-header" id="headingThree">
						<h2 class="mb-0">
							<button type="button" class="btn btn-link collapsed"
								data-toggle="collapse" data-target="#gen6">
								<i class="fa fa-plus"></i> 6st Generation
							</button>
						</h2>
					</div>
					<div id="gen6" class="collapse" aria-labelledby="headingThree"
						data-parent="#accordionExample">
						<c:forEach var="i" begin="30" end="34">
							<div class="d-flex flex-row border">
								<div class="order-1 p-1">
									<a
										href="https://www.youtube.com/channel/${MemberList[i].member.channelId}"
										target="_blank"> <img
										style="width: 80px; height: 80px; border-radius: 70px;"
										class="card-img-top" src="${MemberList[i].member.profileUrl}">
									</a>
								</div>
								<div class="order-2 p-1">
									<div
										class="btn-group float-right d-flex justify-content-between"
										role="group" aria-label="Basic example">
										<c:choose>
											<c:when
												test="${fn:contains(sessionScope.favorite,MemberList[i].member.krName) }">
												<img id="${MemberList[i].member.krName}"
													onclick="damaY('${MemberList[i].member.krName}')"
													src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAADAAAAAwCAYAAABXAvmHAAAABmJLR0QA/wD/AP+gvaeTAAAEoElEQVRoge2Z3W8UZRTGf2eWtlBEgtJu+dIQGhED8iEsCbAbqiYSolxqIglcGk0oiNyZGLjwjiuIfwAYb42JIaBeEGMw8YOYFjEkRAhSoFAt0m7blLLv48XutjPb2e7OMqOJ6bnYd949857nOXOeOfPOLszarM1aYqbLHRn92rElSQxLKrB60u2k7DoABa209XfvJYHjJRG0GNneA1oRraXjRCyRCuhqZwvj+RtI6eIXDJBveta29Y3FjZVMBcZH9vnIA7Qxf2JvElCxJyBhyB1ClMgLJEBHpPgrHn8FLnXsQrwAFImXE5FW09v2WtxwCUhIh4uDStPShwDH+3GjxVpS9aTXgnon4/rJQykpb4NtutcTF2a8FZA+AKwkGaaTB1Q4GCdkbBVQT7oddAMxN0AcKuU0jmylbf7zThy48VVA7sA08lLYvdACvBsXbCwV0PfL59E6/geweLpkJj/8iQ3S3PSMrb878rjYkROQMH5rS1PQMpRaClqO2I6013/SFOFqcrLPwF0A+nDuNl7zLbYM3DULnB09AV1qX0UqtQyxAqclYMtRYRnYUmAFUgfQFEpQPuwIPk35JhD9wE2k20K3PNSHszuYu4lL9Vn2wbWqCejy0mPIfRQA8Q01ZNGQT6o4N7RzTflMOmrZ/LHyN3P8CSB3DRDCgqX3B62YhxGs06fo6wTedT/lQBeytf2nkO0HTQQ7SRXy4V2mpk9SdfLV1xVMvGPZodMBzoSYetOvAp8jLQgE8g3/lmRKMUZN3puWGzpTybVqF9IvHVvw3BlE238oGYBBE3ssN3whjOeMbVSX2ldR0DlEZwAkDKi+LhNpHeKGFdhlXcNXqnGs+RzQj20dNHEWaUMAxDfUL5mZ1k1L7LIVCrusa6xvJn41txKWGeinmSzYN4ErVI28zxcqmarrAuS/tfGm7bXIQ4Qnsa52tjD09ymktwIEKgn6iYf46pDhFzYn/7Zto67350hbCQnj4uLjyB0OEPAPjUsGGZ94O/LdZrh6OTW0mdNPi04gOxBTlymSh5OpXL47Kpc5tU8JMZGPUTJlG26ESmMJYFvL4I8jGb/P0NZGmER+oZHwkDYXjxvuMmG+jI5G5xP9jeyHp56X9GQDe5kpn0J9C+h6YnXyCchlJslVfXGvQr7sK88rfU6ZqHQiJ+A8ZWKRTHnuO3blixPBIt/E5iwTucvUcRODMEeyFdB55oLWhUtmmpwGDbrN0Q0MVq8IU9UyXixiJJQALQs2IZqnk/DJSTiJTy3FGsvlT9rO/EnzUp2CE4hHNeTUTGHexuQSIJWZscug84bbmMoN77Pt+cl/ZCz74H5q58hBw1sHnA2XWmnuot0HkRJwlR1oUhZ203D7vWz+ZcuN9FZbb13DV7yu0d0m9iB+nyLPZDJOllwCBpmKqzciZ8fs0dBzlh05PeNif5xXRr+0hWNrTO4QMOSXk1m0Vlr/dvq7hYtk+gtkCCc45anwoeVGH+s3Tp1rXeJSjz422X7AQ8gmxp+217lfz/r6E/gqPV+toxeBfjPviO148HOjpEPjf920WfKOg9L28OFL9gajccaftVn7v9o/fzB7l3fCLDkAAAAASUVORK5CYII="
													style="width: 30px; height: 30px; float: sticky; margin-top: 25px;">
											</c:when>
											<c:otherwise>
												<img id="${MemberList[i].member.krName}"
													onclick="damaY('${MemberList[i].member.krName}')"
													src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAADAAAAAwCAYAAABXAvmHAAAABmJLR0QA/wD/AP+gvaeTAAAFWElEQVRoge2YS4xTZRTHf6ftEGAGBMZHSDDBzHTaTpGMA23HSCAkJi7EhQTZmBAXCAswLkwEJCIuSIaNCzUkggsTDZOIO/AJBlEe007BkVimnbYBowkmBiVmRnm033ExpfTedmZ6O7cbM2d17znf+Z//+c79HufCrMzKrDRNNBFcp4ngumbG8DUTHNgHqsCZZgWQZgFrPPgkwvmJF89aiV35oRlxPM0ALSHvLz+L2dusME2pgCa7YxgzaI2kaySSOed2rOZUoFjcV62UPc0I5XoFNBnqxWiyNraJSnR0yM147lfA6FtMNjHqdX0tuFoBTYR7oHhpClzFEJG+9EW3YrpcgeKbWMmfAb6veBc8uLoWXKuAJrrDYC5jmRTP04gKqicrh2K0R/oyl92I62IFdJ8N74JEr3wrkZFTqJyt0Ase3nArqisJ6AV/CHSTVcnb5WcxB6we8oIOhVa4EdvxJ6TxYDsqfrz4UbpAO4EY8FgFbEKiIzGLXyIUB41WqK4CcZAcwihFsohmJZa+MeME9MeeRdz9x496OhH8QBeIv0R2yfRZ8pzE0icsqnhwA8LxOjj9CZIDzQKjKFnE5GiZn5Unhm9OmYDGgwcQXgYeqiPQZOyHiWR6RVCLVhGGApdAehrH5g+UIxJLl88T6xrwth4AhmcQ4DrCfjt5ABEUYT9wfQb4wyWO93HtI/T08rm0zf0M5dkaAEXgV9A8SB6VPKI51ORpa8lLODVWDwtNhdsYu9uBeDpQ6US0A7QDpAN4FPBWOQmfM3Zrk6y/dmvKBEoB5jBeHAA22kD+Qs0zbt9nynEnTvKTwIM20wkWFzaJP3fb7lNzG5Vw6g7X0ptBPrFGYDHIN5rsjtXym4loMtQLxVNUkZdP8bRurEUepjgHZDNFro28BHxksyzCmK91MNQ3U9L3RAeDqzB6Emi3Ghhg/JEXZfXFu5PynBZcEYaC7wE7bKZxhA0SSX/XCOky/lDgKVS+ABbaLB8SyWwXwUzlP+1JLIISSb8CeshmasVwXBOhtU5JlykmQmsx8hXV5A8RyWybjjzUeZWYSCKzE+Edq4E20C91MLC+ftolismuNaAnJjAslkNEMjtrbcW1pO67kAgqkfRrQL/NNB+PvF4vTlmMZy+wwKbtl2hmR73koYHLnETTe1AGrEr9ySlOlY8yING0416h0dtoi+XNiPMEqn1aao6bRhpLQHjc8u7lZ8cYqikbZkPXa8cJ6Onlc4HOClWBBwqjNcfGg10aD3bVBGovZoBChcZfwnYkzivQ2hqk8q4ikrWfkjrYuUwTgSMIKYSUJgJHdLBzWeUY8eduI5KtUHlL2I7EeQJirJ+Puf8p6PnwEh0K9OPxjYJsZeLnsQ9kKx5fXhPBD/Rcx8NlX9UrVvCC48+ogTVgwjZFSpOr5ms8tAtfIY/KLmBeDcc5wDZ8LXkdCvTr2cACwLoOEDv2tNLA73WxzpKwEjOeQ1haV4cqtKGyizlsAWz/T22bQx3iPAHDChvP5ycZeQPRgwClqrTb7EurfI3znchRU6+DnQvx+G5O4zeO6Pv45vXf62EnGhizA9E9wANThcAUFklf7u96OTlbAx7fCiYnfwc4DN5OiWR2VzbgEk6NSWzkIEpHqSr/ToIhiM/ROnCWQO3D5i6qH6MalGh6u0RTv0/qHkvfkEhmN6bQBbwLVDcpDg80ZwkolbNjEDmGkbDEMlsklrlaL4z05X6TaPpVfBIADjPRa9+zNrEClGfnFOJZLZGRzdI3kp3SYwqR3pFfJJrejvGuROQYoGBc+WNXUzQePNqMfriMn+yOaTx4tFn4szIr/0f5D1yB0iClsG6VAAAAAElFTkSuQmCC"
													style="width: 30px; height: 30px; float: sticky; margin-top: 25px;">
											</c:otherwise>
										</c:choose>
										<a
											href="https://www.youtube.com/channel/${MemberList[i].member.channelId}"
											target="_blank"> <img
											style="width =: 30px; height: 30px; margin-left: 10px; margin-top: 25px;"
											src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAADAAAAAwCAYAAABXAvmHAAAABmJLR0QA/wD/AP+gvaeTAAAEZ0lEQVRoge3Y32tbZRzH8fdz0nZNujZt58Sta2WTiQiCF/5gCDo2nAgiwxtlAxGd/8OYQ+cYbojOCxWc80aQ3QiCgsPRjVbETZx6oV4IbnOUbh3WtsmapmmT8/14kZPY7LQuOUm1sHxvknPOk/O8Puf7HE4SaFazmtWsZt3K5aoZNP70i53tbq7foX4n6wP6Dfow9QLdSN0S3aBORCsSoITEKiQEs07KSQA2h9w0kEKWkkg5NC5pDGPE4Y/mfV3JWedI/7lPZyMFSD+1a3PM0x6c2wFsBJIARRhIAgEIpGB3sK+ID16K4yvHLLZvic+hCUkX8fWVtfDB2m9Ojd00QGbnrhcQ7wOJigP/NV4K5iqPmTSz59d+f/rLJQNkdu7ejnQKiK0wPCqeY8bz2NJ77vQvJZpX6dShFYwH0eEXbP+iHcg+s3uD+Rqp6MrKwpeO5zKrrWfj8HCuogPm655o+OD8EnkZBbPlxANq77xuG0vMcgDn2BTtyhePZf0CuQfuJ3vfvWT8PGa2HPjitsXuLlFbFpg3Rbnypfdzvs+dr+/DtbaSPnWGqfeOkcjM0ua8xuIlfNi8eAdqwlcuEZNwra0AJJ/YzoaPj5Hf8mDQDTUMH2yHA2C2Piq+PGZBtfT20PfGq3S9tpd0YhVz8huDFzjUHwogud668KoMUKqubY/S/8lx8lseIlPIY+VzR8MjgbE2HAB1Nxq/sBsbjhwgeXAf6UScnPnR8Qjh3xYKgOioC3+TEABd2x9j4MRH+I88TKZQwGS14yUwtzocALXVg6/CDwTdePMgyUP7SXckyJvVhi/O3R4OILXVh68yQVDJx7cycOI42UQC1YIvHgsHqBtfm39B1YwHlA8FAM3Xha92DQWVHhxi5LmXiE/P4GrBF7dTpfOUn8SIeYLWRMNXF6AwMcnY4aPY0Ld0eg7PURu+OP9iATQDdEXFV9OA9OAQ44ffITGdIe5VfsWoAY+k6+EAMCVpXWT8vwQoTEwxdvhtbPgsSc/hcPXgQZoKBZBssoyoGb+0Pj04zPiRoySmZ0h4Xu03bBi/xBIyXcW56PgbMpSv+tdnSXoeHq5BeHDiWiiAw/tDiv5jBAnN53FtraRODjLx1rvEZ2ZIeLF/AA3AI+E7XQwFMOdfwkprsza8JOKeY3TvAZSbRz/8RJfn8PAajhfCK3BpkSUUuwR+JDwS7S5G4ex5QLR4XiWogXgkTK7cgfKDzC/ot2C2mvHFdSlaXHBFlhGPyGVjqcuhAGuGPxsFvouCv2GC5cTjTJ9vvnBhLhSgSNYrEoWVikfKOK9waKG5IkDPmS+GEHswsisOb5rwsWfvuPjzrwvNi/65m9r25F1m3suY24FsE5D8n/CTGL87OBkz78PbL5+/dqO1qr/X/9y6dXXMjw9gfp98r885DUi2DrQG0YMpKVM3TnFERwBqR8QDfFbSXHCzZ3xp1kkpnEs7s5Rhf2EaQ27EoVHDrpBhZP3VH7PV+JrVrGY1q1m3bv0NDRMeqgk0OuwAAAAASUVORK5CYII="
											alt=""></a> <a
											href="https://twitter.com/${MemberList[i].member.twitterId}"
											target="_blank"> <img
											style="width =: 30px; height: 30px; margin-left: 10px; margin-top: 25px;"
											src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAADAAAAAwCAYAAABXAvmHAAAABmJLR0QA/wD/AP+gvaeTAAADz0lEQVRoge2XTWgdVRiGn+/MpGnv3LRoqC4UhCz8I8RFRClSXdgqWkuV4CRpi1gqglZTuhFXkiDdCVIKBfEHo1Bzr0JRtGAqWhTBQhsaFX9ADbZisbXaJnPb5t6Z+VyotU0yc89MYlGYZzcz73fO+84ZzjcHCgoKCgoK/sfIJZ2tOnmdq+ZxYLXCNUCowvdG9b3QNbvo8Y7NLFm0O+iqry9/njRk0wDOSO2e6JvS+wxKnNv4oBr3hmBIkacBN8FKgLIt6vNe4u0Tbc65xXch8gSxfBn1eU/mC1A9Xna09JPAcNhb3prXvzMy9QIij1rKDwFdQAtwLJKoE3/Zb0likzqxercDyxQGnJHaLqrqWLv+e4xqsD6DeYBu/jR/0gj30lB13wjuTBKnBlCJO85fiD7maG0P1dOXW1tRFWJ91lr/DyHI/ljZ4bjud8bheJIwNQA66/laR51xtxqstnHRUjlzMyIdzZWzcEF7gFsQ2VT3y18kCVMDCGZijttXqzLqVKb28Nbk9Wn1Mdpp53dOfhXiVZHvvZMmSg0QLT6zHySY+6nc70TmK6cSvOtUamvZq60zFSralsXxDAbC3qWfNhMlbGl/sW75lFSCVxQGEhQCrAFd40zVJqnU9in6mREdC018VCJJ3D2aojptI2veyF5Tz22tjSlcm9tMDkS5O+wrjzbTpW+jI8EGZ1GtR2LpUxhfOHvNMYZZXXkuUj8hFW0XZEcsisDZhbFmhdbPeT/YCNNXQOTjCy6XzMtSBgS+5iGp2WhTAzT88mGEAwtjyx5FP7HVpjcywCBbgMa8HGXGpO79FymbCRq+dwjVDVy6ECcjKX1gK24aACDqa3vTqNyGcDC/LztEeRFf6rZ6qwAAsXAVyCDKq4BVk8nB2VBlZ5aC9E58MatQ3fJvnuEEdtLv/ZylxnoFIomHgF8yu7LnSNiY3p61yDoAftsJE5t1wO9ZJ7EgFuERNrZPZi20DwA0+ksHIie6Ffgw60RpqMhQ6Jf35anN/UW3VGvdkXKfiK5ESTzyWTAc+d4mRDRPcaYVuJDGg6UxgaMo3XnHAIYj8TbnNQ95VmCvtjpBrV9hmyhdOedVRZ6J/dL2+ZiHlAAtI8FNGHFVY0+FK1SlQ+AOYCUwn5PWhKCbw962j+YxxnkS+0CjtfGjW295SpGtKKUF2P5PK/JcPF163vZP04bmvnYHVxqHjcDDApkP6QrjqL4ct4av88Blp/KYTCPbi61O3ehgVhDrCgydxLockXZgKXAKZRLDBKrfouZgZMwo/pIjC226oKCgoKCg4L/CH/2pQ2x506tNAAAAAElFTkSuQmCC"
											alt=""></a>
									</div>
									<p class="m-1" style="font-size: 20px">${MemberList[i].member.krName}</p>
								</div>
							</div>
						</c:forEach>
					</div>
				</div>
				<div class="card">
					<div class="card-header" id="headingThree">
						<h2 class="mb-0">
							<button type="button" class="btn btn-link collapsed"
								data-toggle="collapse" data-target="#engen1">
								<i class="fa fa-plus"></i> EN 1st Generation
							</button>
						</h2>
					</div>
					<div id="engen1" class="collapse" aria-labelledby="headingThree"
						data-parent="#accordionExample">
						<c:forEach var="i" begin="35" end="40">
							<div class="d-flex flex-row border">
								<div class="order-1 p-1">
									<a
										href="https://www.youtube.com/channel/${MemberList[i].member.channelId}"
										target="_blank"> <img
										style="width: 80px; height: 80px; border-radius: 70px;"
										class="card-img-top" src="${MemberList[i].member.profileUrl}">
									</a>
								</div>
								<div class="order-2 p-1">
									<div
										class="btn-group float-right d-flex justify-content-between"
										role="group" aria-label="Basic example">
										<c:choose>
											<c:when
												test="${fn:contains(sessionScope.favorite,MemberList[i].member.krName) }">
												<img id="${MemberList[i].member.krName}"
													onclick="damaY('${MemberList[i].member.krName}')"
													src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAADAAAAAwCAYAAABXAvmHAAAABmJLR0QA/wD/AP+gvaeTAAAEoElEQVRoge2Z3W8UZRTGf2eWtlBEgtJu+dIQGhED8iEsCbAbqiYSolxqIglcGk0oiNyZGLjwjiuIfwAYb42JIaBeEGMw8YOYFjEkRAhSoFAt0m7blLLv48XutjPb2e7OMqOJ6bnYd949857nOXOeOfPOLszarM1aYqbLHRn92rElSQxLKrB60u2k7DoABa209XfvJYHjJRG0GNneA1oRraXjRCyRCuhqZwvj+RtI6eIXDJBveta29Y3FjZVMBcZH9vnIA7Qxf2JvElCxJyBhyB1ClMgLJEBHpPgrHn8FLnXsQrwAFImXE5FW09v2WtxwCUhIh4uDStPShwDH+3GjxVpS9aTXgnon4/rJQykpb4NtutcTF2a8FZA+AKwkGaaTB1Q4GCdkbBVQT7oddAMxN0AcKuU0jmylbf7zThy48VVA7sA08lLYvdACvBsXbCwV0PfL59E6/geweLpkJj/8iQ3S3PSMrb878rjYkROQMH5rS1PQMpRaClqO2I6013/SFOFqcrLPwF0A+nDuNl7zLbYM3DULnB09AV1qX0UqtQyxAqclYMtRYRnYUmAFUgfQFEpQPuwIPk35JhD9wE2k20K3PNSHszuYu4lL9Vn2wbWqCejy0mPIfRQA8Q01ZNGQT6o4N7RzTflMOmrZ/LHyN3P8CSB3DRDCgqX3B62YhxGs06fo6wTedT/lQBeytf2nkO0HTQQ7SRXy4V2mpk9SdfLV1xVMvGPZodMBzoSYetOvAp8jLQgE8g3/lmRKMUZN3puWGzpTybVqF9IvHVvw3BlE238oGYBBE3ssN3whjOeMbVSX2ldR0DlEZwAkDKi+LhNpHeKGFdhlXcNXqnGs+RzQj20dNHEWaUMAxDfUL5mZ1k1L7LIVCrusa6xvJn41txKWGeinmSzYN4ErVI28zxcqmarrAuS/tfGm7bXIQ4Qnsa52tjD09ymktwIEKgn6iYf46pDhFzYn/7Zto67350hbCQnj4uLjyB0OEPAPjUsGGZ94O/LdZrh6OTW0mdNPi04gOxBTlymSh5OpXL47Kpc5tU8JMZGPUTJlG26ESmMJYFvL4I8jGb/P0NZGmER+oZHwkDYXjxvuMmG+jI5G5xP9jeyHp56X9GQDe5kpn0J9C+h6YnXyCchlJslVfXGvQr7sK88rfU6ZqHQiJ+A8ZWKRTHnuO3blixPBIt/E5iwTucvUcRODMEeyFdB55oLWhUtmmpwGDbrN0Q0MVq8IU9UyXixiJJQALQs2IZqnk/DJSTiJTy3FGsvlT9rO/EnzUp2CE4hHNeTUTGHexuQSIJWZscug84bbmMoN77Pt+cl/ZCz74H5q58hBw1sHnA2XWmnuot0HkRJwlR1oUhZ203D7vWz+ZcuN9FZbb13DV7yu0d0m9iB+nyLPZDJOllwCBpmKqzciZ8fs0dBzlh05PeNif5xXRr+0hWNrTO4QMOSXk1m0Vlr/dvq7hYtk+gtkCCc45anwoeVGH+s3Tp1rXeJSjz422X7AQ8gmxp+217lfz/r6E/gqPV+toxeBfjPviO148HOjpEPjf920WfKOg9L28OFL9gajccaftVn7v9o/fzB7l3fCLDkAAAAASUVORK5CYII="
													style="width: 30px; height: 30px; float: sticky; margin-top: 25px;">
											</c:when>
											<c:otherwise>
												<img id="${MemberList[i].member.krName}"
													onclick="damaY('${MemberList[i].member.krName}')"
													src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAADAAAAAwCAYAAABXAvmHAAAABmJLR0QA/wD/AP+gvaeTAAAFWElEQVRoge2YS4xTZRTHf6ftEGAGBMZHSDDBzHTaTpGMA23HSCAkJi7EhQTZmBAXCAswLkwEJCIuSIaNCzUkggsTDZOIO/AJBlEe007BkVimnbYBowkmBiVmRnm033ExpfTedmZ6O7cbM2d17znf+Z//+c79HufCrMzKrDRNNBFcp4ngumbG8DUTHNgHqsCZZgWQZgFrPPgkwvmJF89aiV35oRlxPM0ALSHvLz+L2dusME2pgCa7YxgzaI2kaySSOed2rOZUoFjcV62UPc0I5XoFNBnqxWiyNraJSnR0yM147lfA6FtMNjHqdX0tuFoBTYR7oHhpClzFEJG+9EW3YrpcgeKbWMmfAb6veBc8uLoWXKuAJrrDYC5jmRTP04gKqicrh2K0R/oyl92I62IFdJ8N74JEr3wrkZFTqJyt0Ase3nArqisJ6AV/CHSTVcnb5WcxB6we8oIOhVa4EdvxJ6TxYDsqfrz4UbpAO4EY8FgFbEKiIzGLXyIUB41WqK4CcZAcwihFsohmJZa+MeME9MeeRdz9x496OhH8QBeIv0R2yfRZ8pzE0icsqnhwA8LxOjj9CZIDzQKjKFnE5GiZn5Unhm9OmYDGgwcQXgYeqiPQZOyHiWR6RVCLVhGGApdAehrH5g+UIxJLl88T6xrwth4AhmcQ4DrCfjt5ABEUYT9wfQb4wyWO93HtI/T08rm0zf0M5dkaAEXgV9A8SB6VPKI51ORpa8lLODVWDwtNhdsYu9uBeDpQ6US0A7QDpAN4FPBWOQmfM3Zrk6y/dmvKBEoB5jBeHAA22kD+Qs0zbt9nynEnTvKTwIM20wkWFzaJP3fb7lNzG5Vw6g7X0ptBPrFGYDHIN5rsjtXym4loMtQLxVNUkZdP8bRurEUepjgHZDNFro28BHxksyzCmK91MNQ3U9L3RAeDqzB6Emi3Ghhg/JEXZfXFu5PynBZcEYaC7wE7bKZxhA0SSX/XCOky/lDgKVS+ABbaLB8SyWwXwUzlP+1JLIISSb8CeshmasVwXBOhtU5JlykmQmsx8hXV5A8RyWybjjzUeZWYSCKzE+Edq4E20C91MLC+ftolismuNaAnJjAslkNEMjtrbcW1pO67kAgqkfRrQL/NNB+PvF4vTlmMZy+wwKbtl2hmR73koYHLnETTe1AGrEr9ySlOlY8yING0416h0dtoi+XNiPMEqn1aao6bRhpLQHjc8u7lZ8cYqikbZkPXa8cJ6Onlc4HOClWBBwqjNcfGg10aD3bVBGovZoBChcZfwnYkzivQ2hqk8q4ikrWfkjrYuUwTgSMIKYSUJgJHdLBzWeUY8eduI5KtUHlL2I7EeQJirJ+Puf8p6PnwEh0K9OPxjYJsZeLnsQ9kKx5fXhPBD/Rcx8NlX9UrVvCC48+ogTVgwjZFSpOr5ms8tAtfIY/KLmBeDcc5wDZ8LXkdCvTr2cACwLoOEDv2tNLA73WxzpKwEjOeQ1haV4cqtKGyizlsAWz/T22bQx3iPAHDChvP5ycZeQPRgwClqrTb7EurfI3znchRU6+DnQvx+G5O4zeO6Pv45vXf62EnGhizA9E9wANThcAUFklf7u96OTlbAx7fCiYnfwc4DN5OiWR2VzbgEk6NSWzkIEpHqSr/ToIhiM/ROnCWQO3D5i6qH6MalGh6u0RTv0/qHkvfkEhmN6bQBbwLVDcpDg80ZwkolbNjEDmGkbDEMlsklrlaL4z05X6TaPpVfBIADjPRa9+zNrEClGfnFOJZLZGRzdI3kp3SYwqR3pFfJJrejvGuROQYoGBc+WNXUzQePNqMfriMn+yOaTx4tFn4szIr/0f5D1yB0iClsG6VAAAAAElFTkSuQmCC"
													style="width: 30px; height: 30px; float: sticky; margin-top: 25px;">
											</c:otherwise>
										</c:choose>
										<a
											href="https://www.youtube.com/channel/${MemberList[i].member.channelId}"
											target="_blank"> <img
											style="width =: 30px; height: 30px; margin-left: 10px; margin-top: 25px;"
											src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAADAAAAAwCAYAAABXAvmHAAAABmJLR0QA/wD/AP+gvaeTAAAEZ0lEQVRoge3Y32tbZRzH8fdz0nZNujZt58Sta2WTiQiCF/5gCDo2nAgiwxtlAxGd/8OYQ+cYbojOCxWc80aQ3QiCgsPRjVbETZx6oV4IbnOUbh3WtsmapmmT8/14kZPY7LQuOUm1sHxvknPOk/O8Puf7HE4SaFazmtWsZt3K5aoZNP70i53tbq7foX4n6wP6Dfow9QLdSN0S3aBORCsSoITEKiQEs07KSQA2h9w0kEKWkkg5NC5pDGPE4Y/mfV3JWedI/7lPZyMFSD+1a3PM0x6c2wFsBJIARRhIAgEIpGB3sK+ID16K4yvHLLZvic+hCUkX8fWVtfDB2m9Ojd00QGbnrhcQ7wOJigP/NV4K5iqPmTSz59d+f/rLJQNkdu7ejnQKiK0wPCqeY8bz2NJ77vQvJZpX6dShFYwH0eEXbP+iHcg+s3uD+Rqp6MrKwpeO5zKrrWfj8HCuogPm655o+OD8EnkZBbPlxANq77xuG0vMcgDn2BTtyhePZf0CuQfuJ3vfvWT8PGa2HPjitsXuLlFbFpg3Rbnypfdzvs+dr+/DtbaSPnWGqfeOkcjM0ua8xuIlfNi8eAdqwlcuEZNwra0AJJ/YzoaPj5Hf8mDQDTUMH2yHA2C2Piq+PGZBtfT20PfGq3S9tpd0YhVz8huDFzjUHwogud668KoMUKqubY/S/8lx8lseIlPIY+VzR8MjgbE2HAB1Nxq/sBsbjhwgeXAf6UScnPnR8Qjh3xYKgOioC3+TEABd2x9j4MRH+I88TKZQwGS14yUwtzocALXVg6/CDwTdePMgyUP7SXckyJvVhi/O3R4OILXVh68yQVDJx7cycOI42UQC1YIvHgsHqBtfm39B1YwHlA8FAM3Xha92DQWVHhxi5LmXiE/P4GrBF7dTpfOUn8SIeYLWRMNXF6AwMcnY4aPY0Ld0eg7PURu+OP9iATQDdEXFV9OA9OAQ44ffITGdIe5VfsWoAY+k6+EAMCVpXWT8vwQoTEwxdvhtbPgsSc/hcPXgQZoKBZBssoyoGb+0Pj04zPiRoySmZ0h4Xu03bBi/xBIyXcW56PgbMpSv+tdnSXoeHq5BeHDiWiiAw/tDiv5jBAnN53FtraRODjLx1rvEZ2ZIeLF/AA3AI+E7XQwFMOdfwkprsza8JOKeY3TvAZSbRz/8RJfn8PAajhfCK3BpkSUUuwR+JDwS7S5G4ex5QLR4XiWogXgkTK7cgfKDzC/ot2C2mvHFdSlaXHBFlhGPyGVjqcuhAGuGPxsFvouCv2GC5cTjTJ9vvnBhLhSgSNYrEoWVikfKOK9waKG5IkDPmS+GEHswsisOb5rwsWfvuPjzrwvNi/65m9r25F1m3suY24FsE5D8n/CTGL87OBkz78PbL5+/dqO1qr/X/9y6dXXMjw9gfp98r885DUi2DrQG0YMpKVM3TnFERwBqR8QDfFbSXHCzZ3xp1kkpnEs7s5Rhf2EaQ27EoVHDrpBhZP3VH7PV+JrVrGY1q1m3bv0NDRMeqgk0OuwAAAAASUVORK5CYII="
											alt=""></a> <a
											href="https://twitter.com/${MemberList[i].member.twitterId}"
											target="_blank"> <img
											style="width =: 30px; height: 30px; margin-left: 10px; margin-top: 25px;"
											src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAADAAAAAwCAYAAABXAvmHAAAABmJLR0QA/wD/AP+gvaeTAAADz0lEQVRoge2XTWgdVRiGn+/MpGnv3LRoqC4UhCz8I8RFRClSXdgqWkuV4CRpi1gqglZTuhFXkiDdCVIKBfEHo1Bzr0JRtGAqWhTBQhsaFX9ADbZisbXaJnPb5t6Z+VyotU0yc89MYlGYZzcz73fO+84ZzjcHCgoKCgoK/sfIJZ2tOnmdq+ZxYLXCNUCowvdG9b3QNbvo8Y7NLFm0O+iqry9/njRk0wDOSO2e6JvS+wxKnNv4oBr3hmBIkacBN8FKgLIt6vNe4u0Tbc65xXch8gSxfBn1eU/mC1A9Xna09JPAcNhb3prXvzMy9QIij1rKDwFdQAtwLJKoE3/Zb0likzqxercDyxQGnJHaLqrqWLv+e4xqsD6DeYBu/jR/0gj30lB13wjuTBKnBlCJO85fiD7maG0P1dOXW1tRFWJ91lr/DyHI/ljZ4bjud8bheJIwNQA66/laR51xtxqstnHRUjlzMyIdzZWzcEF7gFsQ2VT3y18kCVMDCGZijttXqzLqVKb28Nbk9Wn1Mdpp53dOfhXiVZHvvZMmSg0QLT6zHySY+6nc70TmK6cSvOtUamvZq60zFSralsXxDAbC3qWfNhMlbGl/sW75lFSCVxQGEhQCrAFd40zVJqnU9in6mREdC018VCJJ3D2aojptI2veyF5Tz22tjSlcm9tMDkS5O+wrjzbTpW+jI8EGZ1GtR2LpUxhfOHvNMYZZXXkuUj8hFW0XZEcsisDZhbFmhdbPeT/YCNNXQOTjCy6XzMtSBgS+5iGp2WhTAzT88mGEAwtjyx5FP7HVpjcywCBbgMa8HGXGpO79FymbCRq+dwjVDVy6ECcjKX1gK24aACDqa3vTqNyGcDC/LztEeRFf6rZ6qwAAsXAVyCDKq4BVk8nB2VBlZ5aC9E58MatQ3fJvnuEEdtLv/ZylxnoFIomHgF8yu7LnSNiY3p61yDoAftsJE5t1wO9ZJ7EgFuERNrZPZi20DwA0+ksHIie6Ffgw60RpqMhQ6Jf35anN/UW3VGvdkXKfiK5ESTzyWTAc+d4mRDRPcaYVuJDGg6UxgaMo3XnHAIYj8TbnNQ95VmCvtjpBrV9hmyhdOedVRZ6J/dL2+ZiHlAAtI8FNGHFVY0+FK1SlQ+AOYCUwn5PWhKCbw962j+YxxnkS+0CjtfGjW295SpGtKKUF2P5PK/JcPF163vZP04bmvnYHVxqHjcDDApkP6QrjqL4ct4av88Blp/KYTCPbi61O3ehgVhDrCgydxLockXZgKXAKZRLDBKrfouZgZMwo/pIjC226oKCgoKCg4L/CH/2pQ2x506tNAAAAAElFTkSuQmCC"
											alt=""></a>
									</div>
									<p class="m-1" style="font-size: 20px">${MemberList[i].member.krName}</p>
								</div>
							</div>
						</c:forEach>
					</div>
				</div>
				<div class="card">
					<div class="card-header" id="headingThree">
						<h2 class="mb-0">
							<button type="button" class="btn btn-link collapsed"
								data-toggle="collapse" data-target="#engen2">
								<i class="fa fa-plus"></i> EN 2st Generation
							</button>
						</h2>
					</div>
					<div id="engen2" class="collapse" aria-labelledby="headingThree"
						data-parent="#accordionExample">
						<c:forEach var="i" begin="41" end="44">
							<div class="d-flex flex-row border">
								<div class="order-1 p-1">
									<a
										href="https://www.youtube.com/channel/${MemberList[i].member.channelId}"
										target="_blank"> <img
										style="width: 80px; height: 80px; border-radius: 70px;"
										class="card-img-top" src="${MemberList[i].member.profileUrl}">
									</a>
								</div>
								<div class="order-2 p-1">
									<div
										class="btn-group float-right d-flex justify-content-between"
										role="group" aria-label="Basic example">
										<c:choose>
											<c:when
												test="${fn:contains(sessionScope.favorite,MemberList[i].member.krName) }">
												<img id="${MemberList[i].member.krName}"
													onclick="damaY('${MemberList[i].member.krName}')"
													src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAADAAAAAwCAYAAABXAvmHAAAABmJLR0QA/wD/AP+gvaeTAAAEoElEQVRoge2Z3W8UZRTGf2eWtlBEgtJu+dIQGhED8iEsCbAbqiYSolxqIglcGk0oiNyZGLjwjiuIfwAYb42JIaBeEGMw8YOYFjEkRAhSoFAt0m7blLLv48XutjPb2e7OMqOJ6bnYd949857nOXOeOfPOLszarM1aYqbLHRn92rElSQxLKrB60u2k7DoABa209XfvJYHjJRG0GNneA1oRraXjRCyRCuhqZwvj+RtI6eIXDJBveta29Y3FjZVMBcZH9vnIA7Qxf2JvElCxJyBhyB1ClMgLJEBHpPgrHn8FLnXsQrwAFImXE5FW09v2WtxwCUhIh4uDStPShwDH+3GjxVpS9aTXgnon4/rJQykpb4NtutcTF2a8FZA+AKwkGaaTB1Q4GCdkbBVQT7oddAMxN0AcKuU0jmylbf7zThy48VVA7sA08lLYvdACvBsXbCwV0PfL59E6/geweLpkJj/8iQ3S3PSMrb878rjYkROQMH5rS1PQMpRaClqO2I6013/SFOFqcrLPwF0A+nDuNl7zLbYM3DULnB09AV1qX0UqtQyxAqclYMtRYRnYUmAFUgfQFEpQPuwIPk35JhD9wE2k20K3PNSHszuYu4lL9Vn2wbWqCejy0mPIfRQA8Q01ZNGQT6o4N7RzTflMOmrZ/LHyN3P8CSB3DRDCgqX3B62YhxGs06fo6wTedT/lQBeytf2nkO0HTQQ7SRXy4V2mpk9SdfLV1xVMvGPZodMBzoSYetOvAp8jLQgE8g3/lmRKMUZN3puWGzpTybVqF9IvHVvw3BlE238oGYBBE3ssN3whjOeMbVSX2ldR0DlEZwAkDKi+LhNpHeKGFdhlXcNXqnGs+RzQj20dNHEWaUMAxDfUL5mZ1k1L7LIVCrusa6xvJn41txKWGeinmSzYN4ErVI28zxcqmarrAuS/tfGm7bXIQ4Qnsa52tjD09ymktwIEKgn6iYf46pDhFzYn/7Zto67350hbCQnj4uLjyB0OEPAPjUsGGZ94O/LdZrh6OTW0mdNPi04gOxBTlymSh5OpXL47Kpc5tU8JMZGPUTJlG26ESmMJYFvL4I8jGb/P0NZGmER+oZHwkDYXjxvuMmG+jI5G5xP9jeyHp56X9GQDe5kpn0J9C+h6YnXyCchlJslVfXGvQr7sK88rfU6ZqHQiJ+A8ZWKRTHnuO3blixPBIt/E5iwTucvUcRODMEeyFdB55oLWhUtmmpwGDbrN0Q0MVq8IU9UyXixiJJQALQs2IZqnk/DJSTiJTy3FGsvlT9rO/EnzUp2CE4hHNeTUTGHexuQSIJWZscug84bbmMoN77Pt+cl/ZCz74H5q58hBw1sHnA2XWmnuot0HkRJwlR1oUhZ203D7vWz+ZcuN9FZbb13DV7yu0d0m9iB+nyLPZDJOllwCBpmKqzciZ8fs0dBzlh05PeNif5xXRr+0hWNrTO4QMOSXk1m0Vlr/dvq7hYtk+gtkCCc45anwoeVGH+s3Tp1rXeJSjz422X7AQ8gmxp+217lfz/r6E/gqPV+toxeBfjPviO148HOjpEPjf920WfKOg9L28OFL9gajccaftVn7v9o/fzB7l3fCLDkAAAAASUVORK5CYII="
													style="width: 30px; height: 30px; float: sticky; margin-top: 25px;">
											</c:when>
											<c:otherwise>
												<img id="${MemberList[i].member.krName}"
													onclick="damaY('${MemberList[i].member.krName}')"
													src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAADAAAAAwCAYAAABXAvmHAAAABmJLR0QA/wD/AP+gvaeTAAAFWElEQVRoge2YS4xTZRTHf6ftEGAGBMZHSDDBzHTaTpGMA23HSCAkJi7EhQTZmBAXCAswLkwEJCIuSIaNCzUkggsTDZOIO/AJBlEe007BkVimnbYBowkmBiVmRnm033ExpfTedmZ6O7cbM2d17znf+Z//+c79HufCrMzKrDRNNBFcp4ngumbG8DUTHNgHqsCZZgWQZgFrPPgkwvmJF89aiV35oRlxPM0ALSHvLz+L2dusME2pgCa7YxgzaI2kaySSOed2rOZUoFjcV62UPc0I5XoFNBnqxWiyNraJSnR0yM147lfA6FtMNjHqdX0tuFoBTYR7oHhpClzFEJG+9EW3YrpcgeKbWMmfAb6veBc8uLoWXKuAJrrDYC5jmRTP04gKqicrh2K0R/oyl92I62IFdJ8N74JEr3wrkZFTqJyt0Ase3nArqisJ6AV/CHSTVcnb5WcxB6we8oIOhVa4EdvxJ6TxYDsqfrz4UbpAO4EY8FgFbEKiIzGLXyIUB41WqK4CcZAcwihFsohmJZa+MeME9MeeRdz9x496OhH8QBeIv0R2yfRZ8pzE0icsqnhwA8LxOjj9CZIDzQKjKFnE5GiZn5Unhm9OmYDGgwcQXgYeqiPQZOyHiWR6RVCLVhGGApdAehrH5g+UIxJLl88T6xrwth4AhmcQ4DrCfjt5ABEUYT9wfQb4wyWO93HtI/T08rm0zf0M5dkaAEXgV9A8SB6VPKI51ORpa8lLODVWDwtNhdsYu9uBeDpQ6US0A7QDpAN4FPBWOQmfM3Zrk6y/dmvKBEoB5jBeHAA22kD+Qs0zbt9nynEnTvKTwIM20wkWFzaJP3fb7lNzG5Vw6g7X0ptBPrFGYDHIN5rsjtXym4loMtQLxVNUkZdP8bRurEUepjgHZDNFro28BHxksyzCmK91MNQ3U9L3RAeDqzB6Emi3Ghhg/JEXZfXFu5PynBZcEYaC7wE7bKZxhA0SSX/XCOky/lDgKVS+ABbaLB8SyWwXwUzlP+1JLIISSb8CeshmasVwXBOhtU5JlykmQmsx8hXV5A8RyWybjjzUeZWYSCKzE+Edq4E20C91MLC+ftolismuNaAnJjAslkNEMjtrbcW1pO67kAgqkfRrQL/NNB+PvF4vTlmMZy+wwKbtl2hmR73koYHLnETTe1AGrEr9ySlOlY8yING0416h0dtoi+XNiPMEqn1aao6bRhpLQHjc8u7lZ8cYqikbZkPXa8cJ6Onlc4HOClWBBwqjNcfGg10aD3bVBGovZoBChcZfwnYkzivQ2hqk8q4ikrWfkjrYuUwTgSMIKYSUJgJHdLBzWeUY8eduI5KtUHlL2I7EeQJirJ+Puf8p6PnwEh0K9OPxjYJsZeLnsQ9kKx5fXhPBD/Rcx8NlX9UrVvCC48+ogTVgwjZFSpOr5ms8tAtfIY/KLmBeDcc5wDZ8LXkdCvTr2cACwLoOEDv2tNLA73WxzpKwEjOeQ1haV4cqtKGyizlsAWz/T22bQx3iPAHDChvP5ycZeQPRgwClqrTb7EurfI3znchRU6+DnQvx+G5O4zeO6Pv45vXf62EnGhizA9E9wANThcAUFklf7u96OTlbAx7fCiYnfwc4DN5OiWR2VzbgEk6NSWzkIEpHqSr/ToIhiM/ROnCWQO3D5i6qH6MalGh6u0RTv0/qHkvfkEhmN6bQBbwLVDcpDg80ZwkolbNjEDmGkbDEMlsklrlaL4z05X6TaPpVfBIADjPRa9+zNrEClGfnFOJZLZGRzdI3kp3SYwqR3pFfJJrejvGuROQYoGBc+WNXUzQePNqMfriMn+yOaTx4tFn4szIr/0f5D1yB0iClsG6VAAAAAElFTkSuQmCC"
													style="width: 30px; height: 30px; float: sticky; margin-top: 25px;">
											</c:otherwise>
										</c:choose>
										<a
											href="https://www.youtube.com/channel/${MemberList[i].member.channelId}"
											target="_blank"> <img
											style="width =: 30px; height: 30px; margin-left: 10px; margin-top: 25px;"
											src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAADAAAAAwCAYAAABXAvmHAAAABmJLR0QA/wD/AP+gvaeTAAAEZ0lEQVRoge3Y32tbZRzH8fdz0nZNujZt58Sta2WTiQiCF/5gCDo2nAgiwxtlAxGd/8OYQ+cYbojOCxWc80aQ3QiCgsPRjVbETZx6oV4IbnOUbh3WtsmapmmT8/14kZPY7LQuOUm1sHxvknPOk/O8Puf7HE4SaFazmtWsZt3K5aoZNP70i53tbq7foX4n6wP6Dfow9QLdSN0S3aBORCsSoITEKiQEs07KSQA2h9w0kEKWkkg5NC5pDGPE4Y/mfV3JWedI/7lPZyMFSD+1a3PM0x6c2wFsBJIARRhIAgEIpGB3sK+ID16K4yvHLLZvic+hCUkX8fWVtfDB2m9Ojd00QGbnrhcQ7wOJigP/NV4K5iqPmTSz59d+f/rLJQNkdu7ejnQKiK0wPCqeY8bz2NJ77vQvJZpX6dShFYwH0eEXbP+iHcg+s3uD+Rqp6MrKwpeO5zKrrWfj8HCuogPm655o+OD8EnkZBbPlxANq77xuG0vMcgDn2BTtyhePZf0CuQfuJ3vfvWT8PGa2HPjitsXuLlFbFpg3Rbnypfdzvs+dr+/DtbaSPnWGqfeOkcjM0ua8xuIlfNi8eAdqwlcuEZNwra0AJJ/YzoaPj5Hf8mDQDTUMH2yHA2C2Piq+PGZBtfT20PfGq3S9tpd0YhVz8huDFzjUHwogud668KoMUKqubY/S/8lx8lseIlPIY+VzR8MjgbE2HAB1Nxq/sBsbjhwgeXAf6UScnPnR8Qjh3xYKgOioC3+TEABd2x9j4MRH+I88TKZQwGS14yUwtzocALXVg6/CDwTdePMgyUP7SXckyJvVhi/O3R4OILXVh68yQVDJx7cycOI42UQC1YIvHgsHqBtfm39B1YwHlA8FAM3Xha92DQWVHhxi5LmXiE/P4GrBF7dTpfOUn8SIeYLWRMNXF6AwMcnY4aPY0Ld0eg7PURu+OP9iATQDdEXFV9OA9OAQ44ffITGdIe5VfsWoAY+k6+EAMCVpXWT8vwQoTEwxdvhtbPgsSc/hcPXgQZoKBZBssoyoGb+0Pj04zPiRoySmZ0h4Xu03bBi/xBIyXcW56PgbMpSv+tdnSXoeHq5BeHDiWiiAw/tDiv5jBAnN53FtraRODjLx1rvEZ2ZIeLF/AA3AI+E7XQwFMOdfwkprsza8JOKeY3TvAZSbRz/8RJfn8PAajhfCK3BpkSUUuwR+JDwS7S5G4ex5QLR4XiWogXgkTK7cgfKDzC/ot2C2mvHFdSlaXHBFlhGPyGVjqcuhAGuGPxsFvouCv2GC5cTjTJ9vvnBhLhSgSNYrEoWVikfKOK9waKG5IkDPmS+GEHswsisOb5rwsWfvuPjzrwvNi/65m9r25F1m3suY24FsE5D8n/CTGL87OBkz78PbL5+/dqO1qr/X/9y6dXXMjw9gfp98r885DUi2DrQG0YMpKVM3TnFERwBqR8QDfFbSXHCzZ3xp1kkpnEs7s5Rhf2EaQ27EoVHDrpBhZP3VH7PV+JrVrGY1q1m3bv0NDRMeqgk0OuwAAAAASUVORK5CYII="
											alt=""></a> <a
											href="https://twitter.com/${MemberList[i].member.twitterId}"
											target="_blank"> <img
											style="width =: 30px; height: 30px; margin-left: 10px; margin-top: 25px;"
											src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAADAAAAAwCAYAAABXAvmHAAAABmJLR0QA/wD/AP+gvaeTAAADz0lEQVRoge2XTWgdVRiGn+/MpGnv3LRoqC4UhCz8I8RFRClSXdgqWkuV4CRpi1gqglZTuhFXkiDdCVIKBfEHo1Bzr0JRtGAqWhTBQhsaFX9ADbZisbXaJnPb5t6Z+VyotU0yc89MYlGYZzcz73fO+84ZzjcHCgoKCgoK/sfIJZ2tOnmdq+ZxYLXCNUCowvdG9b3QNbvo8Y7NLFm0O+iqry9/njRk0wDOSO2e6JvS+wxKnNv4oBr3hmBIkacBN8FKgLIt6vNe4u0Tbc65xXch8gSxfBn1eU/mC1A9Xna09JPAcNhb3prXvzMy9QIij1rKDwFdQAtwLJKoE3/Zb0likzqxercDyxQGnJHaLqrqWLv+e4xqsD6DeYBu/jR/0gj30lB13wjuTBKnBlCJO85fiD7maG0P1dOXW1tRFWJ91lr/DyHI/ljZ4bjud8bheJIwNQA66/laR51xtxqstnHRUjlzMyIdzZWzcEF7gFsQ2VT3y18kCVMDCGZijttXqzLqVKb28Nbk9Wn1Mdpp53dOfhXiVZHvvZMmSg0QLT6zHySY+6nc70TmK6cSvOtUamvZq60zFSralsXxDAbC3qWfNhMlbGl/sW75lFSCVxQGEhQCrAFd40zVJqnU9in6mREdC018VCJJ3D2aojptI2veyF5Tz22tjSlcm9tMDkS5O+wrjzbTpW+jI8EGZ1GtR2LpUxhfOHvNMYZZXXkuUj8hFW0XZEcsisDZhbFmhdbPeT/YCNNXQOTjCy6XzMtSBgS+5iGp2WhTAzT88mGEAwtjyx5FP7HVpjcywCBbgMa8HGXGpO79FymbCRq+dwjVDVy6ECcjKX1gK24aACDqa3vTqNyGcDC/LztEeRFf6rZ6qwAAsXAVyCDKq4BVk8nB2VBlZ5aC9E58MatQ3fJvnuEEdtLv/ZylxnoFIomHgF8yu7LnSNiY3p61yDoAftsJE5t1wO9ZJ7EgFuERNrZPZi20DwA0+ksHIie6Ffgw60RpqMhQ6Jf35anN/UW3VGvdkXKfiK5ESTzyWTAc+d4mRDRPcaYVuJDGg6UxgaMo3XnHAIYj8TbnNQ95VmCvtjpBrV9hmyhdOedVRZ6J/dL2+ZiHlAAtI8FNGHFVY0+FK1SlQ+AOYCUwn5PWhKCbw962j+YxxnkS+0CjtfGjW295SpGtKKUF2P5PK/JcPF163vZP04bmvnYHVxqHjcDDApkP6QrjqL4ct4av88Blp/KYTCPbi61O3ehgVhDrCgydxLockXZgKXAKZRLDBKrfouZgZMwo/pIjC226oKCgoKCg4L/CH/2pQ2x506tNAAAAAElFTkSuQmCC"
											alt=""></a>
									</div>
									<p class="m-1" style="font-size: 20px">${MemberList[i].member.krName}</p>
								</div>
							</div>
						</c:forEach>
					</div>
				</div>
				<div class="card">
					<div class="card-header" id="headingThree">
						<h2 class="mb-0">
							<button type="button" class="btn btn-link collapsed"
								data-toggle="collapse" data-target="#idgen1">
								<i class="fa fa-plus"></i> ID 1st Generation
							</button>
						</h2>
					</div>
					<div id="idgen1" class="collapse" aria-labelledby="headingThree"
						data-parent="#accordionExample">
						<c:forEach var="i" begin="45" end="47">
							<div class="d-flex flex-row border">
								<div class="order-1 p-1">
									<a
										href="https://www.youtube.com/channel/${MemberList[i].member.channelId}"
										target="_blank"> <img
										style="width: 80px; height: 80px; border-radius: 70px;"
										class="card-img-top" src="${MemberList[i].member.profileUrl}">
									</a>
								</div>
								<div class="order-2 p-1">
									<div
										class="btn-group float-right d-flex justify-content-between"
										role="group" aria-label="Basic example">
										<c:choose>
											<c:when
												test="${fn:contains(sessionScope.favorite,MemberList[i].member.krName) }">
												<img id="${MemberList[i].member.krName}"
													onclick="damaY('${MemberList[i].member.krName}')"
													src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAADAAAAAwCAYAAABXAvmHAAAABmJLR0QA/wD/AP+gvaeTAAAEoElEQVRoge2Z3W8UZRTGf2eWtlBEgtJu+dIQGhED8iEsCbAbqiYSolxqIglcGk0oiNyZGLjwjiuIfwAYb42JIaBeEGMw8YOYFjEkRAhSoFAt0m7blLLv48XutjPb2e7OMqOJ6bnYd949857nOXOeOfPOLszarM1aYqbLHRn92rElSQxLKrB60u2k7DoABa209XfvJYHjJRG0GNneA1oRraXjRCyRCuhqZwvj+RtI6eIXDJBveta29Y3FjZVMBcZH9vnIA7Qxf2JvElCxJyBhyB1ClMgLJEBHpPgrHn8FLnXsQrwAFImXE5FW09v2WtxwCUhIh4uDStPShwDH+3GjxVpS9aTXgnon4/rJQykpb4NtutcTF2a8FZA+AKwkGaaTB1Q4GCdkbBVQT7oddAMxN0AcKuU0jmylbf7zThy48VVA7sA08lLYvdACvBsXbCwV0PfL59E6/geweLpkJj/8iQ3S3PSMrb878rjYkROQMH5rS1PQMpRaClqO2I6013/SFOFqcrLPwF0A+nDuNl7zLbYM3DULnB09AV1qX0UqtQyxAqclYMtRYRnYUmAFUgfQFEpQPuwIPk35JhD9wE2k20K3PNSHszuYu4lL9Vn2wbWqCejy0mPIfRQA8Q01ZNGQT6o4N7RzTflMOmrZ/LHyN3P8CSB3DRDCgqX3B62YhxGs06fo6wTedT/lQBeytf2nkO0HTQQ7SRXy4V2mpk9SdfLV1xVMvGPZodMBzoSYetOvAp8jLQgE8g3/lmRKMUZN3puWGzpTybVqF9IvHVvw3BlE238oGYBBE3ssN3whjOeMbVSX2ldR0DlEZwAkDKi+LhNpHeKGFdhlXcNXqnGs+RzQj20dNHEWaUMAxDfUL5mZ1k1L7LIVCrusa6xvJn41txKWGeinmSzYN4ErVI28zxcqmarrAuS/tfGm7bXIQ4Qnsa52tjD09ymktwIEKgn6iYf46pDhFzYn/7Zto67350hbCQnj4uLjyB0OEPAPjUsGGZ94O/LdZrh6OTW0mdNPi04gOxBTlymSh5OpXL47Kpc5tU8JMZGPUTJlG26ESmMJYFvL4I8jGb/P0NZGmER+oZHwkDYXjxvuMmG+jI5G5xP9jeyHp56X9GQDe5kpn0J9C+h6YnXyCchlJslVfXGvQr7sK88rfU6ZqHQiJ+A8ZWKRTHnuO3blixPBIt/E5iwTucvUcRODMEeyFdB55oLWhUtmmpwGDbrN0Q0MVq8IU9UyXixiJJQALQs2IZqnk/DJSTiJTy3FGsvlT9rO/EnzUp2CE4hHNeTUTGHexuQSIJWZscug84bbmMoN77Pt+cl/ZCz74H5q58hBw1sHnA2XWmnuot0HkRJwlR1oUhZ203D7vWz+ZcuN9FZbb13DV7yu0d0m9iB+nyLPZDJOllwCBpmKqzciZ8fs0dBzlh05PeNif5xXRr+0hWNrTO4QMOSXk1m0Vlr/dvq7hYtk+gtkCCc45anwoeVGH+s3Tp1rXeJSjz422X7AQ8gmxp+217lfz/r6E/gqPV+toxeBfjPviO148HOjpEPjf920WfKOg9L28OFL9gajccaftVn7v9o/fzB7l3fCLDkAAAAASUVORK5CYII="
													style="width: 30px; height: 30px; float: sticky; margin-top: 25px;">
											</c:when>
											<c:otherwise>
												<img id="${MemberList[i].member.krName}"
													onclick="damaY('${MemberList[i].member.krName}')"
													src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAADAAAAAwCAYAAABXAvmHAAAABmJLR0QA/wD/AP+gvaeTAAAFWElEQVRoge2YS4xTZRTHf6ftEGAGBMZHSDDBzHTaTpGMA23HSCAkJi7EhQTZmBAXCAswLkwEJCIuSIaNCzUkggsTDZOIO/AJBlEe007BkVimnbYBowkmBiVmRnm033ExpfTedmZ6O7cbM2d17znf+Z//+c79HufCrMzKrDRNNBFcp4ngumbG8DUTHNgHqsCZZgWQZgFrPPgkwvmJF89aiV35oRlxPM0ALSHvLz+L2dusME2pgCa7YxgzaI2kaySSOed2rOZUoFjcV62UPc0I5XoFNBnqxWiyNraJSnR0yM147lfA6FtMNjHqdX0tuFoBTYR7oHhpClzFEJG+9EW3YrpcgeKbWMmfAb6veBc8uLoWXKuAJrrDYC5jmRTP04gKqicrh2K0R/oyl92I62IFdJ8N74JEr3wrkZFTqJyt0Ase3nArqisJ6AV/CHSTVcnb5WcxB6we8oIOhVa4EdvxJ6TxYDsqfrz4UbpAO4EY8FgFbEKiIzGLXyIUB41WqK4CcZAcwihFsohmJZa+MeME9MeeRdz9x496OhH8QBeIv0R2yfRZ8pzE0icsqnhwA8LxOjj9CZIDzQKjKFnE5GiZn5Unhm9OmYDGgwcQXgYeqiPQZOyHiWR6RVCLVhGGApdAehrH5g+UIxJLl88T6xrwth4AhmcQ4DrCfjt5ABEUYT9wfQb4wyWO93HtI/T08rm0zf0M5dkaAEXgV9A8SB6VPKI51ORpa8lLODVWDwtNhdsYu9uBeDpQ6US0A7QDpAN4FPBWOQmfM3Zrk6y/dmvKBEoB5jBeHAA22kD+Qs0zbt9nynEnTvKTwIM20wkWFzaJP3fb7lNzG5Vw6g7X0ptBPrFGYDHIN5rsjtXym4loMtQLxVNUkZdP8bRurEUepjgHZDNFro28BHxksyzCmK91MNQ3U9L3RAeDqzB6Emi3Ghhg/JEXZfXFu5PynBZcEYaC7wE7bKZxhA0SSX/XCOky/lDgKVS+ABbaLB8SyWwXwUzlP+1JLIISSb8CeshmasVwXBOhtU5JlykmQmsx8hXV5A8RyWybjjzUeZWYSCKzE+Edq4E20C91MLC+ftolismuNaAnJjAslkNEMjtrbcW1pO67kAgqkfRrQL/NNB+PvF4vTlmMZy+wwKbtl2hmR73koYHLnETTe1AGrEr9ySlOlY8yING0416h0dtoi+XNiPMEqn1aao6bRhpLQHjc8u7lZ8cYqikbZkPXa8cJ6Onlc4HOClWBBwqjNcfGg10aD3bVBGovZoBChcZfwnYkzivQ2hqk8q4ikrWfkjrYuUwTgSMIKYSUJgJHdLBzWeUY8eduI5KtUHlL2I7EeQJirJ+Puf8p6PnwEh0K9OPxjYJsZeLnsQ9kKx5fXhPBD/Rcx8NlX9UrVvCC48+ogTVgwjZFSpOr5ms8tAtfIY/KLmBeDcc5wDZ8LXkdCvTr2cACwLoOEDv2tNLA73WxzpKwEjOeQ1haV4cqtKGyizlsAWz/T22bQx3iPAHDChvP5ycZeQPRgwClqrTb7EurfI3znchRU6+DnQvx+G5O4zeO6Pv45vXf62EnGhizA9E9wANThcAUFklf7u96OTlbAx7fCiYnfwc4DN5OiWR2VzbgEk6NSWzkIEpHqSr/ToIhiM/ROnCWQO3D5i6qH6MalGh6u0RTv0/qHkvfkEhmN6bQBbwLVDcpDg80ZwkolbNjEDmGkbDEMlsklrlaL4z05X6TaPpVfBIADjPRa9+zNrEClGfnFOJZLZGRzdI3kp3SYwqR3pFfJJrejvGuROQYoGBc+WNXUzQePNqMfriMn+yOaTx4tFn4szIr/0f5D1yB0iClsG6VAAAAAElFTkSuQmCC"
													style="width: 30px; height: 30px; float: sticky; margin-top: 25px;">
											</c:otherwise>
										</c:choose>
										<a
											href="https://www.youtube.com/channel/${MemberList[i].member.channelId}"
											target="_blank"> <img
											style="width =: 30px; height: 30px; margin-left: 10px; margin-top: 25px;"
											src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAADAAAAAwCAYAAABXAvmHAAAABmJLR0QA/wD/AP+gvaeTAAAEZ0lEQVRoge3Y32tbZRzH8fdz0nZNujZt58Sta2WTiQiCF/5gCDo2nAgiwxtlAxGd/8OYQ+cYbojOCxWc80aQ3QiCgsPRjVbETZx6oV4IbnOUbh3WtsmapmmT8/14kZPY7LQuOUm1sHxvknPOk/O8Puf7HE4SaFazmtWsZt3K5aoZNP70i53tbq7foX4n6wP6Dfow9QLdSN0S3aBORCsSoITEKiQEs07KSQA2h9w0kEKWkkg5NC5pDGPE4Y/mfV3JWedI/7lPZyMFSD+1a3PM0x6c2wFsBJIARRhIAgEIpGB3sK+ID16K4yvHLLZvic+hCUkX8fWVtfDB2m9Ojd00QGbnrhcQ7wOJigP/NV4K5iqPmTSz59d+f/rLJQNkdu7ejnQKiK0wPCqeY8bz2NJ77vQvJZpX6dShFYwH0eEXbP+iHcg+s3uD+Rqp6MrKwpeO5zKrrWfj8HCuogPm655o+OD8EnkZBbPlxANq77xuG0vMcgDn2BTtyhePZf0CuQfuJ3vfvWT8PGa2HPjitsXuLlFbFpg3Rbnypfdzvs+dr+/DtbaSPnWGqfeOkcjM0ua8xuIlfNi8eAdqwlcuEZNwra0AJJ/YzoaPj5Hf8mDQDTUMH2yHA2C2Piq+PGZBtfT20PfGq3S9tpd0YhVz8huDFzjUHwogud668KoMUKqubY/S/8lx8lseIlPIY+VzR8MjgbE2HAB1Nxq/sBsbjhwgeXAf6UScnPnR8Qjh3xYKgOioC3+TEABd2x9j4MRH+I88TKZQwGS14yUwtzocALXVg6/CDwTdePMgyUP7SXckyJvVhi/O3R4OILXVh68yQVDJx7cycOI42UQC1YIvHgsHqBtfm39B1YwHlA8FAM3Xha92DQWVHhxi5LmXiE/P4GrBF7dTpfOUn8SIeYLWRMNXF6AwMcnY4aPY0Ld0eg7PURu+OP9iATQDdEXFV9OA9OAQ44ffITGdIe5VfsWoAY+k6+EAMCVpXWT8vwQoTEwxdvhtbPgsSc/hcPXgQZoKBZBssoyoGb+0Pj04zPiRoySmZ0h4Xu03bBi/xBIyXcW56PgbMpSv+tdnSXoeHq5BeHDiWiiAw/tDiv5jBAnN53FtraRODjLx1rvEZ2ZIeLF/AA3AI+E7XQwFMOdfwkprsza8JOKeY3TvAZSbRz/8RJfn8PAajhfCK3BpkSUUuwR+JDwS7S5G4ex5QLR4XiWogXgkTK7cgfKDzC/ot2C2mvHFdSlaXHBFlhGPyGVjqcuhAGuGPxsFvouCv2GC5cTjTJ9vvnBhLhSgSNYrEoWVikfKOK9waKG5IkDPmS+GEHswsisOb5rwsWfvuPjzrwvNi/65m9r25F1m3suY24FsE5D8n/CTGL87OBkz78PbL5+/dqO1qr/X/9y6dXXMjw9gfp98r885DUi2DrQG0YMpKVM3TnFERwBqR8QDfFbSXHCzZ3xp1kkpnEs7s5Rhf2EaQ27EoVHDrpBhZP3VH7PV+JrVrGY1q1m3bv0NDRMeqgk0OuwAAAAASUVORK5CYII="
											alt=""></a> <a
											href="https://twitter.com/${MemberList[i].member.twitterId}"
											target="_blank"> <img
											style="width =: 30px; height: 30px; margin-left: 10px; margin-top: 25px;"
											src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAADAAAAAwCAYAAABXAvmHAAAABmJLR0QA/wD/AP+gvaeTAAADz0lEQVRoge2XTWgdVRiGn+/MpGnv3LRoqC4UhCz8I8RFRClSXdgqWkuV4CRpi1gqglZTuhFXkiDdCVIKBfEHo1Bzr0JRtGAqWhTBQhsaFX9ADbZisbXaJnPb5t6Z+VyotU0yc89MYlGYZzcz73fO+84ZzjcHCgoKCgoK/sfIJZ2tOnmdq+ZxYLXCNUCowvdG9b3QNbvo8Y7NLFm0O+iqry9/njRk0wDOSO2e6JvS+wxKnNv4oBr3hmBIkacBN8FKgLIt6vNe4u0Tbc65xXch8gSxfBn1eU/mC1A9Xna09JPAcNhb3prXvzMy9QIij1rKDwFdQAtwLJKoE3/Zb0likzqxercDyxQGnJHaLqrqWLv+e4xqsD6DeYBu/jR/0gj30lB13wjuTBKnBlCJO85fiD7maG0P1dOXW1tRFWJ91lr/DyHI/ljZ4bjud8bheJIwNQA66/laR51xtxqstnHRUjlzMyIdzZWzcEF7gFsQ2VT3y18kCVMDCGZijttXqzLqVKb28Nbk9Wn1Mdpp53dOfhXiVZHvvZMmSg0QLT6zHySY+6nc70TmK6cSvOtUamvZq60zFSralsXxDAbC3qWfNhMlbGl/sW75lFSCVxQGEhQCrAFd40zVJqnU9in6mREdC018VCJJ3D2aojptI2veyF5Tz22tjSlcm9tMDkS5O+wrjzbTpW+jI8EGZ1GtR2LpUxhfOHvNMYZZXXkuUj8hFW0XZEcsisDZhbFmhdbPeT/YCNNXQOTjCy6XzMtSBgS+5iGp2WhTAzT88mGEAwtjyx5FP7HVpjcywCBbgMa8HGXGpO79FymbCRq+dwjVDVy6ECcjKX1gK24aACDqa3vTqNyGcDC/LztEeRFf6rZ6qwAAsXAVyCDKq4BVk8nB2VBlZ5aC9E58MatQ3fJvnuEEdtLv/ZylxnoFIomHgF8yu7LnSNiY3p61yDoAftsJE5t1wO9ZJ7EgFuERNrZPZi20DwA0+ksHIie6Ffgw60RpqMhQ6Jf35anN/UW3VGvdkXKfiK5ESTzyWTAc+d4mRDRPcaYVuJDGg6UxgaMo3XnHAIYj8TbnNQ95VmCvtjpBrV9hmyhdOedVRZ6J/dL2+ZiHlAAtI8FNGHFVY0+FK1SlQ+AOYCUwn5PWhKCbw962j+YxxnkS+0CjtfGjW295SpGtKKUF2P5PK/JcPF163vZP04bmvnYHVxqHjcDDApkP6QrjqL4ct4av88Blp/KYTCPbi61O3ehgVhDrCgydxLockXZgKXAKZRLDBKrfouZgZMwo/pIjC226oKCgoKCg4L/CH/2pQ2x506tNAAAAAElFTkSuQmCC"
											alt=""></a>
									</div>
									<p class="m-1" style="font-size: 20px">${MemberList[i].member.krName}</p>
								</div>
							</div>
						</c:forEach>
					</div>
				</div>
				<div class="card">
					<div class="card-header" id="headingThree">
						<h2 class="mb-0">
							<button type="button" class="btn btn-link collapsed"
								data-toggle="collapse" data-target="#idgen2">
								<i class="fa fa-plus"></i> ID 2st Generation
							</button>
						</h2>
					</div>
					<div id="idgen2" class="collapse" aria-labelledby="headingThree"
						data-parent="#accordionExample">
						<c:forEach var="i" begin="48" end="50">
							<div class="d-flex flex-row border">
								<div class="order-1 p-1">
									<a
										href="https://www.youtube.com/channel/${MemberList[i].member.channelId}"
										target="_blank"> <img
										style="width: 80px; height: 80px; border-radius: 70px;"
										class="card-img-top" src="${MemberList[i].member.profileUrl}">
									</a>
								</div>
								<div class="order-2 p-1">
									<div
										class="btn-group float-right d-flex justify-content-between"
										role="group" aria-label="Basic example">
										<c:choose>
											<c:when
												test="${fn:contains(sessionScope.favorite,MemberList[i].member.krName) }">
												<img id="${MemberList[i].member.krName}"
													onclick="damaY('${MemberList[i].member.krName}')"
													src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAADAAAAAwCAYAAABXAvmHAAAABmJLR0QA/wD/AP+gvaeTAAAEoElEQVRoge2Z3W8UZRTGf2eWtlBEgtJu+dIQGhED8iEsCbAbqiYSolxqIglcGk0oiNyZGLjwjiuIfwAYb42JIaBeEGMw8YOYFjEkRAhSoFAt0m7blLLv48XutjPb2e7OMqOJ6bnYd949857nOXOeOfPOLszarM1aYqbLHRn92rElSQxLKrB60u2k7DoABa209XfvJYHjJRG0GNneA1oRraXjRCyRCuhqZwvj+RtI6eIXDJBveta29Y3FjZVMBcZH9vnIA7Qxf2JvElCxJyBhyB1ClMgLJEBHpPgrHn8FLnXsQrwAFImXE5FW09v2WtxwCUhIh4uDStPShwDH+3GjxVpS9aTXgnon4/rJQykpb4NtutcTF2a8FZA+AKwkGaaTB1Q4GCdkbBVQT7oddAMxN0AcKuU0jmylbf7zThy48VVA7sA08lLYvdACvBsXbCwV0PfL59E6/geweLpkJj/8iQ3S3PSMrb878rjYkROQMH5rS1PQMpRaClqO2I6013/SFOFqcrLPwF0A+nDuNl7zLbYM3DULnB09AV1qX0UqtQyxAqclYMtRYRnYUmAFUgfQFEpQPuwIPk35JhD9wE2k20K3PNSHszuYu4lL9Vn2wbWqCejy0mPIfRQA8Q01ZNGQT6o4N7RzTflMOmrZ/LHyN3P8CSB3DRDCgqX3B62YhxGs06fo6wTedT/lQBeytf2nkO0HTQQ7SRXy4V2mpk9SdfLV1xVMvGPZodMBzoSYetOvAp8jLQgE8g3/lmRKMUZN3puWGzpTybVqF9IvHVvw3BlE238oGYBBE3ssN3whjOeMbVSX2ldR0DlEZwAkDKi+LhNpHeKGFdhlXcNXqnGs+RzQj20dNHEWaUMAxDfUL5mZ1k1L7LIVCrusa6xvJn41txKWGeinmSzYN4ErVI28zxcqmarrAuS/tfGm7bXIQ4Qnsa52tjD09ymktwIEKgn6iYf46pDhFzYn/7Zto67350hbCQnj4uLjyB0OEPAPjUsGGZ94O/LdZrh6OTW0mdNPi04gOxBTlymSh5OpXL47Kpc5tU8JMZGPUTJlG26ESmMJYFvL4I8jGb/P0NZGmER+oZHwkDYXjxvuMmG+jI5G5xP9jeyHp56X9GQDe5kpn0J9C+h6YnXyCchlJslVfXGvQr7sK88rfU6ZqHQiJ+A8ZWKRTHnuO3blixPBIt/E5iwTucvUcRODMEeyFdB55oLWhUtmmpwGDbrN0Q0MVq8IU9UyXixiJJQALQs2IZqnk/DJSTiJTy3FGsvlT9rO/EnzUp2CE4hHNeTUTGHexuQSIJWZscug84bbmMoN77Pt+cl/ZCz74H5q58hBw1sHnA2XWmnuot0HkRJwlR1oUhZ203D7vWz+ZcuN9FZbb13DV7yu0d0m9iB+nyLPZDJOllwCBpmKqzciZ8fs0dBzlh05PeNif5xXRr+0hWNrTO4QMOSXk1m0Vlr/dvq7hYtk+gtkCCc45anwoeVGH+s3Tp1rXeJSjz422X7AQ8gmxp+217lfz/r6E/gqPV+toxeBfjPviO148HOjpEPjf920WfKOg9L28OFL9gajccaftVn7v9o/fzB7l3fCLDkAAAAASUVORK5CYII="
													style="width: 30px; height: 30px; float: sticky; margin-top: 25px;">
											</c:when>
											<c:otherwise>
												<img id="${MemberList[i].member.krName}"
													onclick="damaY('${MemberList[i].member.krName}')"
													src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAADAAAAAwCAYAAABXAvmHAAAABmJLR0QA/wD/AP+gvaeTAAAFWElEQVRoge2YS4xTZRTHf6ftEGAGBMZHSDDBzHTaTpGMA23HSCAkJi7EhQTZmBAXCAswLkwEJCIuSIaNCzUkggsTDZOIO/AJBlEe007BkVimnbYBowkmBiVmRnm033ExpfTedmZ6O7cbM2d17znf+Z//+c79HufCrMzKrDRNNBFcp4ngumbG8DUTHNgHqsCZZgWQZgFrPPgkwvmJF89aiV35oRlxPM0ALSHvLz+L2dusME2pgCa7YxgzaI2kaySSOed2rOZUoFjcV62UPc0I5XoFNBnqxWiyNraJSnR0yM147lfA6FtMNjHqdX0tuFoBTYR7oHhpClzFEJG+9EW3YrpcgeKbWMmfAb6veBc8uLoWXKuAJrrDYC5jmRTP04gKqicrh2K0R/oyl92I62IFdJ8N74JEr3wrkZFTqJyt0Ase3nArqisJ6AV/CHSTVcnb5WcxB6we8oIOhVa4EdvxJ6TxYDsqfrz4UbpAO4EY8FgFbEKiIzGLXyIUB41WqK4CcZAcwihFsohmJZa+MeME9MeeRdz9x496OhH8QBeIv0R2yfRZ8pzE0icsqnhwA8LxOjj9CZIDzQKjKFnE5GiZn5Unhm9OmYDGgwcQXgYeqiPQZOyHiWR6RVCLVhGGApdAehrH5g+UIxJLl88T6xrwth4AhmcQ4DrCfjt5ABEUYT9wfQb4wyWO93HtI/T08rm0zf0M5dkaAEXgV9A8SB6VPKI51ORpa8lLODVWDwtNhdsYu9uBeDpQ6US0A7QDpAN4FPBWOQmfM3Zrk6y/dmvKBEoB5jBeHAA22kD+Qs0zbt9nynEnTvKTwIM20wkWFzaJP3fb7lNzG5Vw6g7X0ptBPrFGYDHIN5rsjtXym4loMtQLxVNUkZdP8bRurEUepjgHZDNFro28BHxksyzCmK91MNQ3U9L3RAeDqzB6Emi3Ghhg/JEXZfXFu5PynBZcEYaC7wE7bKZxhA0SSX/XCOky/lDgKVS+ABbaLB8SyWwXwUzlP+1JLIISSb8CeshmasVwXBOhtU5JlykmQmsx8hXV5A8RyWybjjzUeZWYSCKzE+Edq4E20C91MLC+ftolismuNaAnJjAslkNEMjtrbcW1pO67kAgqkfRrQL/NNB+PvF4vTlmMZy+wwKbtl2hmR73koYHLnETTe1AGrEr9ySlOlY8yING0416h0dtoi+XNiPMEqn1aao6bRhpLQHjc8u7lZ8cYqikbZkPXa8cJ6Onlc4HOClWBBwqjNcfGg10aD3bVBGovZoBChcZfwnYkzivQ2hqk8q4ikrWfkjrYuUwTgSMIKYSUJgJHdLBzWeUY8eduI5KtUHlL2I7EeQJirJ+Puf8p6PnwEh0K9OPxjYJsZeLnsQ9kKx5fXhPBD/Rcx8NlX9UrVvCC48+ogTVgwjZFSpOr5ms8tAtfIY/KLmBeDcc5wDZ8LXkdCvTr2cACwLoOEDv2tNLA73WxzpKwEjOeQ1haV4cqtKGyizlsAWz/T22bQx3iPAHDChvP5ycZeQPRgwClqrTb7EurfI3znchRU6+DnQvx+G5O4zeO6Pv45vXf62EnGhizA9E9wANThcAUFklf7u96OTlbAx7fCiYnfwc4DN5OiWR2VzbgEk6NSWzkIEpHqSr/ToIhiM/ROnCWQO3D5i6qH6MalGh6u0RTv0/qHkvfkEhmN6bQBbwLVDcpDg80ZwkolbNjEDmGkbDEMlsklrlaL4z05X6TaPpVfBIADjPRa9+zNrEClGfnFOJZLZGRzdI3kp3SYwqR3pFfJJrejvGuROQYoGBc+WNXUzQePNqMfriMn+yOaTx4tFn4szIr/0f5D1yB0iClsG6VAAAAAElFTkSuQmCC"
													style="width: 30px; height: 30px; float: sticky; margin-top: 25px;">
											</c:otherwise>
										</c:choose>
										<a
											href="https://www.youtube.com/channel/${MemberList[i].member.channelId}"
											target="_blank"> <img
											style="width =: 30px; height: 30px; margin-left: 10px; margin-top: 25px;"
											src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAADAAAAAwCAYAAABXAvmHAAAABmJLR0QA/wD/AP+gvaeTAAAEZ0lEQVRoge3Y32tbZRzH8fdz0nZNujZt58Sta2WTiQiCF/5gCDo2nAgiwxtlAxGd/8OYQ+cYbojOCxWc80aQ3QiCgsPRjVbETZx6oV4IbnOUbh3WtsmapmmT8/14kZPY7LQuOUm1sHxvknPOk/O8Puf7HE4SaFazmtWsZt3K5aoZNP70i53tbq7foX4n6wP6Dfow9QLdSN0S3aBORCsSoITEKiQEs07KSQA2h9w0kEKWkkg5NC5pDGPE4Y/mfV3JWedI/7lPZyMFSD+1a3PM0x6c2wFsBJIARRhIAgEIpGB3sK+ID16K4yvHLLZvic+hCUkX8fWVtfDB2m9Ojd00QGbnrhcQ7wOJigP/NV4K5iqPmTSz59d+f/rLJQNkdu7ejnQKiK0wPCqeY8bz2NJ77vQvJZpX6dShFYwH0eEXbP+iHcg+s3uD+Rqp6MrKwpeO5zKrrWfj8HCuogPm655o+OD8EnkZBbPlxANq77xuG0vMcgDn2BTtyhePZf0CuQfuJ3vfvWT8PGa2HPjitsXuLlFbFpg3Rbnypfdzvs+dr+/DtbaSPnWGqfeOkcjM0ua8xuIlfNi8eAdqwlcuEZNwra0AJJ/YzoaPj5Hf8mDQDTUMH2yHA2C2Piq+PGZBtfT20PfGq3S9tpd0YhVz8huDFzjUHwogud668KoMUKqubY/S/8lx8lseIlPIY+VzR8MjgbE2HAB1Nxq/sBsbjhwgeXAf6UScnPnR8Qjh3xYKgOioC3+TEABd2x9j4MRH+I88TKZQwGS14yUwtzocALXVg6/CDwTdePMgyUP7SXckyJvVhi/O3R4OILXVh68yQVDJx7cycOI42UQC1YIvHgsHqBtfm39B1YwHlA8FAM3Xha92DQWVHhxi5LmXiE/P4GrBF7dTpfOUn8SIeYLWRMNXF6AwMcnY4aPY0Ld0eg7PURu+OP9iATQDdEXFV9OA9OAQ44ffITGdIe5VfsWoAY+k6+EAMCVpXWT8vwQoTEwxdvhtbPgsSc/hcPXgQZoKBZBssoyoGb+0Pj04zPiRoySmZ0h4Xu03bBi/xBIyXcW56PgbMpSv+tdnSXoeHq5BeHDiWiiAw/tDiv5jBAnN53FtraRODjLx1rvEZ2ZIeLF/AA3AI+E7XQwFMOdfwkprsza8JOKeY3TvAZSbRz/8RJfn8PAajhfCK3BpkSUUuwR+JDwS7S5G4ex5QLR4XiWogXgkTK7cgfKDzC/ot2C2mvHFdSlaXHBFlhGPyGVjqcuhAGuGPxsFvouCv2GC5cTjTJ9vvnBhLhSgSNYrEoWVikfKOK9waKG5IkDPmS+GEHswsisOb5rwsWfvuPjzrwvNi/65m9r25F1m3suY24FsE5D8n/CTGL87OBkz78PbL5+/dqO1qr/X/9y6dXXMjw9gfp98r885DUi2DrQG0YMpKVM3TnFERwBqR8QDfFbSXHCzZ3xp1kkpnEs7s5Rhf2EaQ27EoVHDrpBhZP3VH7PV+JrVrGY1q1m3bv0NDRMeqgk0OuwAAAAASUVORK5CYII="
											alt=""></a> <a
											href="https://twitter.com/${MemberList[i].member.twitterId}"
											target="_blank"> <img
											style="width =: 30px; height: 30px; margin-left: 10px; margin-top: 25px;"
											src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAADAAAAAwCAYAAABXAvmHAAAABmJLR0QA/wD/AP+gvaeTAAADz0lEQVRoge2XTWgdVRiGn+/MpGnv3LRoqC4UhCz8I8RFRClSXdgqWkuV4CRpi1gqglZTuhFXkiDdCVIKBfEHo1Bzr0JRtGAqWhTBQhsaFX9ADbZisbXaJnPb5t6Z+VyotU0yc89MYlGYZzcz73fO+84ZzjcHCgoKCgoK/sfIJZ2tOnmdq+ZxYLXCNUCowvdG9b3QNbvo8Y7NLFm0O+iqry9/njRk0wDOSO2e6JvS+wxKnNv4oBr3hmBIkacBN8FKgLIt6vNe4u0Tbc65xXch8gSxfBn1eU/mC1A9Xna09JPAcNhb3prXvzMy9QIij1rKDwFdQAtwLJKoE3/Zb0likzqxercDyxQGnJHaLqrqWLv+e4xqsD6DeYBu/jR/0gj30lB13wjuTBKnBlCJO85fiD7maG0P1dOXW1tRFWJ91lr/DyHI/ljZ4bjud8bheJIwNQA66/laR51xtxqstnHRUjlzMyIdzZWzcEF7gFsQ2VT3y18kCVMDCGZijttXqzLqVKb28Nbk9Wn1Mdpp53dOfhXiVZHvvZMmSg0QLT6zHySY+6nc70TmK6cSvOtUamvZq60zFSralsXxDAbC3qWfNhMlbGl/sW75lFSCVxQGEhQCrAFd40zVJqnU9in6mREdC018VCJJ3D2aojptI2veyF5Tz22tjSlcm9tMDkS5O+wrjzbTpW+jI8EGZ1GtR2LpUxhfOHvNMYZZXXkuUj8hFW0XZEcsisDZhbFmhdbPeT/YCNNXQOTjCy6XzMtSBgS+5iGp2WhTAzT88mGEAwtjyx5FP7HVpjcywCBbgMa8HGXGpO79FymbCRq+dwjVDVy6ECcjKX1gK24aACDqa3vTqNyGcDC/LztEeRFf6rZ6qwAAsXAVyCDKq4BVk8nB2VBlZ5aC9E58MatQ3fJvnuEEdtLv/ZylxnoFIomHgF8yu7LnSNiY3p61yDoAftsJE5t1wO9ZJ7EgFuERNrZPZi20DwA0+ksHIie6Ffgw60RpqMhQ6Jf35anN/UW3VGvdkXKfiK5ESTzyWTAc+d4mRDRPcaYVuJDGg6UxgaMo3XnHAIYj8TbnNQ95VmCvtjpBrV9hmyhdOedVRZ6J/dL2+ZiHlAAtI8FNGHFVY0+FK1SlQ+AOYCUwn5PWhKCbw962j+YxxnkS+0CjtfGjW295SpGtKKUF2P5PK/JcPF163vZP04bmvnYHVxqHjcDDApkP6QrjqL4ct4av88Blp/KYTCPbi61O3ehgVhDrCgydxLockXZgKXAKZRLDBKrfouZgZMwo/pIjC226oKCgoKCg4L/CH/2pQ2x506tNAAAAAElFTkSuQmCC"
											alt=""></a>
									</div>
									<p class="m-1" style="font-size: 20px">${MemberList[i].member.krName}</p>
								</div>
							</div>
						</c:forEach>
					</div>
				</div>
				<div class="card">
					<div class="card-header" id="headingThree">
						<h2 class="mb-0">
							<button type="button" class="btn btn-link collapsed"
								data-toggle="collapse" data-target="#idgen3">
								<i class="fa fa-plus"></i> ID 3st Generation
							</button>
						</h2>
					</div>
					<div id="idgen3" class="collapse" aria-labelledby="headingThree"
						data-parent="#accordionExample">
						<c:forEach var="i" begin="51" end="53">
							<div class="d-flex flex-row border">
								<div class="order-1 p-1">
									<a
										href="https://www.youtube.com/channel/${MemberList[i].member.channelId}"
										target="_blank"> <img
										style="width: 80px; height: 80px; border-radius: 70px;"
										class="card-img-top" src="${MemberList[i].member.profileUrl}">
									</a>
								</div>
								<div class="order-2 p-1">
									<div
										class="btn-group float-right d-flex justify-content-between"
										role="group" aria-label="Basic example">
										<c:choose>
											<c:when
												test="${fn:contains(sessionScope.favorite,MemberList[i].member.krName) }">
												<img id="${MemberList[i].member.krName}"
													onclick="damaY('${MemberList[i].member.krName}')"
													src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAADAAAAAwCAYAAABXAvmHAAAABmJLR0QA/wD/AP+gvaeTAAAEoElEQVRoge2Z3W8UZRTGf2eWtlBEgtJu+dIQGhED8iEsCbAbqiYSolxqIglcGk0oiNyZGLjwjiuIfwAYb42JIaBeEGMw8YOYFjEkRAhSoFAt0m7blLLv48XutjPb2e7OMqOJ6bnYd949857nOXOeOfPOLszarM1aYqbLHRn92rElSQxLKrB60u2k7DoABa209XfvJYHjJRG0GNneA1oRraXjRCyRCuhqZwvj+RtI6eIXDJBveta29Y3FjZVMBcZH9vnIA7Qxf2JvElCxJyBhyB1ClMgLJEBHpPgrHn8FLnXsQrwAFImXE5FW09v2WtxwCUhIh4uDStPShwDH+3GjxVpS9aTXgnon4/rJQykpb4NtutcTF2a8FZA+AKwkGaaTB1Q4GCdkbBVQT7oddAMxN0AcKuU0jmylbf7zThy48VVA7sA08lLYvdACvBsXbCwV0PfL59E6/geweLpkJj/8iQ3S3PSMrb878rjYkROQMH5rS1PQMpRaClqO2I6013/SFOFqcrLPwF0A+nDuNl7zLbYM3DULnB09AV1qX0UqtQyxAqclYMtRYRnYUmAFUgfQFEpQPuwIPk35JhD9wE2k20K3PNSHszuYu4lL9Vn2wbWqCejy0mPIfRQA8Q01ZNGQT6o4N7RzTflMOmrZ/LHyN3P8CSB3DRDCgqX3B62YhxGs06fo6wTedT/lQBeytf2nkO0HTQQ7SRXy4V2mpk9SdfLV1xVMvGPZodMBzoSYetOvAp8jLQgE8g3/lmRKMUZN3puWGzpTybVqF9IvHVvw3BlE238oGYBBE3ssN3whjOeMbVSX2ldR0DlEZwAkDKi+LhNpHeKGFdhlXcNXqnGs+RzQj20dNHEWaUMAxDfUL5mZ1k1L7LIVCrusa6xvJn41txKWGeinmSzYN4ErVI28zxcqmarrAuS/tfGm7bXIQ4Qnsa52tjD09ymktwIEKgn6iYf46pDhFzYn/7Zto67350hbCQnj4uLjyB0OEPAPjUsGGZ94O/LdZrh6OTW0mdNPi04gOxBTlymSh5OpXL47Kpc5tU8JMZGPUTJlG26ESmMJYFvL4I8jGb/P0NZGmER+oZHwkDYXjxvuMmG+jI5G5xP9jeyHp56X9GQDe5kpn0J9C+h6YnXyCchlJslVfXGvQr7sK88rfU6ZqHQiJ+A8ZWKRTHnuO3blixPBIt/E5iwTucvUcRODMEeyFdB55oLWhUtmmpwGDbrN0Q0MVq8IU9UyXixiJJQALQs2IZqnk/DJSTiJTy3FGsvlT9rO/EnzUp2CE4hHNeTUTGHexuQSIJWZscug84bbmMoN77Pt+cl/ZCz74H5q58hBw1sHnA2XWmnuot0HkRJwlR1oUhZ203D7vWz+ZcuN9FZbb13DV7yu0d0m9iB+nyLPZDJOllwCBpmKqzciZ8fs0dBzlh05PeNif5xXRr+0hWNrTO4QMOSXk1m0Vlr/dvq7hYtk+gtkCCc45anwoeVGH+s3Tp1rXeJSjz422X7AQ8gmxp+217lfz/r6E/gqPV+toxeBfjPviO148HOjpEPjf920WfKOg9L28OFL9gajccaftVn7v9o/fzB7l3fCLDkAAAAASUVORK5CYII="
													style="width: 30px; height: 30px; float: sticky; margin-top: 25px;">
											</c:when>
											<c:otherwise>
												<img id="${MemberList[i].member.krName}"
													onclick="damaY('${MemberList[i].member.krName}')"
													src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAADAAAAAwCAYAAABXAvmHAAAABmJLR0QA/wD/AP+gvaeTAAAFWElEQVRoge2YS4xTZRTHf6ftEGAGBMZHSDDBzHTaTpGMA23HSCAkJi7EhQTZmBAXCAswLkwEJCIuSIaNCzUkggsTDZOIO/AJBlEe007BkVimnbYBowkmBiVmRnm033ExpfTedmZ6O7cbM2d17znf+Z//+c79HufCrMzKrDRNNBFcp4ngumbG8DUTHNgHqsCZZgWQZgFrPPgkwvmJF89aiV35oRlxPM0ALSHvLz+L2dusME2pgCa7YxgzaI2kaySSOed2rOZUoFjcV62UPc0I5XoFNBnqxWiyNraJSnR0yM147lfA6FtMNjHqdX0tuFoBTYR7oHhpClzFEJG+9EW3YrpcgeKbWMmfAb6veBc8uLoWXKuAJrrDYC5jmRTP04gKqicrh2K0R/oyl92I62IFdJ8N74JEr3wrkZFTqJyt0Ase3nArqisJ6AV/CHSTVcnb5WcxB6we8oIOhVa4EdvxJ6TxYDsqfrz4UbpAO4EY8FgFbEKiIzGLXyIUB41WqK4CcZAcwihFsohmJZa+MeME9MeeRdz9x496OhH8QBeIv0R2yfRZ8pzE0icsqnhwA8LxOjj9CZIDzQKjKFnE5GiZn5Unhm9OmYDGgwcQXgYeqiPQZOyHiWR6RVCLVhGGApdAehrH5g+UIxJLl88T6xrwth4AhmcQ4DrCfjt5ABEUYT9wfQb4wyWO93HtI/T08rm0zf0M5dkaAEXgV9A8SB6VPKI51ORpa8lLODVWDwtNhdsYu9uBeDpQ6US0A7QDpAN4FPBWOQmfM3Zrk6y/dmvKBEoB5jBeHAA22kD+Qs0zbt9nynEnTvKTwIM20wkWFzaJP3fb7lNzG5Vw6g7X0ptBPrFGYDHIN5rsjtXym4loMtQLxVNUkZdP8bRurEUepjgHZDNFro28BHxksyzCmK91MNQ3U9L3RAeDqzB6Emi3Ghhg/JEXZfXFu5PynBZcEYaC7wE7bKZxhA0SSX/XCOky/lDgKVS+ABbaLB8SyWwXwUzlP+1JLIISSb8CeshmasVwXBOhtU5JlykmQmsx8hXV5A8RyWybjjzUeZWYSCKzE+Edq4E20C91MLC+ftolismuNaAnJjAslkNEMjtrbcW1pO67kAgqkfRrQL/NNB+PvF4vTlmMZy+wwKbtl2hmR73koYHLnETTe1AGrEr9ySlOlY8yING0416h0dtoi+XNiPMEqn1aao6bRhpLQHjc8u7lZ8cYqikbZkPXa8cJ6Onlc4HOClWBBwqjNcfGg10aD3bVBGovZoBChcZfwnYkzivQ2hqk8q4ikrWfkjrYuUwTgSMIKYSUJgJHdLBzWeUY8eduI5KtUHlL2I7EeQJirJ+Puf8p6PnwEh0K9OPxjYJsZeLnsQ9kKx5fXhPBD/Rcx8NlX9UrVvCC48+ogTVgwjZFSpOr5ms8tAtfIY/KLmBeDcc5wDZ8LXkdCvTr2cACwLoOEDv2tNLA73WxzpKwEjOeQ1haV4cqtKGyizlsAWz/T22bQx3iPAHDChvP5ycZeQPRgwClqrTb7EurfI3znchRU6+DnQvx+G5O4zeO6Pv45vXf62EnGhizA9E9wANThcAUFklf7u96OTlbAx7fCiYnfwc4DN5OiWR2VzbgEk6NSWzkIEpHqSr/ToIhiM/ROnCWQO3D5i6qH6MalGh6u0RTv0/qHkvfkEhmN6bQBbwLVDcpDg80ZwkolbNjEDmGkbDEMlsklrlaL4z05X6TaPpVfBIADjPRa9+zNrEClGfnFOJZLZGRzdI3kp3SYwqR3pFfJJrejvGuROQYoGBc+WNXUzQePNqMfriMn+yOaTx4tFn4szIr/0f5D1yB0iClsG6VAAAAAElFTkSuQmCC"
													style="width: 30px; height: 30px; float: sticky; margin-top: 25px;">
											</c:otherwise>
										</c:choose>
										<a
											href="https://www.youtube.com/channel/${MemberList[i].member.channelId}"
											target="_blank"> <img
											style="width =: 30px; height: 30px; margin-left: 10px; margin-top: 25px;"
											src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAADAAAAAwCAYAAABXAvmHAAAABmJLR0QA/wD/AP+gvaeTAAAEZ0lEQVRoge3Y32tbZRzH8fdz0nZNujZt58Sta2WTiQiCF/5gCDo2nAgiwxtlAxGd/8OYQ+cYbojOCxWc80aQ3QiCgsPRjVbETZx6oV4IbnOUbh3WtsmapmmT8/14kZPY7LQuOUm1sHxvknPOk/O8Puf7HE4SaFazmtWsZt3K5aoZNP70i53tbq7foX4n6wP6Dfow9QLdSN0S3aBORCsSoITEKiQEs07KSQA2h9w0kEKWkkg5NC5pDGPE4Y/mfV3JWedI/7lPZyMFSD+1a3PM0x6c2wFsBJIARRhIAgEIpGB3sK+ID16K4yvHLLZvic+hCUkX8fWVtfDB2m9Ojd00QGbnrhcQ7wOJigP/NV4K5iqPmTSz59d+f/rLJQNkdu7ejnQKiK0wPCqeY8bz2NJ77vQvJZpX6dShFYwH0eEXbP+iHcg+s3uD+Rqp6MrKwpeO5zKrrWfj8HCuogPm655o+OD8EnkZBbPlxANq77xuG0vMcgDn2BTtyhePZf0CuQfuJ3vfvWT8PGa2HPjitsXuLlFbFpg3Rbnypfdzvs+dr+/DtbaSPnWGqfeOkcjM0ua8xuIlfNi8eAdqwlcuEZNwra0AJJ/YzoaPj5Hf8mDQDTUMH2yHA2C2Piq+PGZBtfT20PfGq3S9tpd0YhVz8huDFzjUHwogud668KoMUKqubY/S/8lx8lseIlPIY+VzR8MjgbE2HAB1Nxq/sBsbjhwgeXAf6UScnPnR8Qjh3xYKgOioC3+TEABd2x9j4MRH+I88TKZQwGS14yUwtzocALXVg6/CDwTdePMgyUP7SXckyJvVhi/O3R4OILXVh68yQVDJx7cycOI42UQC1YIvHgsHqBtfm39B1YwHlA8FAM3Xha92DQWVHhxi5LmXiE/P4GrBF7dTpfOUn8SIeYLWRMNXF6AwMcnY4aPY0Ld0eg7PURu+OP9iATQDdEXFV9OA9OAQ44ffITGdIe5VfsWoAY+k6+EAMCVpXWT8vwQoTEwxdvhtbPgsSc/hcPXgQZoKBZBssoyoGb+0Pj04zPiRoySmZ0h4Xu03bBi/xBIyXcW56PgbMpSv+tdnSXoeHq5BeHDiWiiAw/tDiv5jBAnN53FtraRODjLx1rvEZ2ZIeLF/AA3AI+E7XQwFMOdfwkprsza8JOKeY3TvAZSbRz/8RJfn8PAajhfCK3BpkSUUuwR+JDwS7S5G4ex5QLR4XiWogXgkTK7cgfKDzC/ot2C2mvHFdSlaXHBFlhGPyGVjqcuhAGuGPxsFvouCv2GC5cTjTJ9vvnBhLhSgSNYrEoWVikfKOK9waKG5IkDPmS+GEHswsisOb5rwsWfvuPjzrwvNi/65m9r25F1m3suY24FsE5D8n/CTGL87OBkz78PbL5+/dqO1qr/X/9y6dXXMjw9gfp98r885DUi2DrQG0YMpKVM3TnFERwBqR8QDfFbSXHCzZ3xp1kkpnEs7s5Rhf2EaQ27EoVHDrpBhZP3VH7PV+JrVrGY1q1m3bv0NDRMeqgk0OuwAAAAASUVORK5CYII="
											alt=""></a> <a
											href="https://twitter.com/${MemberList[i].member.twitterId}"
											target="_blank"> <img
											style="width =: 30px; height: 30px; margin-left: 10px; margin-top: 25px;"
											src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAADAAAAAwCAYAAABXAvmHAAAABmJLR0QA/wD/AP+gvaeTAAADz0lEQVRoge2XTWgdVRiGn+/MpGnv3LRoqC4UhCz8I8RFRClSXdgqWkuV4CRpi1gqglZTuhFXkiDdCVIKBfEHo1Bzr0JRtGAqWhTBQhsaFX9ADbZisbXaJnPb5t6Z+VyotU0yc89MYlGYZzcz73fO+84ZzjcHCgoKCgoK/sfIJZ2tOnmdq+ZxYLXCNUCowvdG9b3QNbvo8Y7NLFm0O+iqry9/njRk0wDOSO2e6JvS+wxKnNv4oBr3hmBIkacBN8FKgLIt6vNe4u0Tbc65xXch8gSxfBn1eU/mC1A9Xna09JPAcNhb3prXvzMy9QIij1rKDwFdQAtwLJKoE3/Zb0likzqxercDyxQGnJHaLqrqWLv+e4xqsD6DeYBu/jR/0gj30lB13wjuTBKnBlCJO85fiD7maG0P1dOXW1tRFWJ91lr/DyHI/ljZ4bjud8bheJIwNQA66/laR51xtxqstnHRUjlzMyIdzZWzcEF7gFsQ2VT3y18kCVMDCGZijttXqzLqVKb28Nbk9Wn1Mdpp53dOfhXiVZHvvZMmSg0QLT6zHySY+6nc70TmK6cSvOtUamvZq60zFSralsXxDAbC3qWfNhMlbGl/sW75lFSCVxQGEhQCrAFd40zVJqnU9in6mREdC018VCJJ3D2aojptI2veyF5Tz22tjSlcm9tMDkS5O+wrjzbTpW+jI8EGZ1GtR2LpUxhfOHvNMYZZXXkuUj8hFW0XZEcsisDZhbFmhdbPeT/YCNNXQOTjCy6XzMtSBgS+5iGp2WhTAzT88mGEAwtjyx5FP7HVpjcywCBbgMa8HGXGpO79FymbCRq+dwjVDVy6ECcjKX1gK24aACDqa3vTqNyGcDC/LztEeRFf6rZ6qwAAsXAVyCDKq4BVk8nB2VBlZ5aC9E58MatQ3fJvnuEEdtLv/ZylxnoFIomHgF8yu7LnSNiY3p61yDoAftsJE5t1wO9ZJ7EgFuERNrZPZi20DwA0+ksHIie6Ffgw60RpqMhQ6Jf35anN/UW3VGvdkXKfiK5ESTzyWTAc+d4mRDRPcaYVuJDGg6UxgaMo3XnHAIYj8TbnNQ95VmCvtjpBrV9hmyhdOedVRZ6J/dL2+ZiHlAAtI8FNGHFVY0+FK1SlQ+AOYCUwn5PWhKCbw962j+YxxnkS+0CjtfGjW295SpGtKKUF2P5PK/JcPF163vZP04bmvnYHVxqHjcDDApkP6QrjqL4ct4av88Blp/KYTCPbi61O3ehgVhDrCgydxLockXZgKXAKZRLDBKrfouZgZMwo/pIjC226oKCgoKCg4L/CH/2pQ2x506tNAAAAAElFTkSuQmCC"
											alt=""></a>
									</div>
									<p class="m-1" style="font-size: 20px">${MemberList[i].member.krName}</p>
								</div>
							</div>
						</c:forEach>
					</div>
				</div>
			</div>
		</div>
</main>
</body>
</html>
