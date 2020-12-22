package user;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class BuyerDAO {

	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	
	public BuyerDAO() {
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
	
	public int login(String buyerID, String buyerPW) {
		String SQL = "SELECT buyerPW FROM buyer WHERE buyerID = ?";
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, buyerID);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				if(rs.getString(1).equals(buyerPW)) {
					return 1; // success login
				}
				else
					return 0; // password error
			}
			return -1; // no buyerID info
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -2; // database error
	}
	
	public boolean checkDublicate(String buyerID) {
		String SQL = "SELECT sellerID FROM buyer WHERE sellerID = ?";
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, buyerID);
			rs = pstmt.executeQuery();
			
			if(rs.next()) { // duplicate
				return true;
			} else { // not duplicate
				return false;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return false; // database error
	}
	
	public int join(Buyer buyer) {
		String SQL = "INSERT INTO buyer(buyerID, buyerPW, buyerName) VALUES (?, ?, ?)";
		
		
		try {
			pstmt = conn.prepareStatement(SQL);
			
			pstmt.setString(1, buyer.getBuyerID());
			pstmt.setString(2, buyer.getBuyerPW());
			pstmt.setString(3, buyer.getBuyerName());
			pstmt.executeUpdate();
			
			if(userUpdate(buyer))
			{
				return pstmt.executeUpdate();
			} else {
				return -1;
			}
			
		
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		
		return -1; // database error
	}
	
	private boolean userUpdate(Buyer buyer) {
		String SQL2 = "INSERT INTO user(userID, userPW, userName, userType) VALUES (?, ?, ?, ?)";
		try {
			pstmt = conn.prepareStatement(SQL2);
			
			pstmt.setString(1, buyer.getBuyerID());
			pstmt.setString(2, buyer.getBuyerPW());
			pstmt.setString(3, buyer.getBuyerName());
			pstmt.setString(4, "buyer");
			
			return true;
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return false;
	}
	
}
