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
<title>SKKU Flea Market</title>
</head>
<body>
	<%
	String userIDCheck = null;
	if(session.getAttribute("userID") != null) {
		userIDCheck = (String) session.getAttribute("userID");
	}
	
	String radioValue = request.getParameter("optionsRadios");
	String userID = request.getParameter("userID");
	String userPW = request.getParameter("userPassword");
	String userName = request.getParameter("userName");
	
	if(radioValue.equals("option1")) // seller
	{
		seller.setSellerID(userID);
		seller.setSellerPW(userPW);
		seller.setSellerName(userName);
		
		SellerDAO sellerDAO = new SellerDAO();
		
		int result = sellerDAO.join(seller);
		
		if(result == -1) { // database error
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('Database error!!')");
			script.println("history.back()");
			script.println("</script>");
		}
		else{
			session.setAttribute("userID", seller.getSellerID());
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("location.href = 'sellermain.jsp'");
			script.println("</script>");
		}
	}
	else if(radioValue.equals("option2")) // buyer
	{
		buyer.setBuyerID(userID);
		buyer.setBuyerPW(userPW);
		buyer.setBuyerName(userName);
		
		BuyerDAO buyerDAO = new BuyerDAO();
		
		int result = buyerDAO.join(buyer);
		
		if(result == -1) { // database error
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('Database error!!')");
			script.println("history.back()");
			script.println("</script>");
		}
		else {
			session.setAttribute("userID", buyer.getBuyerID());
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("location.href = 'buyermain.jsp'");
			script.println("</script>");
		}

	}
	


	%>
</body>
</html>