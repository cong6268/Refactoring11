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
		
		 $( "a[href='#']" ).on("click" , function() {
			 self.location = "/product/listProduct?menu=manage";	 
		});
	});
	
	$(function() {
		
		 $( "button" ).on("click" , function() {
			 self.location = "../product/addProductView.jsp;"; 
		});
	});	
	
</script>

</head>

<body>

	<jsp:include page="/layout/toolbar.jsp" />

	<div class="container">

		<div class="page-header">
	       <h3 class=" text-info">상품등록완료!</h3>
	    </div>
	    
	    <div class="row">
	  		<div class="col-xs-4 col-md-2"><strong>상품명</strong></div>
			<div class="col-xs-8 col-md-4">${product.prodName}</div>
		</div>
		
		<hr/>
		
		<div class="row">
	  		<div class="col-xs-4 col-md-2"><strong>상품상세정보</strong></div>
			<div class="col-xs-8 col-md-4">${product.prodDetail}</div>
		</div>
		
		<hr/>
		
		<div class="row">
	  		<div class="col-xs-4 col-md-2"><strong>제조일자</strong></div>
			<div class="col-xs-8 col-md-4">${product.manuDate}</div>
		</div>
		
		<hr/>
		
		<div class="row">
	  		<div class="col-xs-4 col-md-2"><strong>가격</strong></div>
			<div class="col-xs-8 col-md-4">${product.price}</div>
		</div>
		
		<hr/>
		
		<div class="row">
	  		<div class="col-xs-4 col-md-2"><strong>등록수량</strong></div>
			<div class="col-xs-8 col-md-4">${product.stock}개</div>
		</div>
		
		<hr/>
		
		<div class="row">
	  		<div class="col-xs-4 col-md-2"><strong>상품이미지</strong></div>
			<div class="col-xs-8 col-md-4">
				<c:forEach var="files" items="${fn:split(product.fileName,',')}">
					<img src = "/images/uploadFiles/${files}"/>
				</c:forEach>
		  </div>
		</div>

		<hr/>

		<div class="row">
	  		<div class="col-md-12 text-center ">
	  			<a class="btn btn-primary btn" href="#" role="button">확인</a>
	  			<button type="button" class="btn btn-primary">추가등록</button>
	  		</div>
		</div>
		
		<br/>
		
 	</div>

</body>
</html>