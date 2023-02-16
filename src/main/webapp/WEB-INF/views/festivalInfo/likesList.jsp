<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="/resources/css/likestyle.css" rel="stylesheet" type="text/css">
<link href="https://hangeul.pstatic.net/hangeul_static/css/nanum-square-round.css" rel="stylesheet">

<!-- HEADER -->

<%@ include file="/WEB-INF/views/common/header.jsp"%>

<div id="features-wrapper">
	<div class="container">
		<div class="row">
			<div class="col-4 col-12-medium"></div>

			<div id="searchOption" class="container">
				<input type="number" id="page" value=1 hidden>
			</div>

			<div id="mainContent" class="container">
				<div>

					<div class="container">
						<div class="row" id="popularList"></div>
					</div>
				</div>
					</div>
						</div>
							</div>
								</div>
				

				<div class="paginaiton"></div>
				
				<!-- FOOTER -->
				<%@ include file="/WEB-INF/views/common/footer.jsp"%>



				<script>
    
         let oneTime = false; // 글로벌 변수

         window.onload = function () {
             loadFestivalList();
         }
         function loadFestivalList() {
             const searchObjs = document.querySelectorAll('#searchOption [id]')
             let url = '?';
             for (let searchObj of searchObjs) {
                 url += searchObj.id + '=' + searchObj.value + '&';
             }
             console.log(url);
             fetch("/festival-infos-likes" + url)
                 .then(function (result) {
                     return result.json();
                 }).then(function (toJsonData) {
                     html = '';
                     const body = document.querySelector('#popularList');
                     for (let data of toJsonData.list) {
                         // html += '<tr><td><img src="' + data.firstimage2 + '" height=125px></td><td><a href="/views/festivalInfo/viewItem?fiNum=' + data.fiNum + '">' + data.title + '</a></td><td>' + data.addr1 + '</td>';
                         // html += '<td>' + data.eventstartdate + '</td><td>' + data.eventenddate + '</td>' + '<td>' + data.likecnt + '</td></tr>';
                    	 html += '<div class="col-4 col-12-medium">\n' +
						'    <section class="box feature">\n' +
						'        <a href="/views/festivalInfo/viewItem?fiNum=' + data.fiNum + '" class="image featured"><img\n' +
						'            src="' + data.firstimage2 + '" height=300px\n' +
						'             /></a>\n' +
						'        <div class="inner">\n' +
						'            <div>\n' +
						'                <div class="title">' + data.title + '</div>\n' +
						'                <div class="addr">' + data.addr1 + '</div>\n' +
						'				 <div class="date">' + data.eventstartdate + " - " + data.eventenddate + '</div>\n' +				
						' 				 <p align="right"><img src="/resources/images/like_img.jpg" width="23" height="23">' + " " + data.likecnt + '</p>\n' +
						'            </div>\n' +						
						'    </section>\n' +
						'</div>';
                     }
                     body.innerHTML += html;               
                    
                     document.querySelector('#page').value = Number(document.querySelector('#page').value) + 1;
                 });
         }
         function YesScroll() {
             const pagination = document.querySelector('.paginaiton'); // 페이지네이션 정보획득
             const fullContent = document.querySelector('body'); // 전체를 둘러싼 컨텐츠 정보획득
             const screenHeight = screen.height; // 화면 크기
             document.addEventListener('scroll', OnScroll, { passive: true }) // 스크롤 이벤트함수정의
             function OnScroll() { //스크롤 이벤트 함수
                 const fullHeight = fullContent.clientHeight; // 높이   
                 const scrollPosition = pageYOffset; // 스크롤 위치
                 if (fullHeight - screenHeight <= scrollPosition && !oneTime) { // 만약 전체높이-화면높이/2가 스크롤포지션보다 작아진다면, 그리고 oneTime 변수가 거짓이라면
                     oneTime = true; // oneTime 변수를 true로 변경해주고,
                     loadFestivalList(); // 컨텐츠를 추가하는 함수를 불러온다.
                 }
             }
         }
         YesScroll()

         function clearfestivalList() {
             document.querySelector('#tBody').innerHTML = '';
             document.querySelector('#page').value = 1;
         }

         function searchFestivalList() {
             clearfestivalList();
             loadFestivalList();
         }
</script>
</head>
<body>

</body>
</html>