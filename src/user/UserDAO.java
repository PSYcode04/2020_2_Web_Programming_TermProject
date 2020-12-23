package user;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class UserDAO {
	
	private Connection conn;
//	private PreparedStatement pstmt;
	private ResultSet rs;
	
	public UserDAO() {
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
	
//	public int delete(String userID) {
//		int lastNum;
//		String userNum = "SELECT userNum FROM user WHERE userID = ?";
//		String delete = "DELETE FROM user WHERE userNum = ?";
//		
//		try {
//			pstmt = conn.prepareStatement(userNum);
//			pstmt.setString(1, userID);
//			
//			rs = pstmt.executeQuery();
//			
//			if(rs.next()) {
//				lastNum = rs.getInt(1); // find ID
//				System.out.println(lastNum); // test
//				
//				pstmt = conn.prepareStatement(delete);
//				pstmt.setInt(1, lastNum);
//				
//				rs = pstmt.executeQuery(); // delete 수행
//				if(updateIncrement(lastNum+1)) {
//					return 1;
//				}
//				
//			} else { 
//				return 0; // there is no same ID
//			}
//			return -1; // wrong info
//		} catch (Exception e) {
//			e.printStackTrace();
//		}
//		return -1;
//	}
//	
//	private boolean updateIncrement(int newNum) {
//		String update = "ALTER TABLE user auto_increment = ?";
//		
//		try {
//			pstmt = conn.prepareStatement(update);
//			pstmt.setInt(1, newNum);
//			
//			rs = pstmt.executeQuery();
//			return true;
//			
//		} catch (Exception e) {
//			e.printStackTrace();
//		}
//		return false;
//	}
	
	
	
	public ArrayList<User> getList(int pageNumber) {
		String SQL = "SELECT * FROM user WHERE userNum < ? ORDER BY userNum DESC LIMIT 10";
		ArrayList<User> list = new ArrayList<User>();
		
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext() - (pageNumber - 1) * 10);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				User user = new User();
				user.setUserID(rs.getString(2));
				user.setUserPW(rs.getString(3));
				user.setUserName(rs.getString(4));
				user.setUserType(rs.getString(5));
				list.add(user);
			}
			
			
			// TO DO: 11강 2분 정도 부터~
			// incresment_auto 
			// userNum으로 전체 회원 수를 계산해야되는데 incresment_auto는 삭제할때도 +1되므로 적절하지 않음!! 이거 확인해보자.
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	// user가 10명 이상인 경우 다음 페이지, 적다면 버튼 없음 (pagination)
	// 특정 페이지가 존재하는지 확인
	public boolean nextPage(int pageNumber) {
		String SQL = "SELECT * FROM user WHERE userNum < ? ORDER BY userNum DESC LIMIT 10";
		
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext() - (pageNumber - 1) * 10);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				return true;
			}
			
			
			// TO DO: 11강 2분 정도 부터~
			// incresment_auto 
			// userNum으로 전체 회원 수를 계산해야되는데 incresment_auto는 삭제할때도 +1되므로 적절하지 않음!! 이거 확인해보자.
		} catch (Exception e) {
			e.printStackTrace();
		}
		return false;
	}
}
