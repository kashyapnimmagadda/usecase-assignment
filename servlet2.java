

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**Servlet implementation class servlet2*/

@WebServlet("/servlet2")
public class servlet2 extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		PrintWriter out= response.getWriter();
		
		/*Uses the Style attribute to style the HTML elements */
		
		out.println("<html>");
		out.println("<head>");
		out.println("<title>Updated Details</title>");
		out.println("</head>");
		out.println("<body style='background-color:#51d0de;'>");
		out.println("<h1 style='text-align:center;background-color:#393f4d;color: white;'>BANK STATEMENT</h1>");
		/*out.println("<h2 style='color:#0D2447; background-color:#EDF48E; width:400px'> Updated Last Five Transactions:</h2>");*/

       
		out.println("<table style='border:'2''>");
		out.println("<tr style='background-color:gray; color: white;'>");
		out.println("<td>Transaction.no</td>");
		out.println("<td>Transfered Date</td>");
		out.println("<td>Amount Transfered</td>");
		out.println("</tr>");
		try{
			Class.forName("com.mysql.jdbc.Driver");
			Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/usecase1","list","list");
		/*	out.println("<h2 style='color:#0D2447; background-color:#EDF48E; width:400px'> Updated Last Five Transactions:</h2>");*/
			/*request.getparameter is used to store the value in the variable fundTransfered*/
			/*preparedStatement is used to update the values in the "transaction" table in MYSQL database*/
			String fundTransfered =  request.getParameter("send");
			PreparedStatement transactionPs = con.prepareStatement("insert into transactions(transferDate,TRANSACTIONS) values(now(),'"+fundTransfered+"')");  
			transactionPs.executeUpdate();
			/*resultSet is used to retrieve the the "Updated Last 5 Transactions" from the transaction table in database*/
			Statement fundStmt = con.createStatement();
			ResultSet transactionRs = fundStmt.executeQuery("SELECT * FROM (SELECT * FROM transactions ORDER BY ID DESC LIMIT 5 )sub ORDER BY ID ASC ");
			
			while(transactionRs.next())
			{
				out.println("<tr style='background-color:white;'>");
				out.println("<td style='background-color:#BADADA;color:black;'>");
				out.print(transactionRs.getInt(1));
				out.println("</td>");
				out.println("<td style='background-color:#BADADA;color:black;'>");
				out.print(transactionRs.getDate(2));
				out.println("<td style='background-color:#BADADA;color:black;'>");
				out.print(transactionRs.getInt(3));
				out.println("</td>");
				out.println("</tr>");
			}
			/*request.getparameter is used to store the Transfered value in the variable amount */
			/*preparedStatement is used to update the value in the "balance" table in MYSQL database*/
			String amount = request.getParameter("send");
			PreparedStatement balancePs = con.prepareStatement("update balance set finalbalance= (finalbalance-'"+amount+"') where id=1 ");  
			balancePs.executeUpdate();
			/*resultSet is used to retrieve the the "Updated Balance after the Transaction" from the balance table in database*/
			Statement balanceStmt = con.createStatement();
			ResultSet balancers = balanceStmt.executeQuery("SELECT * FROM balance ");
			while(balancers.next())
			{
				out.println("<center>");
				out.println("<h2 style='color:white ;background-color:#bf4aa8 ; width:250px'>Updated Balance:</h2>");
				out.println("<h1 style='color:#1d1145 ;background-color:#ff8928 ;width:250px;color:white;'>");
				out.print(balancers.getInt(2));
				out.println("</h1>");
				out.println("</center>");
			}
		}catch(Exception p){
			System.out.println(p);
			
		}
		
		out.println("</table>");
		out.println("</body>");
		out.println("</html>");
	}

}
