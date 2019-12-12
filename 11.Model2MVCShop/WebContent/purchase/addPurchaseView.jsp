<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>

<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
	<meta charset="EUC-KR">
	
	<!-- 참조 : http://getbootstrap.com/css/   참조 -->
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />
	
	<!--  ///////////////////////// Bootstrap, jQuery CDN ////////////////////////// -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" >
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" >
	<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
	<link rel="stylesheet" href="/resources/demos/style.css">
	
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script>
	<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
	<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>

	<!--  ///////////////////////// CSS ////////////////////////// -->
	<style></style>
    
     <!--  ///////////////////////// JavaScript ////////////////////////// -->
	<script type="text/javascript">

	function fncAddPurchase() {
		
		$("form").attr("method" , "POST").attr("action" , "/purchase/addPurchase").submit();
	}
	
	$(function() {
		 $( "button.btn.btn-primary" ).on("click" , function() {
			 fncAddPurchase();
		});
	});	
	
	$(function() {
		 $( "a[href='#']" ).on("click" , function() {		
			$("form")[0].reset();
		});
	});	
	
	$( function() {
	    $( "#datepicker" ).datepicker( { dateFormat: 'yy-mm-dd' } );
	});

</script>
</head>

<body>

<!-- ToolBar Start /////////////////////////////////////-->
	<div class="navbar  navbar-default">
        <div class="container">
        	<a class="navbar-brand" href="/index.jsp">SHOW YOURSELF</a>
   		</div>
   	</div>
   	<!-- ToolBar End /////////////////////////////////////-->

	<!--  화면구성 div Start /////////////////////////////////////-->
	<div class="container">
	
		<div class="page-header text-center">
	       <h3 class=" text-info">구매정보등록</h3>
	    </div>
		
		<!-- form Start /////////////////////////////////////-->
		<form class="form-horizontal">
		
		 <input type="hidden" name="prodNo" value="${product.prodNo}"/>
		  <h4 class="alert alert-info" align="center">상품정보 (수정불가)</h4>
		  <div class="form-group">
		    <label for="prodNo" class="col-sm-offset-1 col-sm-3 control-label">상품번호</label>
		    <div class="col-sm-4">
		      <input type="text" readonly="readonly" class="form-control" id="prodNo" name="prodNo" value="${product.prodNo}">
		    </div>
		  </div>
		
		  <div class="form-group">
		    <label for="prodName" class="col-sm-offset-1 col-sm-3 control-label">상품명</label>
		    <div class="col-sm-4">
		      <input type="text" readonly="readonly" class="form-control" id="prodName" name="prodName" value="${product.prodName}">
		    </div>
		  </div>
		
		<div class="form-group">
		    <label for="prodDetail" class="col-sm-offset-1 col-sm-3 control-label">상품상세정보</label>
		    <div class="col-sm-4">
		      <input type="text" readonly="readonly" class="form-control" id="prodDetail" name="prodDetail" value="${product.prodDetail}">
		    </div>
		  </div>
		
		<div class="form-group">
		    <label for="manuDate" class="col-sm-offset-1 col-sm-3 control-label">제조일자</label>
		    <div class="col-sm-4">
		      <input type="text" readonly="readonly" class="form-control" id="manuDate" name="manuDate" value="${product.manuDate}">
		    </div>
		  </div>
		  
		<div class="form-group">
		    <label for="price" class="col-sm-offset-1 col-sm-3 control-label">가격</label>
		    <div class="col-sm-4">
		      <input type="text" readonly="readonly" class="form-control" id="price" name="price" value="${product.price}">
		    </div>
		  </div> 
		  
		<div class="form-group">
		    <label for="regDate" class="col-sm-offset-1 col-sm-3 control-label">등록일자</label>
		    <div class="col-sm-4">
		       <input type="text" readonly="readonly" class="form-control" id="regDate" name="regDate" value="${product.regDate}">
		    </div>
		  </div>

		<h4 class="alert alert-info" align="center">구매자정보</h4>
		<div class="form-group">
		    <label for="userId" class="col-sm-offset-1 col-sm-3 control-label">구매자아이디</label>
		    <div class="col-sm-4">
		      <input type="text" readonly="readonly" class="form-control" id="userId" name="userId" value="${user.userId}">
		    </div>
		  </div>

		  <div class="form-group">
		    <label for="prodName" class="col-sm-offset-1 col-sm-3 control-label">구매방법</label>
		    <div class="col-sm-4">
		      <select class="form-control" id="paymentOption" name="paymentOption">
				<option value="1"  ${ !empty search.searchCondition && search.searchCondition==1 ? "selected" : ""}>현금구매</option>
				<option value="2"  ${ !empty search.searchCondition && search.searchCondition==2 ? "selected" : ""}>신용구매</option>
			</select>
		    </div>
		  </div>
		
		<div class="form-group">
		    <label for="receiverName" class="col-sm-offset-1 col-sm-3 control-label">구매자이름</label>
		    <div class="col-sm-4">
		      <input type="text" class="form-control" id="receiverName" name="receiverName" value="${user.userName}">
		    </div>
		  </div>
		  
		<div class="form-group">
		    <label for="quantity" class="col-sm-offset-1 col-sm-3 control-label">구매수량</label>
		    <div class="col-sm-4">
		      <input type="text" class="form-control" id="quantity" name="quantity" value="${product.stock}">
		    </div>
		  </div>  
		
		<div class="form-group">
		    <label for="receiverPhone" class="col-sm-offset-1 col-sm-3 control-label">구매자연락처</label>
		    <div class="col-sm-4">
		      <input type="text" class="form-control" id="receiverPhone" name="receiverPhone" value="${user.phone}">
		    </div>
		  </div>
		  
		<div class="form-group">
		    <label for="divyAddr" class="col-sm-offset-1 col-sm-3 control-label">구매자주소</label>
		    <div class="col-sm-4">
		      <input type="text" class="form-control" id="divyAddr" name="divyAddr" value="${user.addr}">
		    </div>
		  </div> 
		  
		<div class="form-group">
		    <label for="divyRequest" class="col-sm-offset-1 col-sm-3 control-label">구매요청사항</label>
		    <div class="col-sm-4">
		       <input type="text" class="form-control" id="divyRequest" name="divyRequest" value="${purchase.divyRequest}">
		    </div>
		  </div>
		  
		<div class="form-group">
		    <label for="divyDate" class="col-sm-offset-1 col-sm-3 control-label">배송희망일자</label>
		    <div class="col-sm-4">
		       <input type="text" id="datepicker" class="form-control" id="divyDate" name="divyDate">
		    </div>
		  </div>

		<div class="form-group">
		    <div class="col-sm-offset-4  col-sm-4 text-center">
		      <button type="button" class="btn btn-primary"  >구 &nbsp;매</button>
			  <a class="btn btn-primary btn" href="#" role="button">취&nbsp;소</a>
		    </div>
		  </div>
		</form>
		
	</div>
	
</body>
</html>