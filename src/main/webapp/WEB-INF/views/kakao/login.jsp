<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="/resources/css/main.css">
<link rel="stylesheet" href="/resources/css/common.css">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css">
<link rel="stylesheet" href="/resources/css/kakaoLogin.css" >
<link rel="stylesheet" href="https://hangeul.pstatic.net/hangeul_static/css/nanum-pen.css">
</head>
<body class="text-center">
	<main class="form-signin w-100 m-auto">
		<!-- 로고, 클릭시 메인 페이지로 이동-->
		<div class="whatdoLogo">
			<a href="/" class="whatdo">오늘 뭐하지?</a>
		</div>
		
		<!-- 카카오 로그인 -->
		<h1 class="h4 mb-3 fw-normal">카카오 로그인</h1>
		<input type="hidden" id="uiId" value="${userInfo.uiId}" readonly>
		<div class="form-floating">
			<input class="form-control" type="password" id="uiPwd" placeholder="비밀번호">
			<label for="floatingPassword">비밀번호</label>
		</div>
		<button class="w-100 btn btn-lg btn-primary" onclick="login()">로그인</button>
	</main>
	
	<script>
	function getParam(){
		const objs = document.querySelectorAll('input');
		const param = {};
		for(const obj of objs){
			param[obj.id] = obj.value;
		}
		return param;
	}
	
	function login(){
		const param = getParam();
		param.uiId = document.querySelector('#uiId').value;
		param.uiPwd = document.querySelector('#uiPwd').value;
		fetch('/auth/login',{
			method:'POST',
			headers:{
				'Content-Type':'application/json'
			},
			body:JSON.stringify(param)
		})
		.then(function(res){
			return res.text();
		})
		.then(function(data){
			if(data){
				data=JSON.parse(data);
				if(data.uiName){
					alert(data.uiName + '님, 안녕하세요.');
					location.href='/';
					return;
				}
			}
			alert('비번을 확인해주세요.');
		})
	}
	</script>
</body>
</html>