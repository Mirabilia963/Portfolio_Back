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
		<div id="join-wrapper" class="card p-2">
			<!-- 아이디 입력 -->
			<label for="uiId" class="form-label" align="left">아이디</label>
			<div class="input-group">
				<input type="text" id="uiId" class="form-control" placeholder="아이디">
				<button onclick="checkId()" class="btn btn-secondary">중복확인</button>
			</div>
			<small align="left">&nbsp;최소 4글자 이상</small>
			<!-- 이름 입력 -->
			<br><label for="uiName" class="form-label" align="left">이름</label>
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
		</div>
		<button class="w-100 btn btn-lg btn-primary"  onclick="join()">회원가입</button><br><br>
	</main>
	
	<script>
	/* 일반 회원가입 */
	let isCheckedId = false;
	function checkId() {
		const uiId = document.querySelector('#uiId').value;
		if(uiId.trim().length<4){
			alert('아이디는 4글자 이상입니다.');
			return;
		}
		fetch('/user-infos/check/' + uiId)
		.then(function(data){
			return data.json();
		})
		.then(function(res){
			if(res===false){
				alert('이용 가능한 아이디 입니다.');
				isCheckedId = true;
			}else{
				alert('이미 등록되어 있는 아이디입니다.');
				isCheckedId = false;
			}
		});
	}
	
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
				alert('이용 가능한 닉네임 입니다.');
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
		if(!isCheckedId){
			alert('아이디 중복확인 해주세요.');
			return false;
		}
		if(!isCheckedNickname){
			alert('닉네임 중복확인 해주세요.');
			return false;
		}
		const uiId = document.querySelector('#uiId')
		if(uiId && uiId.value.trim().length<4){
			alert('아이디는 4글자 이상입니다.');
			uiId.value='';
			uiId.focus();
			return;
		}
		const uiNickname = document.querySelector('#uiNickname')
		if(uiNickname && uiNickname.value.trim().length<2){
			alert('닉네임은 2글자 이상입니다.');
			uiId.value='';
			uiId.focus();
			return;
		}
		const uiPwd = document.querySelector('#uiPwd');
		if(uiPwd && uiPwd.value.trim().length<6){
			alert('비밀번호는 6글자 이상입니다.');
			uiPwd.value='';
			uiPwd.focus();
			return;
		}
		const uiPwdCheck = document.querySelector('#uiPwdCheck');
		if(uiPwdCheck && uiPwd.value != uiPwdCheck.value){
			alert('비밀번호와 비밀번호 확인이 다릅니다.');
			uiPwdCheck.value='';
			uipwdCheck.focus();
			return;
		}
		const param = getParam();
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
			console.log(data);
			alert('회원가입이 완료되었습니다.')
			location.href='/views/user-info/login'
		})
	}
	</script>
</body>
</html>