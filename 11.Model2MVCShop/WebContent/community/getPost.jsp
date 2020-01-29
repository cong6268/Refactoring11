<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page pageEncoding="EUC-KR"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

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
		
		//============= ȸ���������� Event  ó�� =============	
		$(function() {
			//==> DOM Object GET 3���� ��� ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
			 $( "button" ).on("click" , function() {
					self.location = "/community/updatePost?postId=${post.postId}"
			 });
		});
		
		$(function() {
				//==> DOM Object GET 3���� ��� ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
			 $( "a[href='#']" ).on("click" , function() {
					self.location = "/community/deletePost?postId=${post.postId}"
			 });
		});
		//���ƿ� ����
		function like(){
			console.log($('#likeform').serialize());
			$.ajax({
				url: '/community/json/likeUpdate',
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
		  	var postId = $('#postId', frm_read).val();
			//var userId = $('#userId', frm_read).val();
			//console.log("postId, userId : "+postId+","+userId);
			console.log($('#frm_read').serialize());  
			$.ajax({
				url : '/community/json/like' ,
				type : "POST" ,
				cache : false ,
				dataType : "json" ,
				data : $('#frm_read').serialize() ,
				success : function(data) {
					var msg = '';
					var like_img = '';
					msg += data.msg;
					alert(msg);
					
					if(data.likeCheck == 'F'){
					  like_img = "��";
					}else{
					  like_img = "��";
					}      
					$('#like_img').val(like_img);
					$('#like_cnt').html(data.postLikeCount);
					$('#like_check').html(data.likeCheck);
				},
				error: function(request, status, error){
					alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
				}
			});
		}
		
	</script>
	
</head>

<body>

	<!-- ToolBar Start /////////////////////////////////////-->
	<jsp:include page="/layout/toolbar.jsp" />
   	<!-- ToolBar End /////////////////////////////////////-->
	
	<!--  ȭ�鱸�� div Start /////////////////////////////////////-->
	<div class="container">
	
		<div class="page-header">
	       <h3 class=" text-info">�Խñ���ȸ</h3>
	    </div>
	
		<div class="row">
			<div class="col-xs-8 col-md-4">${post.postTitle}</div>
		
	    <form id="likeform">
			<input type="hidden" name="postLikeCount" value="postLikeCount">
			<input type="hidden" name="postId" value="${post.postId}">
			<input type="button" value="���ƿ�!" onclick="return like()"> 
			<span id="like_result">${post.postLikeCount}</span> 
		</form>
		</div>
		
		<hr/>
		
		<div class="row">
			<div class="col-xs-8 col-md-4">${post.postWriterId.userId} || ${post.postDate}</div>
		</div>
		
		<hr/>
		
		<div class="row">
			<div class="col-xs-8 col-md-4">${post.postContent}</div>
		</div>
		
		<hr/>
		
		<c:if test="${user.userId == post.postWriterId.userId}">
		<div class="row">
	  		<div class="col-md-12 text-center ">
	  			<button type="button" class="btn btn-primary">����</button>
	  	  &nbsp;<a class="btn btn-primary btn" href="#" role="button">����</a>
	  		</div>
		</div>
		</c:if>
		
		<br/>
		
		<form id="frm_read">
		<c:choose>
		  <c:when test="${user.userId ne null}">
		    <c:if test="${like.likeCheck == 'F'}">
		      <a href='javascript: like_func();'><input type="text" value="��" id='like_img'></a>
		    </c:if>
		    <c:if test="${like.likeCheck == 'T'}">
		      <a href='javascript: like_func();'><input type="text" value="��" id='like_img'></a>
		    </c:if>
		  </c:when>
		  <c:otherwise>
		    <a href='javascript: login_need();'><input type="text" value="��"></a>
		  </c:otherwise>
		</c:choose>
			<input type="hidden" id="postId" name="postId" value="${post.postId}"/>
		</form>
		
 	</div>
 	<!--  ȭ�鱸�� div Start /////////////////////////////////////-->
	<jsp:include page="/community/comment.jsp"/>
	
</body>

</html>