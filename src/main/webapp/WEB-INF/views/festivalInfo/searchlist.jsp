<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html>

    <head>
        <meta charset="UTF-8">
        <title>Insert title here</title>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
        <link rel="stylesheet" href="/resources/css/festival.css">
    </head>

    <body>
        <!-- HEADER -->
        <%@ include file="/WEB-INF/views/common/header.jsp" %>
            <main>
                <div id="searchOption" class="container">
                    <input type="number" id="page" value="${param.page}" hidden>
                    <input type="number" id="rows" value="${param.rows}" hidden>
                    <input type="text" id="fesTitle" value="${param.fesTitle}" hidden>
                    <div id="totalNum"></div>
                </div>
                <div class="container">
                    <h3><br> 검색 결과</h3>
                </div>
                <!-- Festival List -->
                <%@ include file="/WEB-INF/views/common/festivalList.jsp" %>
            </main>
            <!-- FOOTER -->
            <%@ include file="/WEB-INF/views/common/footer.jsp" %>
                <script src="/resources/js/createFestivalList.js"></script>
                <script src="/resources/js/searchOption.js"></script>
                <script src="/resources/js/common.js"></script>
                <script>

                    window.onload = function () {
                        loadFestivalList();
                    }
                    function loadFestivalList() {
                        if (!document.querySelector('#page').value) {
                            document.querySelector('#page').value = 1;
                        }
                        if (!document.querySelector('#rows').value) {
                            document.querySelector('#rows').value = 10;
                        }
                        fe("/festival-search" + searchUrl())
                            .then(jsonData => {
                                createList(jsonData);
                                if (jsonData.endRow === 0) {
                                    return;
                                }
                                const paging = document.querySelector('.paginaiton');
                                html = '<div class="container d-flex justify-content-center"><ul class="pagination">';
                                if (jsonData.pageNum === 1) {
                                    html += '<li class="page-item disabled"><a class="page-link" href="#">첫 페이지</a></li>';
                                } else {
                                    html += '<li class="page-item"><a class="page-link" href="/views/festivalInfo/searchlist?fesTitle=${param.fesTitle}&page=1">첫 페이지</a></li>';
                                }
                                if (jsonData.prePage === 0) {
                                    html += '<li class="page-item disabled"><a class="page-link" href="#">&lt;</a></li>';
                                } else {
                                    html += '<li class="page-item"><a class="page-link" href="/views/festivalInfo/searchlist?fesTitle=${param.fesTitle}&page=' + jsonData.prePage + '">&lt;</a></li> ';
                                }
                                for (pageNum of jsonData.navigatepageNums) {
                                    if (pageNum === jsonData.pageNum) {
                                        html += '<li class="page-item disabled"><a class="page-link" href="#">' + pageNum + '</a></li>';
                                    } else {
                                        html += '<li class="page-item"><a class="page-link" href="/views/festivalInfo/searchlist?page=' + pageNum + '&fesTitle=${param.fesTitle}">';
                                        html += pageNum + '</a></li>';
                                    }
                                }
                                if (jsonData.pageNum === jsonData.pages) {
                                    html += '<li class="page-item disabled"><a class="page-link" href="#">&gt;</a></li>';
                                    html += '<li class="page-item disabled"><a class="page-link" href="#">마지막 페이지</a></li>';
                                } else {
                                    html += '<li class="page-item"><a class="page-link" href="/views/festivalInfo/searchlist?page=' + jsonData.nextPage + '&fesTitle=${param.fesTitle}">&gt;</a></li>';
                                    html += '<li class="page-item"><a class="page-link" href="/views/festivalInfo/searchlist?page=' + jsonData.pages + '&fesTitle=${param.fesTitle}">마지막 페이지</a></li>';
                                }
                                html += '</ul></div>'
                                paging.insertAdjacentHTML("beforeend", html);
                            });
                    }
                </script>
    </body>

    </html>