package user;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class AdminDAO {

	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	
	public AdminDAO() {
		try {
			String dbURL = "jdbc:mysql://localhost:3306/auctiondb?serverTimezone=UTC";
			String dbID= "root";
			String dbPassword = "Scott#@^3";
			
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection(dbURL, dbID, dbPassword);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public int login(String adminID, String adminPW) {
		String SQL = "SELECT password FROM administrator WHERE ID = ?";
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, adminID);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				if(rs.getString(1).equals(adminPW)) {
					return 1; // success login
				}
				else
					return 0; // password error
			}
			return -1; // wrong administrator info
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -2; // database error
	}
}
