package user;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class SellerDAO {
	
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	
	public SellerDAO() {
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
	
	public int login(String sellerID, String sellerPW) {
		String SQL = "SELECT sellerPW FROM seller WHERE sellerID = ?";
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, sellerID);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				if(rs.getString(1).equals(sellerPW)) {
					return 1; // success login
				}
				else
					return 0; // password error
			}
			return -1; // no sellerID info
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -2; // database error
	}
	
	public boolean checkDublicate(String sellerID) {
		String SQL = "SELECT sellerID FROM seller WHERE sellerID = ?";
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, sellerID);
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
	
	public int join(Seller seller) {
		String SQL = "INSERT INTO seller(sellerID, sellerPW, sellerName) VALUES (?, ?, ?)";
		try {
			pstmt = conn.prepareStatement(SQL);
			
			pstmt.setString(1, seller.getSellerID());
			pstmt.setString(2, seller.getSellerPW());
			pstmt.setString(3, seller.getSellerName());
			
			pstmt.executeUpdate();
			
			if(userUpdate(seller))
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
	
	private boolean userUpdate(Seller seller) {
		String SQL2 = "INSERT INTO user(userID, userPW, userName, userType) VALUES (?, ?, ?, ?)";
		try {
			pstmt = conn.prepareStatement(SQL2);
			
			pstmt.setString(1, seller.getSellerID());
			pstmt.setString(2, seller.getSellerPW());
			pstmt.setString(3, seller.getSellerName());
			pstmt.setString(4, "seller");
			
			return true;
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return false;
	}
}
