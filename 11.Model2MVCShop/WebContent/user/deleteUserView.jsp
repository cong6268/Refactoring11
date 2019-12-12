<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page pageEncoding="EUC-KR"%>


<!DOCTYPE html>

<html lang="ko">
	
<head>
	<meta charset="EUC-KR">
	
	<!-- 참조 : http://getbootstrap.com/css/   참조 -->
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />
	
	<!--  ///////////////////////// Bootstrap, jQuery CDN ////////////////////////// -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" >
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" >
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script>
	
	<!-- Bootstrap Dropdown Hover CSS -->
	<link href="/css/animate.min.css" rel="stylesheet">
	<link href="/css/bootstrap-dropdownhover.min.css" rel="stylesheet">
	
	<!-- Bootstrap Dropdown Hover JS -->
	<script src="/javascript/bootstrap-dropdownhover.min.js"></script>
	
	<!--  ///////////////////////// CSS ////////////////////////// -->
	<style>
 		body {
            padding-top : 30px;
        }
	</style>
    
    <!--  ///////////////////////// JavaScript ////////////////////////// -->
	<script type="text/javascript">

		$(function() {		
			$( "a[href='#']" ).on("click" , function() {
			 	history.go(-1);
			});
		});
		
		$(function() {
			$( "button" ).on("click" , function() {

				$.ajax( 
						{
							url : "/user/json/deleteUser/"+$("input[id=\"password\"]").val()+"/"+$("input[id=\"userId\"]").val() ,
							method : "GET" ,
							dataType : "json" ,
							headers : {
								"Accept" : "application/json",
								"Content-Type" : "application/json"
							},
							success : function(JSONData , status) {
								
								if(JSONData==false){
									var displayValue = "비밀번호가 일치하지 않습니다.";
						
									$( "#text" ).html(displayValue);
									$( "#text" ).css('color' , 'red');
									
								}else{
									$("form").attr("method" , "POST").attr("action" , "/user/deleteUser").submit();
								}
							}
						});
			});
		});	
		
	</script>
	
</head>

<body>

	<!-- ToolBar Start /////////////////////////////////////-->
	<jsp:include page="/layout/toolbar.jsp" />
   	<!-- ToolBar End /////////////////////////////////////-->
	
	<!--  화면구성 div Start /////////////////////////////////////-->
	<div class="container">
	  <form class="form-horizontal">
	
		<div class="page-header">
	       <h3 class=" text-info">회원탈퇴</h3>
	    </div>
	
		<div class="form-group">
		    <label for="userId" class="col-xs-4 col-md-2">아 이 디</label>
		      <div class="col-xs-8 col-md-4">
		    	<input type="text" readonly="readonly" class="form-control" id="userId" name="userId" value="${user.userId}">
		      </div>	
	 	</div>
		
		<hr/>
		
		<div class="form-group">
		    <label for="userName" class="col-xs-4 col-md-2">이 름</label>
		      <div class="col-xs-8 col-md-4">
		    	<input type="text" readonly="readonly" class="form-control" id="userName" name="userName" value="${user.userName}">
		      </div>	
	 	</div>
		
		<hr/>
		
		<div class="form-group">
		    <label for="password" class="col-xs-4 col-md-2">비밀번호</label>
		      <div class="col-xs-8 col-md-4">
		    	<input type="password" class="form-control" id="password" name="password" placeholder="비밀번호확인">
		      </div>	
	 	</div>
	 	<p id="text" align="justify"></p>
		
		<hr/>
		
		<div class="row">
	  		<div class="col-md-12 text-center ">
	  			<button type="button" class="btn btn-primary">탈퇴하기</button>
	  	  &nbsp;<a class="btn btn-primary btn" href="#" role="button">취&nbsp;소</a>
	  		</div>
		</div>
	
	  </form>	
 	</div>
 	<!--  화면구성 div Start /////////////////////////////////////-->

</body>

</html>