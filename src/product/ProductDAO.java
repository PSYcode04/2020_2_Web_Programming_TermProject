package product;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
public class ProductDAO {
	
	private Connection conn;
	
	public ProductDAO() {
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
	
	public int upload(Product product) {
		
		String SQL = "INSERT INTO product(productName, productPrice, productImage, productImageRealName, sellerID, sellerName, tradingPlace, productStatus) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
		
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			
			pstmt.setString(1, product.getProductName());
			pstmt.setString(2, product.getProductPrice());
			pstmt.setString(3, product.getProductImage());
			pstmt.setString(4, product.getProductImageRealName());
			pstmt.setString(5, product.getSellerID());
			pstmt.setString(6, product.getSellerName());
			pstmt.setString(7, product.getTradingPlace());
			pstmt.setString(8, product.getProductStatus());
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return -1;
	}
}
