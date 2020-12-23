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
	
	public String sellerName(String sellerID) {
		String SQL = "SELECT sellerName FROM seller WHERE sellerID = ?";
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, sellerID);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				return rs.getString(1);
				}
				else
					return null; // password error
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null; // database error
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
	
	//auto_increment init
	public int getNext() {
		//현재 게시글을 내림차순으로 조회하여 가장 마지막 글의 번호를 구한다
		String SQL = "SELECT userNum FROM user ORDER BY userNum DESC";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				return rs.getInt(1) + 1;
			}
			return 1; // if the first user
		}catch (Exception e) {
			e.printStackTrace();
		}
		return -1; //database error
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
		String SQL2 = "INSERT INTO user(userNum, userID, userPW, userName, userType) VALUES (?, ?, ?, ?, ?)";
		int autoInt = getNext();
		
		try {
			pstmt = conn.prepareStatement(SQL2);
			
			pstmt.setInt(1, autoInt);
			pstmt.setString(2, seller.getSellerID());
			pstmt.setString(3, seller.getSellerPW());
			pstmt.setString(4, seller.getSellerName());
			pstmt.setString(5, "seller");
			
			return true;
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return false;
	}
}
