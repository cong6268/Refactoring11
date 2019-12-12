<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page pageEncoding="EUC-KR"%>

<!--  ///////////////////////// JSTL  ////////////////////////// -->
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
	
	<!-- jQuery UI toolTip ��� CSS-->
	<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
	<!-- jQuery UI toolTip ��� JS-->
	<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>

	<!--  ///////////////////////// CSS ////////////////////////// -->
	<style>
	  body {
            padding-top : 30px;
      }
      .thumbnail-wrappper {
      		width: 25%;
      }
      .thumbnail {
      		position: relative; 
      		padding-top: 100%;
      		overflow: hidden;
      }
      img {
      		position: absolute;
      		top: 0;
      		left: 0;
      		right: 0;
      		bottom: 0;
      		max-width: 100%;
      		height: auto;
      }
    </style>
    
     <!--  ///////////////////////// JavaScript ////////////////////////// -->
	<script type="text/javascript">

		var currentPage = 1;
		
		$(window).scroll(function() {
		    if ($(window).scrollTop() == $(document).height() - $(window).height()) {
		      ++currentPage;
	  
		      $.ajax(
		    		  {
		    			  url : "/product/json/listProduct/"+currentPage ,
		    			  method : "GET" ,
		    			  dataType : "json" ,
		    			  headers : {
		    				  "Accept" : "application/json",
		    				  "Content-Type" : "application/json"
		    			  },                                                              
		    			  success : function(JSONData , status){
		    				  
		    				  //console.log(status);
		    				  //console.log("JSONData : \n"+JSONData.list[0].prodName);
		    				  var displayValue = "<div class='row'>"
			    				  for(var i=0; i<JSONData.list.length; i++) {
			    					  displayValue += "<div class='col-sm-6 col-md-3'>"
		    		    		  	  +"<div class='thumbnail'>"
		    		    		  	  
		    		    	  var files = JSONData.list[i].fileName.split( ',' , 1 );
		    		    		  for(var j=0; j<files.length; j++){    
		    		    			  displayValue += "<img src = '/images/uploadFiles/"+files+"'/>"
		    		    		  }
		    		    		  displayValue += "<h3 align='center'>"+JSONData.list[i].prodName+"</h3>"
		    		              +"<h5 align='center'>��"+JSONData.list[i].price+"</h5>"
		    		              +"<h5 align='center'>"+JSONData.list[i].regDate+"</h5>"
		    		              +"<h5 align='center'>"
		    		                if('${param.menu}'=='manage'){
		    		                	if(JSONData.list[i].stock != 0){
		    		                		displayValue += "�� �Ǹ��� ��"
		    		                	}
		    		                	if(JSONData.list[i].proTranCode == 0){
		    		                		displayValue += "���ſϷ�"
				    		                +"<span>"
				    		                +"<input type='hidden' id='prodNo' name='prodNo' value='"+JSONData.list[i].prodNo+"'/>"
				    		                +"<input type='hidden' id='prodTranCode' name='proTranCode' value='"+JSONData.list[i].proTranCode+"'/>�� ����ϱ� ��</span>"
		    		                	}
		    		                	if(JSONData.list[i].proTranCode == 1){
		    		                		displayValue += "�����"
		    		                	}
		    		                	if(JSONData.list[i].proTranCode == 2){
		    		                		displayValue += "��ۿϷ�"
		    		                	}
		    		                }
		    		                if('${param.menu}'=='search'){
		    		                	if(JSONData.list[i].stock != 0){
		    		                		displayValue += "�� �Ǹ��� ��"	
		    		                	}
		    		                	if(JSONData.list[i].stock == 0){
		    		                		displayValue += "������"
		    		                	}
		    		                }
		    		                displayValue += "</h5>"
		    		                +"<h5 align='center'>"
		    		                if('${param.menu}'=='manage'){
		    		                	displayValue += "<a class='btn btn-primary' role='button'>"
		    		                	+"<input type='hidden' id='prodNo' name='prodNo' value='"+JSONData.list[i].prodNo+"'/>������Ʈ</a>"
		    		                }
		    		                if('${param.menu}'=='search'){
		    		                	if(JSONData.list[i].proTranCode == null){
		    		                		displayValue += "<a class='btn btn-primary' role='button'>"
		    		               			+"<input type='hidden' id='prodNo' name='prodNo' value='"+JSONData.list[i].prodNo+"'/>�����ϱ�</a>"
		    		                	}
		    		                }
		    		                displayValue += "</h5>"
		    		                +"<i class='glyphicon glyphicon-check' id='"+JSONData.list[i].prodNo+"'></i>"
		    		                +"<input type='hidden' value='"+JSONData.list[i].prodNo+"'>_�̸�����"
		    		                +"</div>"
		    		                +"</div>"
			    				  }
			    				 	displayValue += "</div>";  
			    				  
				  				$("#append").append(displayValue); 
		  		  		  }
					  }  
			  )};

		function fncGetUserList(currentPage) {
			$("#currentPage").val(currentPage)
			$("form").attr("method" , "POST").attr("action" , "/product/listProduct?menu=${ param.menu }").submit();
		}
	
		$(function() {
			$( "button.btn.btn-default" ).on("click" , function() {
				fncGetUserList(1);
			});	 
		});
			 
		$(function() {
			$( "a:contains('������Ʈ')" ).on("click" , function() {
					var prodNo = $(this).find($("input[name='prodNo']")).val();
				
				  //alert(  $( this ).text().trim() );
					if('${param.menu}'=='manage'){
						self.location ="/product/updateProduct?prodNo="+prodNo+"&menu=manage";
					}
			});
		});
		
		$(function() {
			$( "a:contains('�����ϱ�')" ).on("click" , function() {
					var prodNo = $(this).find($("input[name='prodNo']")).val();
					
				  //alert(  $( this ).text().trim() );
					if('${param.menu}'=='search'){
						self.location ="/product/getProduct?prodNo="+prodNo+"&menu=search";
					}
			});
		});
		
		$(function() {
			$("span:contains('����ϱ�')").on("click" , function() {
				var prodNo=$(this).find($("input[name='prodNo']")).val();
				var proTranCode=$(this).find($("input[name='proTranCode']")).val();
		
				self.location = "/purchase/updateTranCodeByProd?prodNo="+prodNo+"&tranCode="+proTranCode;		
			});
			
			$("span:contains('����ϱ�')").css("color" , "dodgerblue")
			$("h5:contains('�����')").css("color" , "teal");
			$("h5:contains('��ۿϷ�')").css("color" , "teal");
			$("h5:contains('������')").css("color" , "red");
			$("h5:contains('���ſϷ�')").css("color" , "teal");
			$("h3").css("color" , "cadetblue")
		});	
		
		$(function() {
			$("#searchKeyword").keydown( function(key){
				if (event.keyCode == 13) { 
			  
					fncGetUserList(1);          
				};
			});
		});
			
		$(function() {
			$( "i" ).on("click" , function() {
				var prodNo = $(this).next().val();
			
				$.ajax(
						{
							url : "/product/json/getProduct/"+prodNo ,
							method : "GET" ,
							dataType : "json" ,
							headers : {
								"Accept" : "application/json",
								"Content-Type" : "application/json"
							},
							success : function(JSONData , status) {
								
								//Debug
								//alert(status);
								//alert("JSONData : \n"+JSONData);
								
								var displayValue = "<h6>"
														+"<br>�� ��ǰ��ȣ : "+JSONData.prodNo+"<br/>"
															+"�� ��ǰ�̸� : "+JSONData.prodName+"<br/>"
															+"�� �������� : "+JSONData.manuDate+"<br/>"
															+"�� ��     �� : "+JSONData.price+"<br/>"
															+"�� �������� : "+JSONData.stock+"<br/>"
															+"�� ������� : "+JSONData.regDate+"<br/>"
															+"</h6>";
															
								//alert(displayValue);
								$("h6").remove();
								$( "#"+prodNo+"" ).html(displayValue);
								
							}
							
					});
			  });
		});
	});

</script>
</head>

<body>

	<jsp:include page="/layout/toolbar.jsp" />
	
	<div class="container">
	
		<div class="page-header text-info">
	    	<c:if test="${param.menu=='manage'}">
				<h3>��ǰ����</h3>
			</c:if>
			<c:if test="${param.menu=='search' }">
				<h3>��ǰ�����ȸ</h3>
			</c:if>
	    </div>
	    
	    <!-- table ���� �˻� Start /////////////////////////////////////-->
	    <div class="row">
	    
		    <div class="col-md-6 text-left">
		    	<p class="text-primary">
		    		��ü  ${resultPage.totalCount } �Ǽ�, ���� ${resultPage.currentPage}  ������
		    	</p>
		    </div>
		    
		    <div class="col-md-6 text-right">
			    <form class="form-inline" name="detailForm">
			    
				  <div class="form-group">
				    <select class="form-control" name="searchCondition" >
						<option value="0" ${ !empty search.searchCondition && search.searchCondition==0 ? "selected" : ""}>��ǰ��ȣ</option>
						<option value="1" ${ !empty search.searchCondition && search.searchCondition==1 ? "selected" : ""}>��ǰ��</option>
						<option value="2" ${ !empty search.searchCondition && search.searchCondition==2 ? "selected" : ""}>��ǰ����</option>
					</select>
				  </div>
				  
				  <div class="form-group">
				    <label class="sr-only" for="searchKeyword">�˻���</label>
				    <input type="text" class="form-control" id="searchKeyword" name="searchKeyword"  placeholder="�˻���"
				    			 value="${! empty search.searchKeyword ? search.searchKeyword : '' }"  >
				  </div>
				  
				  <button type="button" class="btn btn-default">�˻�</button>
				  
				  <!-- PageNavigation ���� ������ ���� ������ �κ� -->
				  <input type="hidden" id="currentPage" name="currentPage" value=""/>
				  
				</form>
	    	</div>
	    	
		</div>
		
		<hr>

        <div class="row" id="append">
			
			<c:set var="i" value="0" />
			<c:forEach var="product" items="${list}">
			<c:set var="i" value="${i+1}" />
            <div class="col-sm-6 col-md-3">
             <div class="thumbnail-wrapper">
    		  <div class="thumbnail">
                <c:forEach var="files" items="${fn:split(product.fileName,',')}" varStatus="status">
                  <c:if test="${status.first}">
					<img src = "/images/uploadFiles/${files}"/>
				  </c:if>
				</c:forEach>
                <h3 align="center">${product.prodName}</h3>
                <h5 align="center">��${product.price }</h5>
				<h5 align="center">${product.regDate}</h5>
				<h5 align="center">
				<c:if test="${ param.menu=='manage' }">
				<c:if test="${product.stock != '0'}">
				�� �Ǹ��� ��	
				</c:if>
				<c:if test="${product.stock == '0'}">
				������
				</c:if>
				<c:if test="${product.proTranCode.trim()=='0'}">
				���ſϷ�
					<span>
						<input type="hidden" id="prodNo" name="prodNo" value="${product.prodNo}"/>
						<input type="hidden" id="prodTranCode" name="proTranCode" value="${product.proTranCode}"/>�� ����ϱ� ��</span>
				</c:if>
				<c:if test="${product.proTranCode.trim()=='1'}">
				�����
				</c:if>
				<c:if test="${product.proTranCode.trim()=='2'}">
				��ۿϷ�
				</c:if>
				</c:if>
				<c:if test="${ param.menu=='search' }">
				<c:if test="${product.stock != '0'}">
				�� �Ǹ��� ��	
				</c:if>
				<c:if test="${product.stock == '0'}">
				������
				</c:if>
				</c:if>
				</h5>
				<h5 align="center">
				<c:if test="${ param.menu=='manage' }">
				<a class="btn btn-primary" role="button">
					<input type="hidden" id="prodNo" name="prodNo" value="${product.prodNo}"/>������Ʈ</a>
				</c:if>
				<c:if test="${ param.menu=='search' }">
				<c:if test="${product.stock != '0'}">
				<a class="btn btn-primary" role="button">
					<input type="hidden" id="prodNo" name="prodNo" value="${product.prodNo}"/>�����ϱ�</a>
				</c:if>
				</c:if>
				</h5>
				<i class="glyphicon glyphicon-check" id="${product.prodNo}"></i>
			  	<input type="hidden" value="${product.prodNo}">_�̸�����	
			 </div>
			</div>
           </div> 
		   </c:forEach>

        </div>
        
    </div>

  </body>
	
</html>