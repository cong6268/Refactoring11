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
	<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
	<link rel="stylesheet" href="/resources/demos/style.css">
	<link href="https://stackpath.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet">
	
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script>
	<!-- <script src="https://code.jquery.com/jquery-1.12.4.js"></script> -->
	<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
	<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
	<script src="https://stackpath.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>


	<link href="http://netdna.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.css" rel="stylesheet">
	<!-- <script src="http://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.js"></script>  -->
	<script src="http://netdna.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.js"></script> 
	
	<!-- include summernote css/js-->
	<link href="http://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.8/summernote.css" rel="stylesheet">
	<script src="http://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.8/summernote.js"></script>
	
	
	<link href="/summernote/summernote.css" rel="stylesheet">
	<script src="/summernote/summernote.min.js"></script>
	<script src="/js/summernote.js"></script>
	<script src="/summernote/lang/summernote-ko-KR.js"></script>
	<link href="https://github.com/summernote/summernote/tree/master/lang/summernote-ko-KR.js">


	<!--  ///////////////////////// CSS ////////////////////////// -->
	<style></style>
    
     <!--  ///////////////////////// JavaScript ////////////////////////// -->
	<script type="text/javascript">

	function fncAddProduct(){
		//Form ��ȿ�� ����
	 	var name = $("input[name='prodName']").val();
		/* var detail = $("input[name='prodDetail']").val(); */
		var manuDate = $("input[name='manuDate']").val();
		var price = $("input[name='price']").val();
		var stock = $("input[name='stock']").val();
	
		if(name == null || name.length<1){
			alert("��ǰ���� �ݵ�� �Է��Ͽ��� �մϴ�.");
			return;
		}
		/* if(detail == null || detail.length<1){
			alert("��ǰ�������� �ݵ�� �Է��Ͽ��� �մϴ�.");
			return;
		} */
		if(manuDate == null || manuDate.length<1){
			alert("�������ڴ� �ݵ�� �Է��ϼž� �մϴ�.");
			return;
		}
		if(price == null || price.length<1){
			alert("������ �ݵ�� �Է��ϼž� �մϴ�.");
			return;
		}
		if(stock == null || stock.length<1){
			alert("������ �ݵ�� �Է��ϼž� �մϴ�.");
			return;
		}
	
		$("form").attr("method" , "POST").attr("enctype" , "multipart/form-data").attr("action" , "/product/addProduct").submit();
		}
	
		$(function() {
			$( "button.btn.btn-primary" ).on("click" , function() {
				
				fncAddProduct();
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
		
		//��ӳ�Ʈ
		$(document).ready(function() {
		     $('#summernote').summernote({
		             height: 300,                 // set editor height
		             minHeight: null,             // set minimum height of editor
		             maxHeight: null,             // set maximum height of editor
		             focus: true,                  // set focus to editable area after initializing summernote
		             lang: 'ko-KR', // default: 'en-US'
		             callbacks: {
		                 onImageUpload: function(files, editor, welEditable) {
		                   for (var i = files.length - 1; i >= 0; i--) {
		                     sendFile(files[i], this);
		                   }
		                 }
		             }
		     });
		});
		
		function sendFile(file, el) {
			
		      var form_data = new FormData();
		      form_data.append('file', file);
		      
		      $.ajax({
		        data: form_data,
		        type: "POST",
		        url: '/product/json/addFile',
		        cache: false,
		        contentType: false,
		        enctype: 'multipart/form-data',
		        processData: false,
		        success: function(img_name) {
		        	
		          $(el).summernote('editor.insertImage', img_name);
		        }
		      });
		}

		$(document).ready(function() {
			$('#summernote').summernote();
			$('.dropdown-toggle').dropdown();
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

	<!--  ȭ�鱸�� div Start /////////////////////////////////////-->
	<div class="container">
	
		<div class="page-header text-center">
	       <h3 class=" text-info">�� ǰ �� ��</h3>
	    </div>
		
		<!-- form Start /////////////////////////////////////-->
		<form class="form-horizontal">
		
		  <div class="form-group">
		    <label for="prodName" class="col-sm-offset-1 col-sm-2 control-label">��ǰ��</label>
		    <div class="col-sm-8">
		      <input type="text" class="form-control" id="prodName" name="prodName" placeholder="��ǰ���� �Է��ϼ���.">
		    </div>
		  </div>
		
		<div class="form-group">
		    <label for="prodDetail" class="col-sm-offset-1 col-sm-2 control-label">��ǰ������</label>
		    <div class="col-sm-8">
		      <textarea class="form-control" id="summernote" name="prodDetail"></textarea>
		    </div>
		  </div>
		
		<div class="form-group">
		    <label for="manuDate" class="col-sm-offset-1 col-sm-2 control-label">��������</label>
		    <div class="col-sm-8">
		      <input type="text" id="datepicker" class="form-control" id="manuDate" name="manuDate" placeholder="�������ڸ� �Է��ϼ���.">
		    </div>
		  </div>
		  
		<div class="form-group">
		    <label for="price" class="col-sm-offset-1 col-sm-2 control-label">����</label>
		    <div class="col-sm-8">
		      <input type="text" class="form-control" id="price" name="price" placeholder="������ �Է��ϼ���.">
		    </div>
		  </div> 
		  
		<div class="form-group">
		    <label for="stock" class="col-sm-offset-1 col-sm-2 control-label">��ϼ���</label>
		    <div class="col-sm-8">
		      <input type="number" min="1" max="999" class="form-control" id="stock" name="stock" placeholder="������ �Է��ϼ���.">
		    </div>
		  </div>   
		  
		<div class="form-group">
		    <label for="fileName" class="col-sm-offset-1 col-sm-2 control-label">��ǰ�̹���</label>
		    <div class="col-sm-8">
		      <input multiple="multiple" type="file" class="form-control" id="fileName" name="fileName">
		    </div>
		  </div>
		
		<div class="form-group">
		    <div class="col-sm-offset-4  col-sm-4 text-center">
		      <button type="button" class="btn btn-primary"  >�� &nbsp;��</button>
			  <a class="btn btn-primary btn" href="#" role="button">��&nbsp;��</a>
		    </div>
		  </div>
		</form>
		
	</div>

	
</body>
</html>