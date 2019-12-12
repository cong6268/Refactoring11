<%@ page contentType="text/html; charset=euc-kr" %>
<%@ page pageEncoding="EUC-KR"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!DOCTYPE html>

<html lang="ko">
<head>
	<meta charset="EUC-KR">
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />
	
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" >
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" >
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script>
	
   <link href="/css/animate.min.css" rel="stylesheet">
   <link href="/css/bootstrap-dropdownhover.min.css" rel="stylesheet">
   
   <script src="/javascript/bootstrap-dropdownhover.min.js"></script>
   
	<style>
		body {
            padding-top : 30px;
        }
    </style>
    
	<script type="text/javascript">
	
		$(function() {
			$( "button.btn.btn-primary" ).on("click" , function() {
				self.location = "/index.jsp";
			});
		});
	
	</script>

</head>

<body>

	<jsp:include page="/layout/toolbar.jsp" />

	<div class="container">

		<div class="page-header text-center">
	       <h2 class=" text-info">회원탈퇴 완료</h2>
	    </div>
	</div>    
	
	<div class="container">
		<p class="text-center">이용해주셔서 감사합니다.</p>
		<p class="text-center">보다 더 나은 서비스로 다시 찾아뵙겠습니다.</p>
   	</div>
   	
   	<hr/>
		
	<div class="row">
  		<div class="col-md-12 text-center ">
  			<button type="button" class="btn btn-primary">홈으로가기</button>
  		</div>
	</div>

</body>
</html>