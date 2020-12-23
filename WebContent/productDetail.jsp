<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="product.ProductDAO" %>
<%@ page import="product.Product" %>
<%@ page import="java.net.URLEncoder" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="Content-Type" content="text/html">
<meta name="viewport" content="width=device-width">
<link rel="stylesheet" href="css/bootstrap.css">
<title>SKKU Flea Market</title>

<style type="text/css">
.navbar {
 margin: 0;
}

.navbar-header .navbar-brand{
	color: #01942d;
}

.navbar-header .navbar-brand:hover{
	color: #01942d;
}

.jumbotron {
	margin: 0;
	text-align: center;
	color: #01942d;
}

.jumbotron h1 {
	font-size: 3em;
}

.btn-primary {
	background-color: #8ccfa0;
	border: none;
}

.btn-primary:hover {
	background-color: #01942d;
}

.product-container {
	margin-top: 30px;
}

</style>

<script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
</head>
<body>
	<%
		request.setCharacterEncoding("UTF-8");
		String userID = null;
		if(session.getAttribute("userID") != null) {
			userID = (String) session.getAttribute("userID");
		}
		int productID = 0;
		if(request.getParameter("productID") != null) {
			productID = Integer.parseInt(request.getParameter("productID"));
			session.setAttribute("productID", productID);
		}
		
	%>

	<nav class="navbar navbar-default"> <!-- 네비게이션 -->
		<div class="navbar-header"> 	<!-- 네비게이션 상단 부분 -->
			<!-- 네비게이션 상단 박스 영역 -->
			<button type="button" class="navbar-toggle collapsed"
				data-toggle="collapse" data-target="#bs-example-navbar-collapse-1"
				aria-expanded="false">
				<!-- 이 삼줄 버튼은 화면이 좁아지면 우측에 나타난다 -->
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>
			</button>
			<!-- 상단 바에 제목이 나타나고 클릭하면 main 페이지로 이동한다 -->
			<a class="navbar-brand" href="buyermain.jsp">SKKU FLEA MARKET</a>
		</div>
		<!-- 게시판 제목 이름 옆에 나타나는 메뉴 영역 -->
		<div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
			<ul class="nav navbar-nav">
				<li><a href="productList.jsp">Search Products</a></li>
				<li><a href="buyList.jsp">Buy List</a></li>
			</ul>
			<!-- 헤더 우측에 나타나는 드랍다운 영역 -->
			<ul class="nav navbar-nav navbar-right">
				<li class="dropdown">
					<a href="#" class="dropdown-toggle"
						data-toggle="dropdown" role="button" aria-haspopup="true"
						aria-expanded="false">Logout<span class="caret"></span></a>
					<!-- 드랍다운 아이템 영역 -->	
					<ul class="dropdown-menu">
						<li><a href="logout.jsp">Logout</a></li>
					</ul>
				</li>
			</ul>
		</div>
	</nav>
	<!-- information of page -->
	<div class="jumbotron">
  		<h1>Product Detail</h1>
  		<p>You can show the product info.</p>
  		
	</div>

	
	<!-- table -->
	<div class="container product-container">
		<form method="post" action="buyAction.jsp" name="buyform">
				<table class="table table-striped" style="text-align: center; border: 1px solid #dddddd;" >
					<%
					ProductDAO productDAO = new ProductDAO();
					Product product = productDAO.getProductDetail(productID);
					if(product != null) {
					%>
					<tr>
						<td>Product Image</td>
						<td><img src="upload\<%=product.getProductImage() %>" height="200"></td>
					</tr>
					<tr>
						<td>Product Name</td>
						<td><%=product.getProductName() %></td>
					</tr>
					<tr>
						<td>Product Price</td>
						<td><%=product.getProductPrice() %></td>
					</tr>
					<tr>
						<td>Seller Name</td>
						<td><%=product.getSellerName() %></td>
					</tr>
					<tr>
						<td>Trading Place</td>
						<td><%=product.getTradingPlace() %></td>
					</tr>
					<tr>
						<td>Product buyer</td>
						<td><%=product.getProductBuyer() %></td>
					</tr>
					</tbody>
					<%
					}
					%>
				</table>
				<%
					if(product.getProductStatus().equals("selling")) {
				%>
						<button type="submit" class="btn btn-primary pull-right" name="buy" value="<%=productID%>">Buy This!</button>
				<%
					}
				
				%>
				
			</form>
	</div>
	

	<!-- page footer -->
	<jsp:include page="footer.jsp"></jsp:include>

	
	
	<script src="js/bootstrap.js"></script>
</body>
</html>