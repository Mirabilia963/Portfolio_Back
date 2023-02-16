<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
		<!DOCTYPE html>
		<html lang="ko">

		<head>
			<meta charset="UTF-8">
			<title>Insert title here</title>
			<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"
				integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM"
				crossorigin="anonymous"></script>
			<link rel="stylesheet" href="/resources/css/common.css">
			<link rel="stylesheet" href="/resources/css/index.css">
		</head>

		<body>
			<!-- HEADER -->
			<%@ include file="/WEB-INF/views/common/header.jsp" %>
				<!-- MAIN -->
				<main>
				<!-- 소개 -->
				<div class="section">
					<div class="container">
						<div class="row text-left mb-5">
							<div class="col-lg-6">
								<p class="text-black-50">Point 01 전국 축제, 지역별 축제, 인기 축제 등 통합정보제공</p>
								<p class="text-black-50">Point 02 진행중 또는 진행예정 축제정보 제공</p>
								<p class="text-black-50">Point 03 축제 인근 즐길거리 정보 제공</p>
							</div>
							<div class="col-lg-6">
								<p class="text-black-50">지역별로 축제 및 체험정보를 쉽게 찾을 수 있습니다!</p>
								<p class="text-black-50">축제 인근 관광지도 둘러보세요!</p>
								<p class="text-black-50">마음에 드는 축제를 마이페이지에 담아보세요!</p>
							</div>
						</div>
					</div>
				</div>
					<div class="container align-items-center">
						<div id="carouselFestivalCaptions" class="carousel slide" data-bs-ride="carousel">
							<div class="carousel-indicators"></div>
							<div class="carousel-inner"></div>
							<button class="carousel-control-prev" type="button"
								data-bs-target="#carouselFestivalCaptions" data-bs-slide="prev">
								<span class="carousel-control-prev-icon" aria-hidden="true"></span>
								<span class="visually-hidden">Previous</span>
							</button>
							<button class="carousel-control-next" type="button"
								data-bs-target="#carouselFestivalCaptions" data-bs-slide="next">
								<span class="carousel-control-next-icon" aria-hidden="true"></span>
								<span class="visually-hidden">Next</span>
							</button>
						</div>
					</div>
				</main>
				<!-- FOOTER -->
				<%@ include file="/WEB-INF/views/common/footer.jsp" %>
					<script src="/resources/js/common.js"></script>
					<script>
						window.onload = function () {
							getReadCountFesInfoImg();
						}
						async function getReadCountFesInfoImg() {
							const list = await fe('/festival-infos/readcount');
							let indicatorshtml = '';
							let innerhtml = '';
							let i = 0;
							for (let value of list) {
								if (i == 0) {
									indicatorshtml += '<button type="button" data-bs-target="#carouselFestivalCaptions"  class="active" aria-current="true" data-bs-interval="2000" data-bs-slide-to="' + i + '" aria-label="Slide ' + (i + 1) + '"></button>';
									innerhtml += '<div class="carousel-item active"><img src="' + value.firstimage + '" class="d-block w-100" alt="' + value.title + '" style="height:600px;"><div class="carousel-caption d-none d-md-block"><h4 style="text-shadow:1px 1px black;color:skyblue;">' + value.title + '</h4></div></div>';
								} else {
									indicatorshtml += '<button type="button" data-bs-target="#carouselFestivalCaptions" data-bs-slide-to="' + i + '"  data-bs-interval="2000" aria-label="Slide ' + (i + 1) + '"></button>';
									innerhtml += '<div class="carousel-item"><img src="' + value.firstimage + '" class="d-block w-100" alt="' + value.title + '" style="height:600px;"><div class="carousel-caption d-none d-md-block"><h4 style="text-shadow:1px 1px black;color:skyblue;">' + value.title + '</h4></div></div>';
								}
								document.querySelector('.carousel-indicators').innerHTML = indicatorshtml;
								document.querySelector('.carousel-inner').innerHTML = innerhtml;
								i++;
							}

						}
					</script>
		</body>

		</html>