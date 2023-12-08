<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!doctype html>
<html lang="ko">
<head>
<script type="text/javascript" src="https://static.nid.naver.com/js/naverLogin_implicit-1.0.3.js" charset="utf-8"></script>
<script type="text/javascript" src="http://code.jquery.com/jquery-1.11.3.min.js"></script>
</head>
<body>
<script type="text/javascript">
  var naver_id_login = new naver_id_login("4ti9U3l3MXudKm9oCFhb", "http://localhost:8080/tradeup/NaverLoginPro");
  // 접근 토큰 값 출력
  // 네이버 사용자 프로필 조회
  naver_id_login.get_naver_userprofile("naverSignInCallback()");
  // 네이버 사용자 프로필 조회 이후 프로필 정보를 처리할 callback function
  function naverSignInCallback() {
    let email1 = naver_id_login.getProfileData('email').split("@")[0];
    let email2 = naver_id_login.getProfileData('email').split("@")[1];
    let nickname = naver_id_login.getProfileData('nickname');
    let name = naver_id_login.getProfileData('name');
//     debugger;
    location.href="Join?email1=" + email1+"&email2="+email2+"&nickname=" + nickname + "&name=" + name;
  }
</script>
</body>
</html>


