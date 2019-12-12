<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page pageEncoding="EUC-KR"%>


<!DOCTYPE html>

<html lang="ko">
	
<head>
	<meta charset="EUC-KR">
	
	<!-- ���� : http://getbootstrap.com/css/   ���� -->
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
									var displayValue = "��й�ȣ�� ��ġ���� �ʽ��ϴ�.";
						
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
	
	<!--  ȭ�鱸�� div Start /////////////////////////////////////-->
	<div class="container">
	  <form class="form-horizontal">
	
		<div class="page-header">
	       <h3 class=" text-info">ȸ��Ż��</h3>
	    </div>
	
		<div class="form-group">
		    <label for="userId" class="col-xs-4 col-md-2">�� �� ��</label>
		      <div class="col-xs-8 col-md-4">
		    	<input type="text" readonly="readonly" class="form-control" id="userId" name="userId" value="${user.userId}">
		      </div>	
	 	</div>
		
		<hr/>
		
		<div class="form-group">
		    <label for="userName" class="col-xs-4 col-md-2">�� ��</label>
		      <div class="col-xs-8 col-md-4">
		    	<input type="text" readonly="readonly" class="form-control" id="userName" name="userName" value="${user.userName}">
		      </div>	
	 	</div>
		
		<hr/>
		
		<div class="form-group">
		    <label for="password" class="col-xs-4 col-md-2">��й�ȣ</label>
		      <div class="col-xs-8 col-md-4">
		    	<input type="password" class="form-control" id="password" name="password" placeholder="��й�ȣȮ��">
		      </div>	
	 	</div>
	 	<p id="text" align="justify"></p>
		
		<hr/>
		
		<div class="row">
	  		<div class="col-md-12 text-center ">
	  			<button type="button" class="btn btn-primary">Ż���ϱ�</button>
	  	  &nbsp;<a class="btn btn-primary btn" href="#" role="button">��&nbsp;��</a>
	  		</div>
		</div>
	
	  </form>	
 	</div>
 	<!--  ȭ�鱸�� div Start /////////////////////////////////////-->

</body>

</html>