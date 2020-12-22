<% 
session.invalidate(); //destroy session
response.sendRedirect("main.jsp");
%>