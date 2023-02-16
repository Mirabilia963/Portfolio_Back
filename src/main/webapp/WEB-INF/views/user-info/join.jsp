<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>
<link rel="stylesheet" href="/resources/css/main.css">
<link rel="stylesheet" href="/resources/css/common.css">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css">
<link rel="stylesheet" href="/resources/css/join.css" >
<link rel="stylesheet" href="https://hangeul.pstatic.net/hangeul_static/css/nanum-pen.css">
</head>
<body class="text-center">
	<main class="form-signin w-100 m-auto">
		<!-- 로고, 클릭시 메인 페이지로 이동-->
		<div class="whatdoLogo">
			<a href="/" class="whatdo">오늘 뭐하지?</a>
		</div>
		
		<!-- 일반 회원가입 -->
		<h1 class="h4 mb-3 fw-normal">일반 회원가입</h1>
		<button class="w-100 btn btn-lg btn-primary" onclick="location.href='/views/user-info/joinForm'">일반 회원가입</button>
		
		<!-- 카카오 로그인 -->
		<div>
			<br><br><h2 class="h4 mb-3 fw-normal">간편 회원가입</h2>
			
			<a id="kakao-login-btn" href="javascript:loginWithKakao()">
			  <img src="/resources/images/kakao_start_large_narrow.png" width="200"
			    alt="카카오 가입 버튼" />
			</a>
			<p id="token-result"></p>
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