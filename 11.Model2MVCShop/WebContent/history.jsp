<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%@ page contentType="text/html; charset=EUC-KR" %>

<html>
<head>

	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" >
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" >
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script>
	
	<!-- Bootstrap Dropdown Hover CSS -->
	<link href="/css/animate.min.css" rel="stylesheet">
	<link href="/css/bootstrap-dropdownhover.min.css" rel="stylesheet">
	<!-- Bootstrap Dropdown Hover JS -->
	<script src="/javascript/bootstrap-dropdownhover.min.js"></script>
	
	<!-- jQuery UI toolTip 사용 CSS-->
	<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
	<!-- jQuery UI toolTip 사용 JS-->
	<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>

</head>
<body>

	<jsp:include page="/layout/toolbar.jsp" />
	
	<div class="container">
	
		<div class="page-header text-info">
			<h3>열어본 상품 보기</h3>
	    </div>
<br>
<br>
<%
	request.setCharacterEncoding("euc-kr");
    response.setCharacterEncoding("euc-kr");
    String history = null;
   
    Cookie[] cookies = request.getCookies();
    if (cookies!=null && cookies.length > 0) {
       for (int i = 0; i < cookies.length; i++) {
          Cookie cookie = cookies[i];
             if(!cookie.getName().equals("JSESSIONID")){ 
           	 history += ","+cookie.getValue();
             }
       }
      
       if (history != null) {
         String[] h = history.split(",");
         for (int i = 0; i < h.length; i++) {
           if (!h[i].equals("null")) {
%>
	<a href="/product/getProduct?prodNo=<%=h[i]%>&menu=search"   target="rightFrame"><%=h[i]%></a>
	<br>
<%
           }
         }
      }
   }
%>
	</div>
	
</body>
</html>