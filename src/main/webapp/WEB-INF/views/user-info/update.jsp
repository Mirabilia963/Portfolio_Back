<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Insert title here</title>
<link
	href="https://hangeul.pstatic.net/hangeul_static/css/nanum-square-round.css"
	rel="stylesheet">
<link rel="stylesheet" href="/resources/css/main.css">
<link rel="stylesheet" href="/resources/css/common.css">
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css">
<script
	src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"
	integrity="sha384-oBqDVmMz9ATKxIep9tiCxS/Z9fNfEXiDAYTujMAeBAsjFuCZSmKbSSUnQlmh/jp3"
	crossorigin="anonymous"></script>
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.min.js"
	integrity="sha384-cuYeSxntonz0PPNlHhBs68uyIAVpIIOZZ5JqeqvYYIcEL727kskC66kF92t6Xl2V"
	crossorigin="anonymous"></script>
<link href="/resources/css/info.css" rel="stylesheet" type="text/css">
</head>
<body>
	<!-- HEADER -->
	<%@ include file="/WEB-INF/views/common/header.jsp"%>
	<!-- Main -->

	<div class="wrap">
		<div class="info">
			<div id="infotitle">정보수정</div>
			<div class="info_name">
				<h5>이름</h5>
				<input type="text" id="uiName" value="${userInfo.uiName}">
			</div>
			<div class="info_nick">
				<h5>닉네임</h5>
				<input type="text" id="uiNickname" value="${userInfo.uiNickname}">
			</div>


			<button class="update-btn" onclick="update()">회원수정</button>
		</div>
	</div>

	<!-- FOOTER -->
	<%@ include file="/WEB-INF/views/common/footer.jsp"%>


	<script>
	function update(){
		const param = {
				uiName : document.querySelector('#uiName').value,
				uiNickname : document.querySelector('#uiNickname').value
		}
		fetch('/user-infos/${userInfo.uiNum}',{
			method : 'PATCH',
			headers : {
				'Content-Type' : 'application/json'
			},
			body : JSON.stringify(param)
		})
		.then(function(res){
			return res.json()
		})
		.then(function(data){
			if(data===true){
				alert('수정이 성공하였습니다.')
				location.href='/views/user-info/view';
			}
		})
		.catch(function(err){
			alert('오류가 발생하였습니다.')
			location.replace();
		})
	}
	</script>
</body>
</html>