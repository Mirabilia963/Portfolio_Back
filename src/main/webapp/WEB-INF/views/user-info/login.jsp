<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인</title>
<link rel="stylesheet" href="/resources/css/main.css">
<link rel="stylesheet" href="/resources/css/common.css">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css">
<link rel="stylesheet" href="/resources/css/login.css" >
<link rel="stylesheet" href="https://hangeul.pstatic.net/hangeul_static/css/nanum-pen.css">
</head>
<body class="text-center">
	<main class="form-signin w-100 m-auto">
		<!-- 로고, 클릭시 메인 페이지로 이동-->
		<div class="whatdoLogo">
			<a href="/" class="whatdo">오늘 뭐하지?</a>
		</div>
		
		<!-- 비로그인 상태에서 나오는 메시지 -->
		<P>${msg}</P>
		
		<!-- 일반 회원가입 -->
		<h1 class="h4 mb-3 fw-normal">일반 로그인</h1>
		<div class="form-floating">
			<input class="form-control" type="text" id="uiId" placeholder="아이디">
			<label for="floatingInput">아이디</label>
		</div>
		<div class="form-floating">
			<input class="form-control" type="password" id="uiPwd" placeholder="비밀번호">
			<label for="floatingPassword">비밀번호</label>
		</div>
		<button class="w-100 btn btn-lg btn-primary" onclick="login()">로그인</button><br><br>
		
		<!-- 카카오 로그인 -->
		<div>
			<br><h2 class="h4 mb-3 fw-normal">간편 로그인</h2>
			<a id="kakao-login-btn" href="javascript:loginWithKakao()">
			  <img src="/resources/images/kakao_login_large_narrow.png" width="200"
			    alt="카카오 로그인 버튼" />
			</a>
			<p id="token-result"></p><br>
		</div>
		
		<div>
			<a href="/views/user-info/join">아직 회원가입을 하지 않으셨습니까?</a>
		</div>
	</main>
	
	<script>
	/* 카카오 로그인 */
	function loginWithKakao() {
	    Kakao.Auth.authorize({
	    	/* 나중에 localhost를 엘라스틱IP로 변경해야한다. */
	      redirectUri: 'http://whatdo.today/auth/oauth',
	    });
	}
	
	/* 일반 로그인 */
	function login(){
		let param = {
				uiId : document.querySelector('#uiId').value,
				uiPwd : document.querySelector('#uiPwd').value
		}
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
			if(data ){
				data=JSON.parse(data);
				if(data.uiName){
					alert(data.uiName + '님 로그인 완료!');
					location.href='/';
					return;
				}
			}
		alert('아이디 비번을 확인해주세요.');
		})
	}
	</script>
	
	<!-- 카카오 로그인 -->
	<script src="https://t1.kakaocdn.net/kakao_js_sdk/2.1.0/kakao.min.js"
	  integrity="sha384-dpu02ieKC6NUeKFoGMOKz6102CLEWi9+5RQjWSV0ikYSFFd8M3Wp2reIcquJOemx" crossorigin="anonymous">
	</script>
	<script>
	  Kakao.init('82febca4b29e4327a47c30d8e9856913'); // <-- app KEY!!(사용하려는 앱의 JavaScript 키 입력)
	</script>
</body>
</html>