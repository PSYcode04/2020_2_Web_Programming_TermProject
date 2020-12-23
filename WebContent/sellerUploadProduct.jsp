<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="Content-Type" content="text/html">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="css/bootstrap.css">
<title>SKKU Flea Market</title>

<style type="text/css">
.navbar {
 margin: 0;
}

.jumbotron {
	margin: 0;
	text-align: center;
	color: #01942d;
}

.jumbotron h1 {
	font-size: 3em;
}

.upload-container {
	width: 100%;
	text-align: center;
}

.upload {
	margin-top: 80px;
	display: inline-block;
	width: 500px;
}

.btn-primary {
	background-color: #8ccfa0;
	border: none;
}

.btn-primary:hover {
	background-color: #01942d;
}

</style>
<script>
		
	function validate()
	{
		var productName = document.registerForm.productName;
		var productPrice = document.registerForm.productPrice;
		var tradingPlace = document.registerForm.tradingPlace;
			
		if (productName.value == null || productName.value == "") //check ID textbox not blank
		{
			window.alert("please enter productName ?"); //alert message
			userID.style.background = '#f08080';
			userID.focus();
			return false;
		}
		if (productPrice.value == null || productPrice.value == "") //check Password textbox not blank
		{
			window.alert("please enter productPrice ?"); //alert message
			userPW.style.background = '#f08080'; 
			userPW.focus();
			return false;
		}
		if (tradingPlace.value == null || tradingPlace.value == "") //check Name textbox not blank
		{
			window.alert("please enter tradingPlace ?"); //alert message
			userName.style.background = '#f08080'; 
			userName.focus();
			return false;
		}
	}
	
</script>


</head>
<body>
	<%
		String userID = null;
		if(session.getAttribute("userID") != null) {
			userID = (String) session.getAttribute("userID");
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
			<a class="navbar-brand" href="sellermain.jsp">SKKU FLEA MARKET</a>
		</div>
		<!-- 게시판 제목 이름 옆에 나타나는 메뉴 영역 -->
		<div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
			<ul class="nav navbar-nav">
				<li><a href="uploadProduct.jsp">Upload Product</a></li>
				<li><a href="productStatus.jsp">Product Status</a></li>
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
  		<h1>Upload Product</h1>
  		<p>You can upload product's info.</p>
  		
	</div>
	
	<div class="upload-container">
		<div class="upload">
			<form action="uploadProductAction.jsp" method="post" name="registerForm" enctype="multipart/form-data" onSubmit="return validate();">
			<div class="form-group">
				<table class="table table-striped" style="text-align: center; border: 1px solid #dddddd;" >
					<tr>
						<td>Product Name</td>
						<td align="left"><input type="text" name="productName" autocomplete="off"></td>
					</tr>
					<tr>
						<td>Product Price</td>
						<td align="left"><input type="text" name="productPrice" autocomplete="off"></td>
					</tr>
					<tr>
						<td>Seller ID</td>
						<td align="left"><input type="text" name="sellerID" disabled="disabled" value="<%=userID%>"></td>
					</tr>
					<tr>
						<td>Product Image</td>
						<td align="left"><input type="file" name="productImg" autocomplete="off"></td>
					</tr>
					<tr>
						<td>Trading Place</td>
						<td align="left"><input type="text" name="tradingPlace" autocomplete="off"></td>
					</tr>
					</tbody>
				</table>
			</div>

				<button type="submit" class="btn btn-primary pull-right" id="submit">Registration</button>
			</form>
		</div>
	</div>
	
	
	
	<!-- page footer -->
	<jsp:include page="footer.jsp"></jsp:include>

	
	<script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
</body>
</html>