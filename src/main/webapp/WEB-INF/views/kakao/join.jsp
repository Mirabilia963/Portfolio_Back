<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="/resources/css/main.css">
<link rel="stylesheet" href="/resources/css/common.css">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css">
<link rel="stylesheet" href="/resources/css/kakaoJoin.css" >
<link rel="stylesheet" href="https://hangeul.pstatic.net/hangeul_static/css/nanum-pen.css">
</head>
<body class="text-center">
	<main class="form-signin w-100 m-auto">
		<!-- 로고, 클릭시 메인 페이지로 이동-->
		<div class="whatdoLogo">
			<a href="/" class="whatdo">오늘 뭐하지?</a>
		</div>
		
		<!-- 추가 정보 입력 -->
		<h1 class="h4 mb-3 fw-normal">추가 정보 입력</h1>
		<div id="join-wrapper" class="card p-2">
		<c:if test="${uiId ne null}">
			<!-- 이름 입력 -->
			<label for="uiName" class="form-label" align="left">이름</label>
			<input type="text" id="uiName" class="form-control" placeholder="이름"><br>
			<!-- 닉네임 입력 -->
			<label for="uiNickname" class="form-label" align="left">닉네임</label>
			<div class="input-group">	
				<input type="text" id="uiNickname" class="form-control" placeholder="닉네임"><br>
				<button onclick="checkUiNickname()" class="btn btn-secondary">중복확인</button>
			</div>
			<small align="left">&nbsp;최소 2글자 이상</small>
			<!-- 비밀번호 입력 -->
			<br><label for="uiPwd" class="form-label" align="left">비밀번호</label>
			<input type="password" id="uiPwd" class="form-control" placeholder="비밀번호">
			<small align="left">&nbsp;최소 6글자 이상</small>
			<br><label for="uiPwdCheck" class="form-label" align="left">비밀번호 확인</label>
			<input type="password" id="uiPwdCheck" class="form-control" placeholder="비밀번호 확인">
		</c:if>
		</div>
		<button class="w-100 btn btn-lg btn-primary"  onclick="join()">회원가입</button><br><br>
	</main>
	
	<script>
	/* 추가 정보 입력 */
	let isCheckedNickname = false;
	function checkUiNickname() {
		const uiNickname = document.querySelector('#uiNickname').value;
		if(uiNickname.trim().length<2){
			alert('닉네임은 2글자 이상입니다.');
			return;
		}
		fetch('/user-infos/check-nickname/' + uiNickname)
		.then(function(data){
			return data.json();
		})
		.then(function(res){
			if(res===false){
				alert('이용이 가능한 닉네임 입니다.');
				isCheckedNickname = true;
			}else{
				alert('이미 등록되어 있는 닉네임 입니다.');
				isCheckedNickname = false;
			}
		});
	}
	
	function getParam(){
		const objs = document.querySelectorAll('input');
		const param = {};
		for(const obj of objs){
			param[obj.id] = obj.value;
		}
		return param;
	}
	
	function join() {
		if(!isCheckedNickname){
			alert('닉네임 중복확인 해주세요.');
			return false;
		}
		const uiNickname = document.querySelector('#uiNickname')
		if(uiNickname && uiNickname.value.trim().length<2){
			alert('닉네임은 2글자 이상입니다.');
			uiId.value='';
			uiId.focus();
			return;
		}
		const uiPwd = document.querySelector('#uiPwd');
		const uiPwdCheck = document.querySelector('#uiPwdCheck');
		if(uiPwd && uiPwd.value.trim().length<6){
			alert('비밀번호는 6글자 이상입니다.');
			uiPwd.value='';
			uiPwdCheck.value='';
			uiPwd.focus();
			return;
		}
		if(uiPwdCheck && uiPwd.value != uiPwdCheck.value){
			alert('비밀번호와 비밀번호 확인이 다릅니다.');
			uiPwd.value='';
			uiPwdCheck.value='';
			uipwd.focus();
			return;
		}
		const param = getParam();
		//카카오 코드 id값으로 받아오기
		param.uiId= '${uiId}';
		fetch('/user-infos',{
			method : 'POST',
			headers : {
				'Content-Type' : 'application/json'
			},
			body : JSON.stringify(param)
		})
		.then(function(res){
			return res.json()
		})
		.then(function(data){
			alert('회원가입이 완료되었습니다.')
			location.href='/views/user-info/login'
		})
	}
	</script>
</body>
</html>