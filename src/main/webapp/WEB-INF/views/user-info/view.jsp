<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Insert title here</title>
<link href="https://hangeul.pstatic.net/hangeul_static/css/nanum-square-round.css" rel="stylesheet">
    <script src="https://kit.fontawesome.com/53a8c415f1.js" crossorigin="anonymous"></script>
    <link href="/resources/css/info.css" rel="stylesheet" type="text/css">
</head>
<body>
<!-- HEADER -->
         <%@ include file="/WEB-INF/views/common/header.jsp" %>
<!-- main -->

   <div class="wrap">
      <div class="info">
         <div id="infotitle">회원정보</div>
         <div class="info_name">
            <h5>이름</h5>
            <input type="text" name="name" placeholder="${userInfo.uiName}" readonly>
         </div>
         <div class="info_nick">
            <h5>닉네임</h5>
            <input type="text" name="nickname"
               placeholder="${userInfo.uiNickname}" readonly>
         </div>
         <div class="update">
            <div class="update-info"></div>

         </div>


         <div id="confirm" style="display: none">
            <input type="password" id="uiPwd" placeholder="비밀번호를 입력해주세요">
            <button class="check-btn" onclick="passwordConfirm()">확인</button>
         </div>
         <button class="update-btn" onclick="showConfirm('update')">수정</button>
         <button class="delete-btn" onclick="showConfirm('delete')">탈퇴</button>
      </div>
   </div>

   <!-- FOOTER -->
            <%@ include file="/WEB-INF/views/common/footer.jsp" %>
   <script>
      let _type;
      function showConfirm(type) {
         _type = type;
         document.querySelector('#confirm').style.display = '';
      }
      function passwordConfirm() {
         let method = 'POST'
         if (_type === 'delete') {
            method = 'DELETE';
         }
         const param = {
            uiPwd : document.querySelector('#uiPwd').value
         }
         fetch('/user-infos/${userInfo.uiNum}', {
            method : method,
            headers : {
               'Content-Type' : 'application/json'
            },
            body : JSON.stringify(param)
         }).then(function(res) {
            return res.json();
         }).then(function(data) {
            if (data === true) {
               if (_type === 'update') {
                  location.href = '/views/user-info/update';
               } else if (_type === 'delete') {
                  alert('삭제완료!');
                  location.href = '/auth/logout';
               }
            } else {
               alert('비밀번호를 확인해주세요');
            }
         })
      }
   </script>
</body>
