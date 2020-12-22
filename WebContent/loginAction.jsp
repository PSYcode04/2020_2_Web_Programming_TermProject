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
	
	if(radioValue.equals("option1")) // seller
	{
		SellerDAO sellerDAO = new SellerDAO();
		int result = sellerDAO.login(userID, userPW);
		if(result == 1) { // login success
			session.setAttribute("userID", userID);
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("location.href = 'sellermain.jsp'");
			script.println("</script>");
		} else if(result == 0) { // password is different
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('Check your password!!')");
			script.println("history.back()");
			script.println("</script>");
		} else if(result == -1) { // no sellerID info
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('This ID does not exist!! Please Sign Up!')");
			script.println("history.back()");
			script.println("</script>");
		} else if(result == -2) { // database error
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('Database error!!')");
			script.println("history.back()");
			script.println("</script>");
		}
	}
	else if(radioValue.equals("option2")) // buyer
	{
		BuyerDAO buyerDAO = new BuyerDAO();
		int result = buyerDAO.login(userID, userPW);
		if(result == 1) { // login success
			session.setAttribute("userID", userID);
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("location.href = 'buyermain.jsp'");
			script.println("</script>");
		} else if(result == 0) { // password is different
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('Check your password!!')");
			script.println("history.back()");
			script.println("</script>");
		} else if(result == -1) { // no sellerID info
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('This ID does not exist!! Please Sign Up!')");
			script.println("history.back()");
			script.println("</script>");
		} else if(result == -2) { // database error
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('Database error!!')");
			script.println("history.back()");
			script.println("</script>");
		}
	}
	%>
</body>
</html>