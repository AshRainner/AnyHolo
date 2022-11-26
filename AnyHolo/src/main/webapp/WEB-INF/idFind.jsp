<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link
	href="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css"
	rel="stylesheet" id="bootstrap-css">
<script
	src="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
<script src="//code.jquery.com/jquery-1.11.1.min.js"></script>
<link
	href="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/css/bootstrap.min.css"
	rel="stylesheet" id="bootstrap-css">
<script
	src="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/js/bootstrap.min.js"></script>
<script
	src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<!------ Include the above in your HEAD tag ---------->

<link
	href="//netdna.bootstrapcdn.com/bootstrap/3.0.0/css/bootstrap.min.css"
	rel="stylesheet" id="bootstrap-css">
<script
	src="//netdna.bootstrapcdn.com/bootstrap/3.0.0/js/bootstrap.min.js"></script>
<script src="//code.jquery.com/jquery-1.11.1.min.js"></script>
<!------ Include the above in your HEAD tag ---------->

<style>
body {
	background-color: #EBECED;
}

.panel-default {
	opacity: 0.9;
	margin-top: 30px;
}

.form-group.last {
	margin-bottom: 0px;
}

.item-bg {
	width: 100vw;
	height: 100vh;
	background-image: url("");
	background-position: center;
	background-repeat: no-repeat;
	background-size: cover;
}

.wrapper {
	display: grid;
	place-items: center;
	min-height: 100vh;
}
</style>
<script type="text/javascript">
	function Validation() {
		var t_RegExp = /^[0-9]+$/;//Tel 유효성검사
		var n_RegExp = /^[가-힣]{2,15}$/; //이름 유효성검사 정규식

		var objName = document.getElementById("inputName"); //이름
		var objTel1 = document.getElementById("inputTel2"); //Tel
		var objTel2 = document.getElementById("inputTel3"); //Te2

		// ================ 이름 유효성검사 ================ //        
		if (objName.value == '') {
			alert("이름을 입력해주세요.");
			return false;
		} else if (!n_RegExp.test(objName.value)) {
			alert("특수문자,영어,숫자는 사용할수 없습니다. 한글만 입력하여주세요.");
			return false;
		}

		// ================ Tel 유효성검사 ===============//
		if (objTel1.value == '' || objTel2.value == '') { // Tel 입력여부 검사
			alert("Tel을 입력해주세요.");
			return false;
		} else if (!t_RegExp.test(objTel1.value)
				|| !t_RegExp.test(objTel2.value)) { //Tel 유효성검사
			alert("Tel 번호는 숫자만 입력하여 주세요.");
			return false;
		}
	}
</script>
<title>회원가입 페이지</title>
</head>
<body>
	<div class="item-bg">
		<div class="wrapper">
			<div class="container">
				<div class="row">
					<div class="col-md-4 col-md-offset-4">
						<div class="panel panel-default">
							<div class="panel-heading">
								<span class="glyphicon glyphicon-lock"></span> 아이디 찾기
							</div>
							<div class="panel-body">
								<form action="/IDFind_Back" method="get" class="form-horizontal"
									onsubmit="return Validation();">
									<div class="form-group">
										<label for="inputName" class="col-sm-3 control-label">
											이름</label>
										<div class="col-sm-9">
											<input type="text" name="name" class="form-control"
												id="inputName" placeholder="Name" required>
										</div>
									</div>
									<div class="form-group">
										<label for="inputTel" class="col-sm-3 control-label">
											휴대폰 </label>
										<div class="col-sm-3">
											<select style="height: 35px;" id="inputTel1" name="inputTel">
												<option value="010">010</option>
												<option value="070">070</option>
												<option value="070">011</option>
											</select>
										</div>
										<div class="col-sm-3">
											<input type="text" name="inputTel2" class="form-control"
												id="inputTel2" placeholder="" required>
										</div>
										<div class="col-sm-3">
											<input type="text" name="inputTel3" class="form-control"
												id="inputTel3" placeholder="" required>
										</div>
									</div>
									<div class="form-group last">
										<div class="col-sm-offset-3 col-sm-9">
											<button type="submit" class="btn btn-success btn-sm">
												확인</button>
											<button type="reset" class="btn btn-default btn-sm">
												취소</button>
										</div>
									</div>
								</form>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>