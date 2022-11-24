<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
<script src="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
<script src="//code.jquery.com/jquery-1.11.1.min.js"></script>
<link href="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
<script src="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/js/bootstrap.min.js"></script>
<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<!------ Include the above in your HEAD tag ---------->

<link href="//netdna.bootstrapcdn.com/bootstrap/3.0.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
<script src="//netdna.bootstrapcdn.com/bootstrap/3.0.0/js/bootstrap.min.js"></script>
<script src="//code.jquery.com/jquery-1.11.1.min.js"></script>
<!------ Include the above in your HEAD tag ---------->

<style>
    
   body { 
  background-color:#EBECED;
}

.panel-default {
opacity: 0.9;
margin-top:30px;
}
.form-group.last { margin-bottom:0px; } 
        .item-bg{
    width:100vw;
    height:100vh;
    background-image: url("");
    background-position: center;
    background-repeat : no-repeat;
    background-size : cover;
    }
  .wrapper {
  display: grid;
  place-items: center;
  min-height: 100vh;
  
  }
    
</style>
<script type="text/javascript">
function Validation(){
    var RegExp = /^[a-zA-Z0-9]{4,12}$/; //id와 pwassword 유효성 검사 정규식
    var t_RegExp=/^[0-9]+$/;//Tel 유효성검사
    var n_RegExp = /^[가-힣]{2,15}$/; //이름 유효성검사 정규식
    
    var objId = document.getElementById("inputEmail"); //아이디
    var objPwd = document.getElementById("inputPassword1"); //비밀번호
    var objPwd2 = document.getElementById("inputPassword2"); //비밀번호확인
    var objName = document.getElementById("inputName"); //이름
    var objTel1 = document.getElementById("inputTel2"); //Tel
    var objTel2 = document.getElementById("inputTel3"); //Te2

    
    // ================ ID 유효성검사 ================ //
    
    if(objId.value==''){
        alert("ID를 입력해주세요.");
        return false;
    }
    if(!RegExp.test(objId.value)){ //아이디 유효성검사
        alert("ID는 4~12자의 영문 대소문자와 숫자로만 입력하여 주세요.");        
        return false;
    }
    
    // ================ PASSWORD 유효성검사 ===============//
    if(objPwd.value==''){ // 비밀번호 입력여부 검사
        alert("Password를 입력해주세요.");
        return false;
    }
    if(!RegExp.test(objPwd.value)){ //패스워드 유효성검사
        alert("Password는 4~12자의 영문 대소문자와 숫자로만 입력하여 주세요.");
        return false;
    }
    if(objPwd.value==objId.value){ //패스워드와 ID가 동일한지 검사
        alert("Password는 ID와 동일하면 안됩니다.");
        return false;
    }
    
    if(objPwd2.value!=objPwd.value){ //비밀번호와 비밀번호확인이 동일한지 검사
        alert("비밀번호가 틀립니다. 다시 확인하여 입력해주세요.");
        return false;
    }
    
    // ================ 이름 유효성검사 ================ //        
    if(objName.value ==''){
        alert("이름을 입력해주세요.");
        return false;
    }
    else if(!n_RegExp.test(objName.value)){
        alert("특수문자,영어,숫자는 사용할수 없습니다. 한글만 입력하여주세요.");
        return false;
    }
    
    // ================ Tel 유효성검사 ===============//
    if(objTel1.value=='' || objTel2.value==''){ // Tel 입력여부 검사
        alert("휴대폰 번호를 입력해주세요.");
        return false;
    }
    else if(!t_RegExp.test(objTel1.value) || !t_RegExp.test(objTel2.value)){ //Tel 유효성검사
        alert("휴대폰 번호는 숫자만 입력하여 주세요.");
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
                    <span class="glyphicon glyphicon-lock"></span> 회원가입</div>
                <div class="panel-body">
                    <form action="/Signup_Back" method="get" class="form-horizontal" onsubmit="return Validation();">
                    <div class="form-group">
                        <label for="inputEmail" class="col-sm-3 control-label">
                            ID</label>
                        <div class="col-sm-9">
                            <input type="text" class="form-control" id="inputID" name= "inputID" placeholder="ID" required>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="inputPassword" class="col-sm-3 control-label">
                            비밀번호</label>
                        <div class="col-sm-9">
                            <input type="password" class="form-control" name= "inputPassword" id="inputPassword1" placeholder="Password" required>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="inputPassword1" class="col-sm-3 control-label">
                            재확인</label>
                        <div class="col-sm-9">
                            <input type="password" class="form-control" id="inputPassword2" placeholder="Password" required>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="inputName" class="col-sm-3 control-label">
                            이름</label>
                        <div class="col-sm-9">
                            <input type="text" class="form-control" id="inputName" placeholder="Name" required>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="inputTel" class="col-sm-3 control-label">
                            휴대폰
                        </label>
                        <div class="col-sm-3">
                       			<select style="height:35px;" id="inputTel1" name="inputTel1">
           						<option value="010">010</option>
            					<option value="070">070</option>
            					<option value="070">011</option>
       							</select>
                        </div>
                        <div class="col-sm-3">
                            <input type="text" class="form-control" name= "inputTel2" id="inputTel2" placeholder="" required>
                        </div>
                        <div class="col-sm-3">
                            <input type="text" class="form-control" name= "inputTel3" id="inputTel3" placeholder="" required>
                        </div>
                    </div>
                    <div class="form-group last">
                        <div class="col-sm-offset-3 col-sm-9">
                            <button type="submit" class="btn btn-success btn-sm">
                                가입하기</button>
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