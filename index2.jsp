<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.*"%>
<%
String id=request.getParameter("userid");
String driver = "com.mysql.jdbc.Driver";
String connectionUrl = "jdbc:mysql://localhost:3306/";
String database = "usecase1";
String userid = "list";
String password = "list";
try{
	Class.forName(driver);
}catch(ClassNotFoundException e){
	e.printStackTrace();
}
Connection connection = null;
Statement statement = null;
ResultSet resultset = null;
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
 <head>
  <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
  <%-- To style the index page --%>
  <style>
  #bodystyle{
            background-color:#a0d2eb;
            }
  #h1Style{
            text-align:center;
			background-color:#393f4d;
			color: white;
			}
  #tableStyle{
  			background-color:gray;
            color: white;
            }
  #trstyle{
            background-color:white;
            }
  .tdstyle{
             background-color:#BADADA;
             color:black;
            }
  </style>
  <title>DEMO BANK</title>
 </head>

 <body id="bodystyle">
  <h1 id="h1Style"> BANK TRANSACTIONS</h1>
  <h3 Style="color:#0D2447; background-color:#EDF48E; width:250px"><i>LAST 5 TRANSACTIONS:</i></h3>
 
  <%-- Creating the table to print the last five transactions --%>
 <table border="3">
   <tr id="tableStyle">
     <td>Transaction.no</td>
     <td>Transfered Date</td>
     <td>Amount Transfered</td>
   </tr>
 
   <%-- Using try and catch block to Get connected to the MYSQL DATABASE and Retrieve the LAST FIVE TRANSACTIONS from the table named as transactions --%>
<%
try
{
	connection = DriverManager.getConnection(connectionUrl+database,userid,password);
    
	statement =connection.createStatement();
	resultset =statement.executeQuery("SELECT * FROM (SELECT * FROM transactions ORDER BY ID DESC LIMIT 5)sub ORDER BY ID ASC ");
  while(resultset.next())
	{
		%>
		<tr id="trstyle">
		<td class="tdstyle"><%=resultset.getInt(1)%></td>
		<td class="tdstyle"><%=resultset.getDate(2)%></td>
		<td class="tdstyle"><%=resultset.getInt(3)%></td>
		</tr>
		<%
	}
	connection.close();
	} catch (Exception e){
	e.printStackTrace();
	}
%>
</table>
<%-- Using another try and catch block to connect to the MYSQL DATABASE and retrieve the balance amount stored in database table named as balance --%>
<center>
<%
try
{
	connection = DriverManager.getConnection(connectionUrl+database,userid,password);
	statement =connection.createStatement();
	resultset =statement.executeQuery("SELECT * FROM balance ");
  while(resultset.next())
	{
		%>
		<tr>
		<td>
		<h3 style="color:white ;background-color:#7A9D96 ; width:200px">Account Balance:</h3>
		<strong style="color:#1d1145 ;background-color:white ;width:2000px"><%=resultset.getInt(2)%></strong>
		</td>
		</tr>
		<%
		}
	connection.close();
	} catch (Exception e){
	e.printStackTrace();
	}
%>
</center>
<br>
<br>
<%-- Using the HTML form tag to get the amount to be transfered from the balance --%>
<form action="servlet2" method="get">
<label for="send"><i>Amount To Be Transfered </i></label>
<input type="number" id="send" name="send" min="1"><br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<input type="submit" value="send">
</form>
</body>
</html>