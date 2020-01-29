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
	<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
	<!-- <link rel="stylesheet" href="/resources/demos/style.css"> -->
	<link href="https://stackpath.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet">
	
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script>
	<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
	<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
	<script src="https://stackpath.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>

	<link href="http://netdna.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.css" rel="stylesheet">
	<script src="http://netdna.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.js"></script> 

	<style></style>
    
    <!--  ///////////////////////// JavaScript ////////////////////////// -->
	<script type="text/javascript">

	jQuery(document).ready(function($){
		getCommentList(1);
	});
	
	$(function(){
		$("#addComment").on("click" , function() {
			$.ajax({
				url : '/community/json/addComment' ,
				type : "POST" ,
				cache : false ,  
				dataType : "json" ,
				data : $('#ajaxgo').serialize() ,
				success : function(data) {
					getCommentList(1);
					$('#cmtContent').val('');
				}
			});
		});
	});
	
	function getCommentList(currentPage){
		
		var postId = $("input[name='postId']").val();

		$.ajax({
			url : '/community/json/getCommentList/'+postId+'/'+currentPage ,
			type : "GET" ,
			dataType : "json" ,
			headers : {
				"Accept" : "application/json",
				"Content-Type" : "application/json"
			},  
			success : function(JSONData , status) {
				var output = "<table><strong>전체 댓글 "+JSONData.resultPage.totalCount+"</strong>개";
				for(var i in JSONData.list){ 
					output += "<tr>"
					+"<td><br>"+JSONData.list[i].cmtWriterId.userId+"<a onclick='getComment("+JSONData.list[i].cmtId+");'>수정</a><a>삭제</a>"
					+"<br><h5 class='prev' id='"+JSONData.list[i].cmtId+"dd'>"+JSONData.list[i].cmtContent+"</h5>"
					+"<form name='"+JSONData.list[i].cmtId+"qq'><input style='display: none;' type='text' class='dd' id='"+JSONData.list[i].cmtId+"' name='cmtContent' value='"+JSONData.list[i].cmtContent+"'/><span onclick='goComment("+JSONData.list[i].cmtId+");'>취&nbsp;소</span><span onclick='updateComment("+JSONData.list[i].cmtId+");'>등 &nbsp;록</span></form>"
					+"<br>"+JSONData.list[i].cmtDate+"</td>"
					+"<tr>"
				} 
				output += "<table>"
				
				for(var i=JSONData.resultPage.beginUnitPage; i<=JSONData.resultPage.endUnitPage; i++){
					if(JSONData.resultPage.currentPage == i){
						output +="<li class='active'>"
						+"<a onclick='getCommentList("+i+");'>"+i+"<span class='sr-only'>(current)</span></a>"
						+"</li>"
					}
					if(JSONData.resultPage.currentPage != i){
						output +="<li>"
						+"<a onclick='getCommentList("+i+");'>"+i+"</a>"
						+"</li>";
					}
				}
				$("#getCommentList").html(output);
			  }
		   });
		}
		function goComment(cmtId){
			$(".dd").hide();
			$("#"+cmtId+"dd").show();
		}
	
		function getComment(cmtId){ //수정 클릭시 onclick function으로 댓글 수정 화면
			$('.prev').show();
			$(".dd").hide(); //다른 모든 댓글 수정칸 숨김
			$("#"+cmtId+"").show(); //누른 댓글의 수정칸 출력
			$("#"+cmtId+"dd").hide(); //누른 댓글의 원 내용 숨김
	}
		function updateComment(cmtId){
		$.ajax({
			url : '/community/json/updateComment' ,
			type : "POST" ,
			data : "cmtId="+cmtId+","+$("form[name='"+cmtId+"qq'").serialize() ,
			dataType : "json" ,
			success : function(JSONData , status){
				alert("뿌에에에");
				getCommentList(1);
			}
		}); 
		}
	
	</script>
    
</head>

<body>

	<!--  화면구성 div Start /////////////////////////////////////-->
	<div class="container">
	
		<!-- form Start /////////////////////////////////////-->
		<form class="form-horizontal" id="ajaxgo">
		
		<div class="form-group">
		    <input type="text" id="cmtContent" name="cmtContent">
		    <span id="addComment">등 &nbsp;록</span>
		</div>
		    <input type="hidden" id="postId" name="postId" value="${post.postId}"/>
		</form>
		
		<div id="getCommentList"></div>

	</div>
	
</body>
</html>