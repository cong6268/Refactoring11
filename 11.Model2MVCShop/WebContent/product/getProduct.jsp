<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

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
			 self.location = "/purchase/addPurchase?prodNo=${product.prodNo}";
		});
	});	
		 
	$(function() {
		 $( "button" ).on("click" , function() {
			 history.go(-1);	 
		});
	});	

	function like(){
		$.ajax({
			url: '/product/json/likeUpdate',
			type: "POST",
			cache: false,
			dataType: "json",
			data: $('#likeform').serialize(), //아이디가 like_form인 곳의 모든 정보를 가져와 파라미터 전송 형태(표준 쿼리형태)로 만들어줌
			success:
			function(data){ //ajax통신 성공시 넘어오는 데이터 통째 이름 =data
				alert("'좋아요'가 반영되었습니다!") ; // data중 put한 것의 이름 like
				$("#like_result").html(data.like); //id값이 like_result인 html을 찾아서 data.like값으로 바꿔준다.
			},
			error:
			function (request, status, error){
				alert("ajax실패")
			}
		});
	}
 	
	function login_need(){
		alert("로그인 후 이용 가능")
	}
	
	function like_func(){
		var frm_read = $('#frm_read');
	  	var prodNo = $('#prodNo', frm_read).val();
		//var userId = $('#userId', frm_read).val();
		//console.log("prodNo, userId : "+prodNo+","+userId);
		  
		$.ajax({
			url : '/product/json/like' ,
			type : "POST" ,
			cache : false ,
			dataType : "json" ,
			data : $('#frm_read').serialize() ,
			success : function(data) {
				var msg = '';
				var like_img = '';
				msg += data.msg;
				alert(msg);
				
				if(data.like_check == 0){
				  like_img = "♡";
				}else{
				  like_img = "♥";
				}      
				$('#like_img').val(like_img);
				$('#like_cnt').html(data.like_cnt);
				$('#like_check').html(data.like_check);
			},
			error: function(request, status, error){
				alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
			}
		});
	}
 	
	/* $(document).ready(function(){
		like_func();
	}); */

	</script>

</head>

<body>

	<jsp:include page="/layout/toolbar.jsp" />

	<div class="container">

		<div class="page-header">
	       <h3 class=" text-info">상품상세조회</h3>
	    </div>
	    
	    <form id="likeform">
			<input type="hidden" name="command" value="likeIt">
			<input type="hidden" name="prodNo" value="${product.prodNo}">
			<input type="button" value="좋아요!" onclick="return like()"> 
			<div id="like_result">${product.likeIt}</div> 
		</form>
	    
	    <div class="row">
	  		<div class="col-xs-4 col-md-2"><strong>상품번호</strong></div>
			<div class="col-xs-8 col-md-4">${product.prodNo}</div>
		</div>
	    
	    <hr/>
	    
	    <div class="row">
	  		<div class="col-xs-4 col-md-2"><strong>상품명</strong></div>
			<div class="col-xs-8 col-md-4">${product.prodName}</div>
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
	  		<div class="col-xs-4 col-md-2"><strong>남은수량</strong></div>
			<div class="col-xs-8 col-md-4">${product.stock}개</div>
		</div>
		
		<hr/>
		
		<div class="row">
	  		<div class="col-xs-4 col-md-2"><strong>등록일자</strong></div>
			<div class="col-xs-8 col-md-4">${product.regDate}</div>
		</div>

		<hr/>

		<div class="row">
	  		<div class="col-md-12 text-center ">
	  			<a class="btn btn-primary btn" href="#" role="button">구매</a>
	  			<button type="button" class="btn btn-primary">이전</button>
	  		</div>
		</div>
		
		<br/>
		
		<form id="frm_read">
		<c:choose>
		  <c:when test="${user.userId ne null}">
		    <c:if test="${likeprod.likeCheck == 0}">
		      <a href='javascript: like_func();'><input type="text" value="♡" id='like_img'></a>
		    </c:if>
		    <c:if test="${likeprod.likeCheck == 1}">
		      <a href='javascript: like_func();'><input type="text" value="♥" id='like_img'></a>
		    </c:if>
		  </c:when>
		  <c:otherwise>
		    <a href='javascript: login_need();'><input type="text" value="♡"></a>
		  </c:otherwise>
		</c:choose>
			<input type="hidden" id="prodNo" name="prodNo" value="${product.prodNo}"/>
		</form>
		
 	</div>

</body>
</html>