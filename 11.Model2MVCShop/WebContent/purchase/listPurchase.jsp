<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page pageEncoding="EUC-KR"%>

<!--  ///////////////////////// JSTL  ////////////////////////// -->
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
   
   
   <!-- jQuery UI toolTip ��� CSS-->
  <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
  <!-- jQuery UI toolTip ��� JS-->
  <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
	
	<!--  ///////////////////////// CSS ////////////////////////// -->
	<style>
	  body {
            padding-top : 30px;
      }
    </style>
    
     <!--  ///////////////////////// JavaScript ////////////////////////// -->
	<script type="text/javascript">
		
		function fncGetUserList(currentPage) {
	
			$("#currentPage").val(currentPage)
			$("form").attr("method" , "POST").attr("action" , "/purchase/listPurchase").submit();
		}
		
		$( function() {
			
			$( "i" ).on("click" , function() {
				var tranNo = $(this).next().val();
				
			 /* self.location = "/purchase/getPurchase?tranNo="+tranNo; */
			 
			 	$.ajax(
			 			{
			 				url : "/purchase/json/getPurchase/"+tranNo , 
			 				method : "GET" , 
			 				dataType : "json" , 
			 				headers : {
			 					"Accept" : "application/json",
			 					"Content-Type" : "application/json"
			 				},
			 				success : function(JSONData , status) {
			 					//Debug
			 					//alert(status)
			 					//alert("JSONData : \n"+JSONData);
			 					
			 					var displayValue = "<h6>"
			 												+"�� ��ǰ��ȣ : "+JSONData.tranNo+"<br/>"
			 												+"�� �����ھ��̵� : "+JSONData.buyer.userId+"<br/>"
			 												+"�� �������̸� : "+JSONData.receiverName+"<br/>"
			 												+"�� ���ſ�û���� : "+JSONData.divyRequest+"<br/>"
			 												+"�� �������� : "+JSONData.divyDate+"<br/>"
			 												+"�� �ֹ��� : "+JSONData.orderDate+"<br/>"
			 												+"</h6>";
			 					//alert(displayValue);
			 					$("h6").remove();
			 					$( "#"+tranNo+"" ).html(displayValue);
			 				}
			 		});
			});
			
			$( "td:nth-child(1)" ).on("click" , function() {
				self.location = "/purchase/getPurchase?tranNo="+$(this).text().trim();
			});
	
			$( "td:nth-child(2)" ).on("click" , function() {
				self.location ="/user/getUser?userId="+$(this).text().trim();
			});
	
			$( "td:contains('�� ���ǵ��� ��')" ).on("click" , function() {
				var tranNo=$(this).find($("input[name='tranNo']")).val();
				var tranCode=$(this).find($("input[name='tranCode']")).val();
				self.location = "/purchase/updateTranCode?tranNo="+tranNo+"&tranCode="+tranCode;
			});
			
			$( "td:contains('�� ���ǵ��� ��')" ).css("color" , "dodgerblue");
		});

	</script>
	
</head>

<body>
	
	<!-- ToolBar Start /////////////////////////////////////-->
	<jsp:include page="/layout/toolbar.jsp" />
   	<!-- ToolBar End /////////////////////////////////////-->
	
	<!--  ȭ�鱸�� div Start /////////////////////////////////////-->
	<div class="container">
		<div class="page-header text-info">
	       <h3>���Ÿ����ȸ</h3>
	    </div>
	    
	    <!-- table ���� �˻� Start /////////////////////////////////////-->
	    <div class="row">
		    <div class="col-md-6 text-left">
		    	<p class="text-primary">
		    		��ü  ${resultPage.totalCount } �Ǽ�, ���� ${resultPage.currentPage}  ������
		    	</p>
		    </div>
		</div>
			
      <!--  table Start /////////////////////////////////////-->
      <table class="table table-hover table-striped" >
      
        <thead>
          <tr>
            <th align="center">��ǰ��ȣ</th>
            <th align="left" >ȸ�� ID</th>
            <th align="left">ȸ����</th>
            <th align="left">��ȭ��ȣ</th>
            <th align="left">�����Ȳ</th>
            <th align="left">��������</th>
            <th align="left">��������</th>
          </tr>
        </thead>
       
		<tbody>
		
		  <c:set var="i" value="0" />
		  <c:forEach var="purchase" items="${list}">
			<c:set var="i" value="${ i+1 }" />
			<tr>
			  <td align="left">${purchase.tranNo}</td>
			  <td align="left">${purchase.buyer.userId}</td>
			  <td align="left">${purchase.receiverName}</td>
			  <td align="left">${purchase.receiverPhone}</td>
			  <td align="left">
			  <c:if test="${purchase.tranCode.trim()=='0'}">
				���� ���ſϷ� �����Դϴ�.
			  </c:if>
			  <c:if test="${purchase.tranCode.trim()=='1'}">
				���� ����� �����Դϴ�.
			  </c:if>
			  <c:if test="${purchase.tranCode.trim()=='2'}">
				���� ��ۿϷ� �����Դϴ�.
			  </c:if>
			  </td>
			  <td align="left">
			  <c:if test="${purchase.tranCode.trim()=='1'}">
				<input type="hidden" id="tranNo" name="tranNo" value="${purchase.tranNo}"/>
				<input type="hidden" id="tranCode" name="tranCode" value="${purchase.tranCode}"/>
				 �� ���ǵ��� ��
			  </c:if>
			  </td>
			  <td align="left">
			  	<i class="glyphicon glyphicon-ok" id= "${purchase.tranNo}"></i>
			  	<input type="hidden" value="${purchase.tranNo}">
			  </td>
			</tr>
          </c:forEach>
        
        </tbody>
      
      </table>
	  <!--  table End /////////////////////////////////////-->
	  
 	</div>
 	<!--  ȭ�鱸�� div End /////////////////////////////////////-->
 	
 	
 	<!-- PageNavigation Start... -->
	<jsp:include page="../common/pageNavigator_new.jsp"/>
	<!-- PageNavigation End... -->
	
</body>

</html>