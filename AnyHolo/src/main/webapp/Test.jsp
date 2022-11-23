<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>무한스크롤 예제</title>
<style>
html, body {
	margin: 0;
}

h1 {
	position: fixed;
	top: 0;
	width: 100%;
	height: 60px;
	text-align: center;
	background: white;
	margin: 0;
	line-height: 60px;
}

section .box {
	height: 500px;
	background: red;
}

section .box p {
	margin: 0;
	color: white;
	padding: 80px 20px;
}

section .box:nth-child(2n) {
	background: blue;
}
</style>
</head>
<body>
	<h1>무한스크롤</h1>
	<section>
		<div class="box">
			<p>1번째 블록</p>
		</div>
		<div class="box">
			<p>2번째 블록</p>
		</div>
	</section>
	<script src="https://code.jquery.com/jquery-3.4.1.js"></script>
	<script type="text/javascript">
		var loading = false;
		var scrollPage = 1;
		var count = 2;
		$(window).scroll(
				function() {
					if ($(window).scrollTop() + 200 >= $(document).height()
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
				$.ajax({
					url : "http://localhost:8081/Clip2",
					type : "get",
					data : {
						"Page" : scrollPage
					},
					dataType : "json",
					success : function(data) {
						loading = false;
						scrollPage += 1;
						data.forEach(function(value) {
							var addContent = document.createElement("div");
							addContent.classList.add("box");
							addContent.innerHTML = '<p>' + value.videoTitle
									+ '번째 블록</p>';
							var twoDiv = document.createElement("div");
							twoDiv.classList.add("box");
							addContent.appendChild(twoDiv);
							document.querySelector('section').appendChild(
									addContent);
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
</html>