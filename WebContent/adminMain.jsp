<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="user.UserDAO" %>
<%@ page import="user.User" %>
<%@ page import="java.util.ArrayList" %>
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

.btn-lg {
	background-color: #8ccfa0;
	border: none;
}

.btn-lg:hover {
	background-color: #01942d;
}

.member-container {
	margin-top: 30px;
}
</style>

<script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
</head>
<body>
	<%
		String userID = null;
		if(session.getAttribute("userID") != null) {
			userID = (String) session.getAttribute("userID");
		}
		int pageNumber = 1; // default
		if(request.getParameter("pageNumber") != null) {
			pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
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
			<a class="navbar-brand" href="adminMain.jsp">SKKU FLEA MARKET</a>
		</div>
		<!-- 게시판 제목 이름 옆에 나타나는 메뉴 영역 -->
		<div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
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
  		<h1>Member List</h1>
  		<p>You can modify and delete user info.</p>
  		
	</div>
	
	
	<!-- table -->
	<div class="container member-container">
		<table class="table table-striped" style="text-align: center; border: 1px solid #dddddd">
			<thead>
				<tr>
					<th style="background-color: #eeeeee; text-align:center;">ID</th>
					<th style="background-color: #eeeeee; text-align:center;">Password</th>
					<th style="background-color: #eeeeee; text-align:center;">Name</th>
					<th style="background-color: #eeeeee; text-align:center;">Seller / Buyer</th>
					<th style="background-color: #eeeeee; text-align:center;">Delete</th>
				</tr>
			</thead>
			<tbody>
				<%
					UserDAO userDAO = new UserDAO();
					ArrayList<User> list = userDAO.getList(pageNumber);
					for(int i = 0; i <list.size(); i++) {
				%>
				<tr>
					<td><%= list.get(i).getUserID() %></td>
					<td><%= list.get(i).getUserPW() %></td>
					<td><%= list.get(i).getUserName() %></td>
					<td><%= list.get(i).getUserType() %></td>
					<td><button type="button" class="btn btn-xs btn-outline-dark">Delete</button></td>
				</tr>
				<%
					}
				%>
			</tbody>
		</table>
		<%
			if(pageNumber != 1) {
		%>
				<a href="adminMain.jsp?pageNumber=<%=pageNumber - 1%>" class="btn btn-primary pull-left btn-lg" role="button">PREV</a>
		<%
			} if(userDAO.nextPage(pageNumber + 1)) {
		%>
				<a href="adminMain.jsp?pageNumber=<%=pageNumber + 1%>" class="btn btn-primary pull-right btn-lg" role="button">NEXT</a>
		<%	
			}
		%>
		
	</div>
	

	<!-- page footer -->
	<jsp:include page="footer.jsp"></jsp:include>

	
	
	<script src="js/bootstrap.js"></script>
</body>
</html>