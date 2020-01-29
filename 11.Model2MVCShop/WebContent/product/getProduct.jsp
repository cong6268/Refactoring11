<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

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
			data: $('#likeform').serialize(), //���̵� like_form�� ���� ��� ������ ������ �Ķ���� ���� ����(ǥ�� ��������)�� �������
			success:
			function(data){ //ajax��� ������ �Ѿ���� ������ ��° �̸� =data
				alert("'���ƿ�'�� �ݿ��Ǿ����ϴ�!") ; // data�� put�� ���� �̸� like
				$("#like_result").html(data.like); //id���� like_result�� html�� ã�Ƽ� data.like������ �ٲ��ش�.
			},
			error:
			function (request, status, error){
				alert("ajax����")
			}
		});
	}
 	
	function login_need(){
		alert("�α��� �� �̿� ����")
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
				  like_img = "��";
				}else{
				  like_img = "��";
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
	       <h3 class=" text-info">��ǰ����ȸ</h3>
	    </div>
	    
	    <form id="likeform">
			<input type="hidden" name="command" value="likeIt">
			<input type="hidden" name="prodNo" value="${product.prodNo}">
			<input type="button" value="���ƿ�!" onclick="return like()"> 
			<div id="like_result">${product.likeIt}</div> 
		</form>
	    
	    <div class="row">
	  		<div class="col-xs-4 col-md-2"><strong>��ǰ��ȣ</strong></div>
			<div class="col-xs-8 col-md-4">${product.prodNo}</div>
		</div>
	    
	    <hr/>
	    
	    <div class="row">
	  		<div class="col-xs-4 col-md-2"><strong>��ǰ��</strong></div>
			<div class="col-xs-8 col-md-4">${product.prodName}</div>
		</div>
		
		<hr/>
		
		<div class="row">
	  		<div class="col-xs-4 col-md-2"><strong>��ǰ�̹���</strong></div>
			<div class="col-xs-8 col-md-4">
				<c:forEach var="files" items="${fn:split(product.fileName,',')}">
					<img src = "/images/uploadFiles/${files}"/>
				</c:forEach>
		  </div>
		</div>
		
		<hr/>
		
		<div class="row">
	  		<div class="col-xs-4 col-md-2"><strong>��ǰ������</strong></div>
			<div class="col-xs-8 col-md-4">${product.prodDetail}</div>
		</div>
		
		<hr/>
		
		<div class="row">
	  		<div class="col-xs-4 col-md-2"><strong>��������</strong></div>
			<div class="col-xs-8 col-md-4">${product.manuDate}</div>
		</div>
		
		<hr/>
		
		<div class="row">
	  		<div class="col-xs-4 col-md-2"><strong>����</strong></div>
			<div class="col-xs-8 col-md-4">${product.price}</div>
		</div>
		
		<hr/>
		
		<div class="row">
	  		<div class="col-xs-4 col-md-2"><strong>��������</strong></div>
			<div class="col-xs-8 col-md-4">${product.stock}��</div>
		</div>
		
		<hr/>
		
		<div class="row">
	  		<div class="col-xs-4 col-md-2"><strong>�������</strong></div>
			<div class="col-xs-8 col-md-4">${product.regDate}</div>
		</div>

		<hr/>

		<div class="row">
	  		<div class="col-md-12 text-center ">
	  			<a class="btn btn-primary btn" href="#" role="button">����</a>
	  			<button type="button" class="btn btn-primary">����</button>
	  		</div>
		</div>
		
		<br/>
		
		<form id="frm_read">
		<c:choose>
		  <c:when test="${user.userId ne null}">
		    <c:if test="${likeprod.likeCheck == 0}">
		      <a href='javascript: like_func();'><input type="text" value="��" id='like_img'></a>
		    </c:if>
		    <c:if test="${likeprod.likeCheck == 1}">
		      <a href='javascript: like_func();'><input type="text" value="��" id='like_img'></a>
		    </c:if>
		  </c:when>
		  <c:otherwise>
		    <a href='javascript: login_need();'><input type="text" value="��"></a>
		  </c:otherwise>
		</c:choose>
			<input type="hidden" id="prodNo" name="prodNo" value="${product.prodNo}"/>
		</form>
		
 	</div>

</body>
</html>