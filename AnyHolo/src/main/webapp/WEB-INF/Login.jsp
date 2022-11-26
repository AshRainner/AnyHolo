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
    var n_RegExp = /^[가-힣]{2,15}$/; //이름 유효성검사 정규식
    
    var objId = document.getElementById("inputID"); //아이디
    var objPwd = document.getElementById("inputPassword1"); //비밀번호

    
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
                    <span class="glyphicon glyphicon-lock"></span> 로그인</div>
                <div class="panel-body">
                    <form action="/Login_Back" method="get" class="form-horizontal" onsubmit="return Validation();">
                    <div class="form-group">
                        <label for="inputEmail" class="col-sm-3 control-label">
                            ID</label>
                        <div class="col-sm-9">
                            <input type="text" class="form-control" name="inputID" id="inputID" placeholder="ID" required>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="inputPassword" class="col-sm-3 control-label">
                            비밀번호</label>
                        <div class="col-sm-9">
                            <input type="password" class="form-control" name="inputPassword" id="inputPassword1" placeholder="Password" required>
                        </div>
                    </div>
                    <div class="form-group last">
                        <div class="col-sm-offset-3 col-sm-9">
                            <button type="submit" class="btn btn-success btn-sm">
                                로그인</button>
                                 <button type="reset" class="btn btn-default btn-sm">
                                취소</button>
                        </div>
                    </div>
                    </form>
                </div>
                <div class="panel-footer">
                    회원가입 하시겠습니까? <a href="join1.jsp">회원가입</a>
                     <div class="forgot-pass-content">
                         <a href="/IDFind">아이디 찾기</a>/
                         <a href="/PWFind">패스워드 찾기</a>
                     </div>
                </div>
            </div>
        </div>
    </div>
    </div>
    </div>
</div>


</body>
</html>