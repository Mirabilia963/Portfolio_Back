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
                <!-- NAV -->
                <%@ include file="/WEB-INF/views/common/searchNav.jsp" %>
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
                        addMonthOption();
                        disableMonth();
                        addLocalOption();
                        loadFestivalList();
                    }
                    async function loadFestivalList() {
                        createList(await fe("/festival-infos" + searchUrl()));
                    }
                    yesScroll()
                    function disableMonth() {
                        const now = new Date();
                        const monthObjs = document.querySelectorAll('#fesMonth option');
                        for (let monthObj of monthObjs) {
                            monthObj.disabled = monthObj.value.trim() <= now.getMonth() && monthObj.value > 0 ? true : false;
                        }
                    }
                </script>
    </body>

    </html>