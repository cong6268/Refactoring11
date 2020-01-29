<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page pageEncoding="EUC-KR"%>

<!--  ///////////////////////// JSTL  ////////////////////////// -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>

<html lang="ko">
	
<head>
	<meta charset="EUC-KR">
	
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />
	
	<!--   jQuery , Bootstrap CDN  -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" >
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" >
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script>
	<script type="text/javascript" src="https://static.nid.naver.com/js/naverLogin_implicit-1.0.3.js" charset="utf-8"></script>
  	<script type="text/javascript" src="http://code.jquery.com/jquery-1.11.3.min.js"></script>

	<!-- Bootstrap Dropdown Hover CSS -->
	<link href="/css/animate.min.css" rel="stylesheet">
	<link href="/css/bootstrap-dropdownhover.min.css" rel="stylesheet">
	
	<!-- Bootstrap Dropdown Hover JS -->
	<script src="/javascript/bootstrap-dropdownhover.min.js"></script>
	
	<!--  CSS �߰� : ���ٿ� ȭ�� ������ ���� �ذ� :  �ּ�ó�� ��, �� Ȯ��-->
	<style>
        body {
            padding-top : 30px;
        }
   	</style>
   	
    <!--  ///////////////////////// JavaScript ////////////////////////// -->

	<script type="text/javascript">
		var naver_id_login = new naver_id_login("X0kM_jEGVeis5cg41QXM" , "http://localhost:8080/main.jsp");
		// ���� ��ū �� ���
		//alert(naver_id_login.oauthParams.access_token);
		// ���̹� ����� ������ ��ȸ
		naver_id_login.get_naver_userprofile("naverSignInCallback()");
		// ���̹� ����� ������ ��ȸ ���� ������ ������ ó���� callback function
		function naverSignInCallback() {
		  //alert(naver_id_login.getProfileData('name'));
		  //alert(naver_id_login.getProfileData('email'));
		  //alert(naver_id_login.getProfileData('nickname'));
		  //alert(naver_id_login.getProfileData('age'));
		}
	</script>

</head>
	
<body>

	<!-- ToolBar Start /////////////////////////////////////-->
	<jsp:include page="/layout/toolbar.jsp" />
   	<!-- ToolBar End /////////////////////////////////////-->

	<!--  �Ʒ��� ������ http://getbootstrap.com/getting-started/  ���� -->	
   	<div class="container ">
      <!-- Main jumbotron for a primary marketing message or call to action -->
      <div class="jumbotron">
        <h1 align="center"><i class="glyphicon glyphicon-leaf"></i> ${user.userId}�� ȯ���մϴ� <i class="glyphicon glyphicon-leaf"></i></h1>
      </div>
      
      <iframe width="1140" height="500" src="https://www.youtube.com/embed/cg3CeiuDemw" frameborder="0"
      		allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
    
	</div>
    
  </body>

</html>