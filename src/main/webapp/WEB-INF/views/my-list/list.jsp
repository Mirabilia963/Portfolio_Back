<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>마이리스트</title>
<link rel="stylesheet" href="/resources/css/my-list.css">
</head>
<body>
	<!-- HEADER -->
	<%@ include file="/WEB-INF/views/common/header.jsp" %>
	
	<!-- MAIN -->
	<main>
		<div class="container">
			<div class="deleteButton">
				<p><button onclick="deleteMyList()">축제 삭제</button></p>
			</div>
			<div id="getInfo" class="row mb-2">
				
			</div>
		</div>
	</main>
	
	<!-- FOOTER -->
	<%@ include file="/WEB-INF/views/common/footer.jsp" %>
	
	<script>
	window.onload = function(){
		getMyLists();
	}
	
	function toggleCheck(obj){
		const diNums = document.querySelectorAll('input[name="mlNums"]');
		for(const mlNum of mlNums){
			diNum.checked = obj.checked;
		}
	}

	function getMyLists(){
		fetch('/my-lists')
		.then(function(res){
			return res.json();
		})
		.then(async function(myLists){
			if(myLists != 0) {
				let html = '';
				const getInfo = document.querySelector('#getInfo')
				for(let fesInfo of myLists){
					html += '<div class="col-md-6">'
						  + '	<div id="formMyListCheckBox" class="form-check">\n'
						  + '		<input id="myListCheckBox" class="form-check-input" type="checkbox" name="mlNums" value="' + fesInfo.mlNum + '">\n'
						  + '	</div>\n'
						  + '	<div class="row g-0 border rounded overflow-hidden flex-md-row mb-4 shadow-sm h-md-250 position-relative">\n'
						  + '		<div class="col p-4 d-flex flex-column position-static">\n'
						  + '			<strong class="d-inline-block mb-2 text-primary">' + "등록한 날짜 : " + fesInfo.mlDate.substr(0, 4) + '년 ' + fesInfo.mlDate.substr(4, 2) + '월 ' + fesInfo.mlDate.substr(6, 2) + '일' + '</strong>\n'
						  + '			<h3 id="title" class="mb-0">' + fesInfo.title + '</h3>\n'
						  + '			<div id="date" class="mb-1 text-muted">' + fesInfo.eventstartdate.substr(0, 4) + '년 ' + fesInfo.eventstartdate.substr(4, 2) + '월 ' + fesInfo.eventstartdate.substr(6, 2) + '일' 
						  + 				" ~ " + fesInfo.eventenddate.substr(0, 4) + '년 ' + fesInfo.eventenddate.substr(4, 2) + '월 ' + fesInfo.eventenddate.substr(6, 2) + '일' + '</div>\n'
						  + '			<p id="addr" class="card-text mb-auto">' + fesInfo.addr1 + '</p>\n'
						  + '			<a id="moreInfo" href="/views/festivalInfo/viewItem?fiNum=' + fesInfo.fiNum + '" class="stretched-link">축제 정보 더보기</a>\n'
						  + '		</div>\n'
						  + '		<div class="col-4 d-none d-lg-block">\n'
						  + '			<img id="image-thumbnail" class="bd-placeholder-img" src="' + fesInfo.firstimage + '" >\n'
						  + '		</div>\n'
						  + '	</div>\n'
						  + '</div>\n'
				}
				getInfo.innerHTML += html;
			} else {
				let html = '';
				html += '<div id="noInfo" class="col-md-100%">' 
					  + '<p>아직 등록하신 축제가 없습니다.<br><br>등록은 축제 상세 정보 페이지에서 가능합니다.<br><br>가고 싶은 축제들을 마이리스트에 담아보세요!</p>'
					  + '</div>\n'
				getInfo.innerHTML += html;
			}
		});
	}
	
	function deleteMyList(){
		const mlNumObjs = document.querySelectorAll('input[name="mlNums"]:checked');
		const mlNums = [];
		for(const mlNumObj of mlNumObjs){
			mlNums.push(mlNumObj.value);
		}
		if(mlNums.length===0){
			alert('선택하세요');
			return;
		}
		const param = {
			mlNums:mlNums
		}
		fetch('/my-lists',{
			method:'DELETE',
			headers: {
				 'Content-Type': 'application/json'
			},
			body: JSON.stringify(param)
		})
		.then(function(res){
			return res.json();
		})
		.then(function(data){
			if(data>=1){
				alert('삭제 완료!');
				location.href='/views/my-list/list'
			} else {
				alert('삭제 실패!');
			}
		})
	}
	</script>
</body>
</html>