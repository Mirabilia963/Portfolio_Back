<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
		<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
			<!DOCTYPE html>
			<html>

			<head>
				<meta charset="UTF-8">
				<title>Insert title here</title>
				<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
				<script type="text/javascript"
					src="//dapi.kakao.com/v2/maps/sdk.js?appkey=82febca4b29e4327a47c30d8e9856913"></script>

				<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
				<link rel="stylesheet" href="/resources/css/festival.css">
				<link rel="stylesheet" href="/resources/css/viewItem.css">
				<link rel="stylesheet" href="/resources/css/common.css">
			</head>

			<body>

				<!-- HEADER -->
				<%@ include file="/WEB-INF/views/common/header.jsp" %>
					<main>
						<div id="mainContent">
							<div class="float-start">
								<div id="readyState" class="text-center"></div>
								<div id="mainContent" class="container text-center">
									<h3>축제 상세 정보</h3>
									<!-- 축제 정보 파트 -->
									<table class="table table-hover table-bordered">
										<tbody id="festivalInfo"></tbody>
									</table>
									<br>
									<!-- 썸네일 이미지 파트 -->
									<div id="thumbImgs" class="container"></div>
									<div id="myModal" class="modal">
										<span class="close">&times;</span>
										<img class="modal-content" id="myImg">
									</div>
									<!-- 카카오 맵 파트 -->
									<div id="map" class="container" style="margin-top: 10px; z-index: 0"></div>
								</div>
							</div>
						</div>
						<div>

							<button id="like" class="like_btn">
								<svg aria-label="좋아요" class="love" color="#262626" fill="#262626" height="24" role="img"
									viewBox="0 0 24 24" width="24">
									<path
										d="M16.792 3.904A4.989 4.989 0 0121.5 9.122c0 3.072-2.652 4.959-5.197 7.222-2.512 2.243-3.865 3.469-4.303 3.752-.477-.309-2.143-1.823-4.303-3.752C5.141 14.072 2.5 12.167 2.5 9.122a4.989 4.989 0 014.708-5.218 4.21 4.21 0 013.675 1.941c.84 1.175.98 1.763 1.12 1.763s.278-.588 1.11-1.766a4.17 4.17 0 013.679-1.938m0-2a6.04 6.04 0 00-4.797 2.127 6.052 6.052 0 00-4.787-2.127A6.985 6.985 0 00.5 9.122c0 3.61 2.55 5.827 5.015 7.97.283.246.569.494.853.747l1.027.918a44.998 44.998 0 003.518 3.018 2 2 0 002.174 0 45.263 45.263 0 003.626-3.115l.922-.824c.293-.26.59-.519.885-.774 2.334-2.025 4.98-4.32 4.98-7.94a6.985 6.985 0 00-6.708-7.218z">
									</path>
								</svg>
							</button>

							<span id="like_cnt"> 0 </span>

						</div>

						<!-- 마이리스트 등록 -->
						<c:if test="${userInfo eq null}">
							<div>
								<!-- 비로그인 상태에서는 로그인 화면으로 이동 -->
								<button id="myListButton" onclick="location.href='/views/my-list/'">마이리스트 등록</button>
							</div>
						</c:if>
						<c:if test="${userInfo ne null}">
							<div id="myListChangeButton">
								<!-- 로그인 상태에서는 정상 작동 -->
								<!-- 마이리스트에 있으면 마이리스트 취소 버튼, 없으면 마이리스트 등록 버튼 -->
							</div>
						</c:if>
						<!-- 관광지 파트 -->
						<div id="location" class="float-end container">
							<h2>추천 주변 관광지</h2>
							<div id="readyStateLoc" class="text-center"></div>
						</div>
						<!-- float clear -->
						<div style="clear: both;"></div>

						<!-- 댓글 시작 -->
						<hr />
						<div class="container">
							<label for="content">comment</label>
							<form name="commentInsertForm">
								<div class="input-group">
									<input type="hidden" name="fiNum" value="${param.fiNum}" /> <input
										type="text" class="form-control" id="ciContent" name="ciContent"
										placeholder="내용을 입력하세요."> <span class="input-group-btn">
										<button class="btn btn-default" id="insertComment" type="button"
											name="commentInsertBtn">등록</button>
									</span>
								</div>
							</form>
						</div>

						<div class="container">
				        <div class="commentList"></div>
				    </div>
					</main>
					<!-- FOOTER -->
					<%@ include file="/WEB-INF/views/common/footer.jsp" %>
						<script src="/resources/js/common.js"></script>
						<script>
							/* 마이리스트에 있는지 여부 확인 */
							function getMyListFiNum(){
								fetch('/my-lists')
								.then(function(res){
									return res.json();
								})
								.then(function(myLists){
									let myListsFiNum = new Array();
									for(let fesInfo of myLists){
										myListsFiNum.push(fesInfo.fiNum);	
									}
									let html = '';
									const myListChangeButton = document.querySelector('#myListChangeButton')
									if(myListsFiNum.includes(${ param.fiNum })){
										html += '<button id="myListButton" onclick="deleteMyList()">마이리스트 취소</button>'
									} else {
										html += '<button id="myListButton" onclick="insertMyList()">마이리스트 등록</button>'
									}
									myListChangeButton.innerHTML += html;
								})
							}
							
							/* 마이리스트 등록 */
							function insertMyList() {
								const param = {};
								param.uiNum = ${ userInfo.uiNum }
								param.fiNum = ${ param.fiNum }
								fetch('/my-lists', {
									method: 'POST',
									headers: {
										'Content-Type': 'application/json'
									},
									body: JSON.stringify(param)
								})
								.then(function (res) {
									return res.json();
								})
								.then(function (data) {
									if (data === 1) {
										alert('등록 완료');
									} else {
										alert('등록 오류');
									}
									location.reload();
								})
							}

							/* 마이리스트 삭제 */
							function deleteMyList() {
								fetch('/my-lists/${param.fiNum}', {
									method: 'DELETE'
								})
								.then(function (res) {
									return res.json();
								})
								.then(function (data) {
									if (data === 1) {
										alert('취소 완료');
									} else {
										alert('취소 오류');
									}
									location.reload();
								})
							}

							function getLikeCount() {
								fetch("/festival/like/count/${param.fiNum}")
									.then((response) => {

										if (!response.ok) {
											// create error object and reject if not a 2xx response code
											let err = new Error("HTTP status code: " + response.status)
											err.response = response
											err.status = response.status
											throw err
										}

										console.log("response", response);
										return response.text();

									})
									.then((res) => { // 좋아요 개수 가져오기
										document.getElementById('like_cnt').innerHTML = res;
									})
									.catch((err) => {
										console.log("좋아요 개수 가져오기 에러", err);
									})

							}


							fetch("/festival/like/state/${param.fiNum}")
								.then((response) => {

									if (!response.ok) {
										// create error object and reject if not a 2xx response code
										let err = new Error("HTTP status code: " + response.status)
										err.response = response
										err.status = response.status
										throw err
									}

									return response.text();

								})
								.then((result) => {
									console.log("result", result);

									const likeBtn = $("#like");

									if (result === "ACTIVE") likeBtn.addClass("active");

									if (result === "UN_ACTIVE") likeBtn.removeClass("active");

									getLikeCount();
									// 좋아요 개수 가져오기


								})
								.catch((error) => {

									console.error('실패:', error);
									alert("좋아요 상태 가져오지 못함");
								});


							document.getElementById("like").addEventListener('click', function () {
								console.log("handle like button");
								// 좋아요 로직 구현

								fetch("/festival/like/${param.fiNum}", {
									method: "PUT",
								})
									.then((response) => {

										if (!response.ok) {
											// create error object and reject if not a 2xx response code
											let err = new Error("HTTP status code: " + response.status)
											err.response = response
											err.status = response.status
											throw err
										}

										return response.text();

									})
									.then((result) => {

										const likeBtn = $("#like");

										if (result === "INSERT") likeBtn.addClass("active");

										if (result === "DELETE") likeBtn.removeClass("active");

										getLikeCount(); // 좋아요 개수 가져오기


									})
									.catch((error) => {
										alert("로그인을 해주시길 바랍니다");
									});

							})
							window.onload = function () {
								getFestivalItem();
								getMyListFiNum();
							}

							async function getFestivalItem() {
								const ready = document.querySelector('#readyState');
								ready.innerHTML = '<div class="spinner-border text-primary" role="status"><span class="visually-hidden">Loading...</span></div>';
								const fest = await fe("/festival-info/${param.fiNum}")
								if (fest.status === 500) {
									alert('잘못된 요청입니다.');
									location.replace("/");
									return;
								}
								let html = '';
								if (!fest) {
									ready.insertAdjacentHTML("afterbegin", '<div class="alert alert-danger" role="alert" onclick="location.reload()">페이지를 불러오는 데 실패하였습니다. 접속한 페이지의 주소가 맞다면, <b>새로고침</b> 해주세요.</div>');
									return;
								}
								if (fest.firstimage) {
									html += '<tr><td colspan=4><img src="' + fest.firstimage + '" class="img-fluid"></td></tr>';
								}
								html += '<tr><td width="200px">축제명</td><td colspan=3>' + fest.title + '</td></tr>';
								html += '<tr><td>위치</td><td colspan=3>' + fest.addr1;
								if (fest.addr2) {
									html += ' ' + fest.addr2;
								}
								html += '</td></tr>';
								html += '<tr><td width=15%>시작일자</td><td width=35%>' + fest.eventstartdate.substr(0, 4) + '년 ' + fest.eventstartdate.substr(4, 2) + '월 ' + fest.eventstartdate.substr(6, 2) + '일' + '</td>';
								html += '<td width=15%>종료일자</td><td>' + fest.eventenddate.substr(0, 4) + '년 ' + fest.eventenddate.substr(4, 2) + '월 ' + fest.eventenddate.substr(6, 2) + '일' + '</td></tr>';

								document.querySelector('#festivalInfo').innerHTML = html;
								document.querySelector('title').insertAdjacentText("beforeend", ' - ' + fest.title);
								ready.remove();
								const readyLoc = document.querySelector('#readyStateLoc');

								//상세정보 불러오기
								readyLoc.innerHTML = '<div class="spinner-border text-primary" role="status"><span class="visually-hidden">Loading...</span></div>';
								let url = "contentid=" + fest.contentid + "&mapx=" + fest.mapx + "&mapy=" + fest.mapy
								const detailData = await fe("/festival-details?" + url)
								const deatilFest = detailData.festivalInfo;
								html = '';
								if (deatilFest) {
									if (deatilFest.telname) {
										html += '<tr><td>전화번호</td><td>' + fest.tel + '</td>';
										html += '<td>받는 이</td><td>' + deatilFest.telname + '</td></tr>';
									} else {
										html += '<tr><td>전화번호</td><td colspan=3>' + fest.tel + '</td></tr>';
									}
									if (deatilFest.homepage) {
										html += '<tr><td>홈페이지</td><td colspan=3>' + deatilFest.homepage + '</td></tr>';
									}
								}
								const fesIntro = detailData.festivalIntro;
								if (fesIntro) {
									if (fesIntro.agelimit) {
										html += '<tr><td>연령 제한</td><td>' + fesIntro.agelimit + '</td></tr>';
									}
									if (fesIntro.playtime && fesIntro.spendtimefestival) {
										html += '<tr><td>운영 시간</td><td>' + fesIntro.playtime + '</td>';
										html += '<td>관람 소요 시간</td><td>' + fesIntro.spendtimefestival + '</td></tr>';
									} else if (fesIntro.spendtimefestival) {
										html += '<tr><td>관람 소요 시간</td><td colspan=3>' + fesIntro.spendtimefestival + '</td></tr>';
									} else if (fesIntro.playtime) {
										html += '<tr><td>운영 시간</td><td colspan=3>' + fesIntro.playtime + '</td></tr>';
									}
									if (fesIntro.usetimefestival) {
										html += '<tr><td>비용</td><td>' + fesIntro.usetimefestival + '</td></tr>';
									}
									if (fesIntro.subevent) {
										html += '<tr><td>부대 행사</td><td colspan=3>' + fesIntro.subevent + '</td></tr>';
									}
									if (fesIntro.bookingplace) {
										html += '<tr><td>예매처</td><td colspan=3>' + fesIntro.bookingplace + '</td></tr>';
									}
								}
								if (deatilFest && deatilFest.overview) {
									html += '<tr><td colspan=4>' + deatilFest.overview + '</td></tr>';
								}
								document.querySelector('#festivalInfo').insertAdjacentHTML("beforeend", html);
								const fesPictures = detailData.festivalImages;
								if (fesPictures != null && fesPictures.length !== 0) {
									let imghtml = '';
									if (fesPictures.length >= 1) {
										for (let fesPicture of fesPictures) {
											imghtml += '<img src="' + fesPicture.originimgurl + '" width="180px" height="180px" title="' + fesPicture.imgname + '" class="img-thumbnail" onclick="openModal(this)">';
										}
									}
									document.querySelector('#thumbImgs').insertAdjacentHTML('beforeend', imghtml);
								}
								if (detailData.locationInfo) {
									html = '<ul class="list-group">';
									const locations = detailData.locationInfo;
									for (let location of locations) {
										html += '<li class="list-group-item"><img src="'
										html += (location.firstimage2) ? location.firstimage : '/resources/images/noimg.jpg';
										html += '" width="100px"><br>' + location.title + '<br><a href="https://map.kakao.com/link/to/' + location.title + ',' + location.mapy + ',' + location.mapx + '" target="_blank">' + location.addr1 + '</a></li>';
									}
									html += '</ul>';
								} else {
									html = '<br><h3>해당하는 관광지를 찾을 수 없습니다.</h3>';
								}
								document.querySelector('#location').insertAdjacentHTML('beforeend', html);
								readyLoc.remove();
								makeKakaoMap(fest);
							}
							function makeKakaoMap(data) {
								var container = document.getElementById('map'); //지도를 담을 영역의 DOM 레퍼런스
								if (data.mapx != 0) {
									let mlevel = (data.mlevel != "") ? data.mlevel : 4;
									var options = { //지도를 생성할 때 필요한 기본 옵션
										center: new kakao.maps.LatLng(data.mapy, data.mapx), //지도의 중심좌표.
										level: mlevel //지도의 레벨(확대, 축소 정도)
									};

									var map = new kakao.maps.Map(container, options); //지도 생성 및 객체 리턴

									// 마커가 표시될 위치입니다 
									var markerPosition = new kakao.maps.LatLng(data.mapy, data.mapx);

									// 마커를 생성합니다
									var marker = new kakao.maps.Marker({
										position: markerPosition
									});

									// 마커가 지도 위에 표시되도록 설정합니다
									marker.setMap(map);
									var iwContent = '<div style="padding:5px;">' + data.title + ' <br><a href="https://map.kakao.com/link/to/' + data.title + ',' + data.mapy + ',' + data.mapx + '" target="_blank">길찾기</a></div>', // 인포윈도우에 표출될 내용으로 HTML 문자열이나 document element가 가능합니다
										iwPosition = new kakao.maps.LatLng(data.mapy, data.mapx); //인포윈도우 표시 위치입니다

									// 인포윈도우를 생성합니다
									var infowindow = new kakao.maps.InfoWindow({
										position: iwPosition,
										content: iwContent
									});

									// 마커 위에 인포윈도우를 표시합니다. 두번째 파라미터인 marker를 넣어주지 않으면 지도 위에 표시됩니다
									infowindow.open(map, marker);
								} else {
									document.querySelector('#map').remove();
								}
							}
							const myModal = document.querySelector('#myModal')
							const closeBtn = document.querySelector('.close')
							function openModal(img) {
								const myImg = document.querySelector('#myImg')
								myImg.src = img.src;
								const getImg = new Image();
								getImg.src = myImg.src;
								myImg.style.top = ((window.screen.height - getImg.height) - 200) / 4 + 'px';
								closeBtn.style.top = ((window.outerHeight - getImg.height) - 300) / 4 + 'px';
								myModal.style.display = 'block';
							}
							document.querySelector('.close').onclick = function () {
								myModal.style.display = "none";
							}

							window.onclick = function (event) {
								if (event.target == myModal) {
									myModal.style.display = "none";
								}
							}
							
							var fiNum = '${viewItem.fiNum}';

							$('[name=commentInsertBtn]').click(function(){
								var insertData = $('[name=commentInsertForm]').serialize();
								commentInsert(insertData);
							});

							//댓글 목록
							function commentList(){
							    $.ajax({
							        url : '/comment/list',
							        type : 'get',
							        data : {'fiNum':fiNum},
							        success : function(data){
							            var a =''; 
							            $.each(data, function(key, value){ 
							                a += '<div class="commentArea" style="border-bottom:1px solid darkgray; margin-bottom: 15px;">';
							                a += '<div class="commentInfo'+value.ciNum+'">'+'댓글번호 : '+value.ciNum+' / 작성자 : '+value.ciWriter;
							                a += '<a onclick="commentUpdate('+value.ciNum+',\''+value.ciContent+'\');" style="color: blue;"> 수정 </a>';
							                a += '<a onclick="commentDelete('+value.ciNum+');" style="color: blue;"> 삭제 </a> </div>';
							                a += '<div class="commentContent'+value.ciNum+'"> <p> 내용 : '+value.ciContent +'</p>';
							                a += '</div></div>';
							            });
							            
							            $(".commentList").html(a);
							        }
							    });
							}
							 
							//댓글 등록
							function commentInsert(insertData){
							    $.ajax({
							        url : '/comment/insert',
							        type : 'post',
							        data : insertData,
							        success : function(data){
							            if(data == 1) {
							                commentList(); //댓글 작성 후 댓글 목록 reload
							                $('[name=ciContent]').val('');
							            }
							        }
							    });
							}
							 
							//댓글 수정 - 댓글 내용 출력을 input 폼으로 변경 
							function commentUpdate(ciNum, ciContent){
							    var a ='';
							    
							    a += '<div class="input-group">';
							    a += '<input type="text" class="form-control" name="content_'+ciNum+'" value="'+ciContent+'"/>';
							    a += '<span class="input-group-btn"><button class="btn btn-default" type="button" onclick="commentUpdateProc('+ciNum+');">수정</button> </span>';
							    a += '</div>';
							    
							    $('.commentContent'+ciNum).html(a);
							    
							}
							 
							//댓글 수정
							function commentUpdateProc(ciNum){
							    var updateContent = $('[name=content_'+ciNum+']').val();
							    
							    $.ajax({
							        url : '/comment/update',
							        type : 'post',
							        data : {'ciContent' : updateContent, 'ciNum' : ciNum},
							        success : function(data){
							            if(data == 1) commentList(fiNum); //댓글 수정후 목록 출력 
							        }
							    });
							}
							 
							//댓글 삭제 
							function commentDelete(ciNum){
							    $.ajax({
							        url : '/comment/delete/'+ciNum,
							        type : 'post',
							        success : function(data){
							            if(data == 1) commentList(fiNum); //댓글 삭제후 목록 출력 
							        }
							    });
							}
							 
							 
							 
							 
							$(document).ready(function(){
							    commentList(); //페이지 로딩시 댓글 목록 출력 
							});
						</script>
			</body>

			</html>