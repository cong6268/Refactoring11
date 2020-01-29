<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page pageEncoding="EUC-KR"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

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
		
		//============= 회원정보수정 Event  처리 =============	
		$(function() {
			//==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
			 $( "button" ).on("click" , function() {
					self.location = "/community/updatePost?postId=${post.postId}"
			 });
		});
		
		$(function() {
				//==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
			 $( "a[href='#']" ).on("click" , function() {
					self.location = "/community/deletePost?postId=${post.postId}"
			 });
		});
		//좋아요 구현
		function like(){
			console.log($('#likeform').serialize());
			$.ajax({
				url: '/community/json/likeUpdate',
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
					  like_img = "♡";
					}else{
					  like_img = "♥";
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
	
	<!--  화면구성 div Start /////////////////////////////////////-->
	<div class="container">
	
		<div class="page-header">
	       <h3 class=" text-info">게시글조회</h3>
	    </div>
	
		<div class="row">
			<div class="col-xs-8 col-md-4">${post.postTitle}</div>
		
	    <form id="likeform">
			<input type="hidden" name="postLikeCount" value="postLikeCount">
			<input type="hidden" name="postId" value="${post.postId}">
			<input type="button" value="좋아요!" onclick="return like()"> 
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
	  			<button type="button" class="btn btn-primary">수정</button>
	  	  &nbsp;<a class="btn btn-primary btn" href="#" role="button">삭제</a>
	  		</div>
		</div>
		</c:if>
		
		<br/>
		
		<form id="frm_read">
		<c:choose>
		  <c:when test="${user.userId ne null}">
		    <c:if test="${like.likeCheck == 'F'}">
		      <a href='javascript: like_func();'><input type="text" value="♡" id='like_img'></a>
		    </c:if>
		    <c:if test="${like.likeCheck == 'T'}">
		      <a href='javascript: like_func();'><input type="text" value="♥" id='like_img'></a>
		    </c:if>
		  </c:when>
		  <c:otherwise>
		    <a href='javascript: login_need();'><input type="text" value="♡"></a>
		  </c:otherwise>
		</c:choose>
			<input type="hidden" id="postId" name="postId" value="${post.postId}"/>
		</form>
		
 	</div>
 	<!--  화면구성 div Start /////////////////////////////////////-->
	<jsp:include page="/community/comment.jsp"/>
	
</body>

</html>