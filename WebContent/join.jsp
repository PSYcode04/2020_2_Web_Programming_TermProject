<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="Content-Type" content="text/html">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="css/bootstrap.css">
<title>SKKU Flea Market</title>

<style type="text/css">
.navbar-header .navbar-brand{
	color: #01942d;
}

.navbar-header .navbar-brand:hover{
	color: #01942d;
}

.navbar .dropdown-toggle {
	color: #01942d;
}
</style>

</head>

<script>
		
	function validate()
	{
		var userID = document.myform.userID;
		var userPW = document.myform.userPassword;
		var userName = document.myform.userName;
			
		if (userID.value == null || userID.value == "") //check ID textbox not blank
		{
			window.alert("please enter ID ?"); //alert message
			userID.style.background = '#f08080';
			userID.focus();
			return false;
		}
		if (userPW.value == null || userPW.value == "") //check Password textbox not blank
		{
			window.alert("please enter Password ?"); //alert message
			userPW.style.background = '#f08080'; 
			userPW.focus();
			return false;
		}
		if (userName.value == null || userName.value == "") //check Name textbox not blank
		{
			window.alert("please enter Name ?"); //alert message
			userName.style.background = '#f08080'; 
			userName.focus();
			return false;
		}
	}
	
	function checkID()
	{
		var userID = document.myform.userID;
		var userType = document.myform.optionsRadios;
		
		if(document.myform.userID.value == "") {
			alter("please enter ID ?");
			userID.style.background = '#f08080';
			userID.focus();
			return;
		}
		
		url = "checkDuplicate.jsp?id=" + userID.value + "&&usertype=" + userType.value;
		openWin = window.open(url, "checkID", "toolbar=no, location=no, status=no, menubar=no, scrollbars=no, resizable=no, width=300, height=200");
	}
			
</script>

<body>
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
			<a class="navbar-brand" href="main.jsp">SKKU FLEA MARKET</a>
		</div>
		<!-- 게시판 제목 이름 옆에 나타나는 메뉴 영역 -->
		<div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
			<!-- 헤더 우측에 나타나는 드랍다운 영역 -->
			<ul class="nav navbar-nav navbar-right">
				<li class="dropdown">
					<a href="#" class="dropdown-toggle"
						data-toggle="dropdown" role="button" aria-haspopup="true"
						aria-expanded="false">Login / Join<span class="caret"></span></a>
					<!-- 드랍다운 아이템 영역 -->	
					<ul class="dropdown-menu">
						<li><a href="login.jsp">Login</a></li>
						<li class="active"><a href="join.jsp">Join</a></li>
					</ul>
				</li>
			</ul>
		</div>
	</nav>
	
	<!-- join -->
	<div class="container mt-3" style="max-width: 560px;">
      <form method="post" action="joinAction.jsp" name="myform" onsubmit="return validate();">
        <div class="form-group form-group-1">
          <label>ID</label>
          <input type="text" name="userID" autocomplete="off" class="form-control">
          <button type="button" class="btn btn-primary" onClick="checkID(this.form)">Duplicate</button>
        </div>
        <div class="form-group">
          <label>PW</label>
          <input type="password" name="userPassword" autocomplete="off" class="form-control">
        </div>
        <div class="form-group">
          <label>NAME</label>
          <input type="text" name="userName" autocomplete="off" class="form-control">
        </div>
        <div class="radio-class">
        
		<div class="radio">
          <label>
    		<input type="radio" name="optionsRadios" id="optionsRadios1" value="option1" checked>
    			Seller
  			</label>
		</div>
		<div class="radio">
  			<label>
  				<input type="radio" name="optionsRadios" id="optionsRadios2" value="option2">
    			Buyer
  			</label>
		</div>
		
		</div>
        <button type="submit" class="btn btn-primary" id="submit" disabled="disabled">Join</button>
      </form>
    </div>
	
	<!-- page footer -->
	<jsp:include page="footer.jsp"></jsp:include>

	
	<script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
</body>
</html>