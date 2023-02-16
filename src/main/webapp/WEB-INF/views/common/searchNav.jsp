<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!-- NAV -->
    <nav id="searchNav">
        <div id="searchOption" class="container">
            <input type="number" id="page" value=1 hidden>
            <input type="number" id="rows" value=15 hidden>
            <div class="row">
                <div class="col-auto">
                    <select name="" id="fesMonth" onchange="searchFestivalList()" class="form-select">

                    </select>
                </div>
                <div class="col-auto">
                    <select name="" id="fesLocal" onchange="searchFestivalList()" class="form-select">

                    </select>
                </div>
                <div class="col-auto row">
                    <input type="text" id="fesTitle" class="form-control col" placeholder="축제명 검색"><button type="button"
                        onclick="searchFestivalList()" class="btn btn-primary col-md-auto">검색</button>
                </div>
            </div>
            <div id="totalNum"></div>
        </div>
    </nav>
    <!-- NAV END -->