<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="user.SellerDAO" %>
<%@ page import="user.BuyerDAO" %>
<%@ page import="java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="seller" class="user.Seller" scope="page" />
<jsp:useBean id="buyer" class="user.Buyer" scope="page" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="Content-Type" content="text/html">
<link rel="stylesheet" href="css/bootstrap.css">
<title>SKKU Flea Market</title>
</head>

 <script>
    function result(){
    	opener.document.getElementById('submit').disabled = "";
    	window.close();
    }
 
 </script>
<body>
	<%
	String radioValue = request.getParameter("usertype");
	String userID = request.getParameter("id");
	
	if(radioValue.equals("option1")) // seller
	{
		SellerDAO sellerDAO = new SellerDAO();
		
		boolean result = sellerDAO.checkDublicate(userID);
		
		if(result) { %>
			<br /><br />
			<h4>your input ID is duplicate!</h4>
			<input type="button" value="Use other ID" onClick="window.close();">
		<% } else { %>
			<br /><br />
			<h4>you can use this ID!</h4>
			<input type="button" value="Use this ID" onClick="result();">
		<% }
	}
	else if(radioValue.equals("option2")) // buyer
	{
		BuyerDAO buyerDAO = new BuyerDAO();
		
		boolean result = buyerDAO.checkDublicate(userID);
		
		if(result) { %>
			<br /><br />
			<h4>your input ID is duplicate!</h4>
			<input type="button" value="Use other ID" onClick="window.close();">
		<% } else { %>
			<br /><br />
			<h4>you can use this ID!</h4>
			<input type="button" value="Use this ID" onClick="result();">
		<% }
	}
	%>


	
	
</body>
</html>