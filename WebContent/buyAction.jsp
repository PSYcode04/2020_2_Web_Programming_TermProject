<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="product.ProductDAO" %>
<%@ page import="product.Product" %>
<%@ page import="java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="Content-Type" content="text/html">
<title>SKKU Flea Market</title>
</head>
<body>
	<%
	String buyerID=null;
	int productID = 0;
	
	if(session.getAttribute("userID") != null) {
		buyerID = (String) session.getAttribute("userID");
	}
	productID = Integer.parseInt(request.getParameter("buy"));
	
	if(new ProductDAO().buyProduct(productID, buyerID) != -1) // success buy
	{
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('Buy Complete!! Check your buy list')");
		script.println("location.href = 'buyermain.jsp'");
		script.println("</script>");
	} else {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('Fail to buy!!')");
		script.println("location.href = 'buyermain.jsp'");
		script.println("</script>");
	}


	%>
</body>
</html>