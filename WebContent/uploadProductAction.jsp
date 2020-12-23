<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="user.SellerDAO" %>
<%@ page import="product.ProductDAO" %>
<%@ page import="product.Product" %>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="java.io.File" %>

<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%@ page import="com.oreilly.servlet.MultipartRequest" %>


<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="seller" class="user.Seller" scope="page" />

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="Content-Type" content="text/html">
<title>SKKU Flea Market</title>
</head>
<body>
	<%
		String userID = null;
		if(session.getAttribute("userID") != null) {
			userID = (String) session.getAttribute("userID");
		}
		
		// image file upload
		String directory = application.getRealPath("/upload/");
		int maxSize = 1024*1024*100;
		String encoding = "UTF-8";
		
		MultipartRequest multipartRequest = new MultipartRequest(request, directory, maxSize, encoding, new DefaultFileRenamePolicy());
		
		SellerDAO sellerDAO = new SellerDAO();
		String productName = multipartRequest.getParameter("productName");
		String productPrice = multipartRequest.getParameter("productPrice");
		String sellerID = userID;
		String tradingPlace = multipartRequest.getParameter("tradingPlace");
		String sellerName = sellerDAO.sellerName(sellerID);
		String productImage = multipartRequest.getOriginalFileName("productImg");
		String productImageReal = multipartRequest.getFilesystemName("productImg");
		
	
		Product product = new Product();
		
		
		product.setProductName(productName);
		product.setProductPrice(productPrice);
		product.setSellerID(sellerID);
		product.setSellerName(sellerName);
		product.setTradingPlace(tradingPlace);
		product.setProductStatus("selling"); // default = "selling"
		product.setProductBuyer(null); // default = "null"
		product.setProductImage(productImage);
		product.setProductImageRealName(productImageReal);


		if(new ProductDAO().upload(product) != -1) // success upload
		{
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('Upload Product Complete!!')");
			script.println("location.href = 'sellermain.jsp'");
			script.println("</script>");
		} else {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('Fail to upload!!')");
			script.println("history.back()");
			script.println("</script>");
		}
		
		
	%>
</body>
</html>