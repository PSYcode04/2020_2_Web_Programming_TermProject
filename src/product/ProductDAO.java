package product;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class ProductDAO {
	
	private Connection conn;
	private ResultSet rs;
	
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
	
	/*구매*/
	public int buyProduct(int productID, String buyerID) {
		String SQL = "UPDATE product SET productStatus = ? , productBuyer = ? WHERE productID = ? ";
		
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, "sold out");
			pstmt.setString(2, buyerID);
			pstmt.setInt(3, productID);
			
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return -1; // database error
	}
	

	public ArrayList<Product> getList(String sellerID) {
		String SQL = "SELECT * FROM product WHERE sellerID = ?";
		ArrayList<Product> list = new ArrayList<Product>();
		
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, sellerID);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				Product product = new Product();
				
				product.setProductName(rs.getString(2));
				product.setProductPrice(rs.getString(3));
				product.setTradingPlace(rs.getString(8));
				product.setProductStatus(rs.getString(9));
				product.setProductBuyer(rs.getString(10));
				list.add(product);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	public ArrayList<Product> getProductList(String productName) {
		String SQL = "SELECT * FROM product WHERE productName = ?";
		ArrayList<Product> list = null; // 검색 결과 없으면 null
		
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, productName);
			rs = pstmt.executeQuery();
			list = new ArrayList<Product>();
			
			while(rs.next()) {
				Product product = new Product();
				
				product.setProductID(Integer.parseInt(rs.getString(1)));
				product.setProductName(rs.getString(2));
				product.setProductPrice(rs.getString(3));
				product.setTradingPlace(rs.getString(8));
				product.setProductStatus(rs.getString(9));
				product.setSellerName(rs.getString(7));
				list.add(product);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	public ArrayList<Product> getBuyList(String buyerID) {
		String SQL = "SELECT * FROM product WHERE productBuyer = ?";
		ArrayList<Product> list = null; // 검색 결과 없으면 null
		
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, buyerID);
			rs = pstmt.executeQuery();
			list = new ArrayList<Product>();
			
			while(rs.next()) {
				Product product = new Product();
				
				product.setProductName(rs.getString(2));
				product.setProductPrice(rs.getString(3));
				product.setSellerName(rs.getString(7));
				list.add(product);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	/*view product detail*/
	public Product getProductDetail(int productID) {
		String SQL = "SELECT * FROM product WHERE productID = ?";
		Product product = null;
		
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, productID);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				product = new Product();
				
				// product.setProductID(Integer.parseInt(rs.getString(1)));
				product.setProductName(rs.getString(2));
				product.setProductPrice(rs.getString(3));
				product.setProductImage(rs.getString(4));
				product.setProductImageRealName(rs.getString(5));
				product.setSellerName(rs.getString(7));
				product.setTradingPlace(rs.getString(8));
				product.setProductStatus(rs.getString(9));
				product.setProductBuyer(rs.getString(10));
				return product;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return product;
	}

}
