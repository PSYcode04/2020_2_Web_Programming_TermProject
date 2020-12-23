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
		//���� �Խñ��� ������������ ��ȸ�Ͽ� ���� ������ ���� ��ȣ�� ���Ѵ�
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
//				rs = pstmt.executeQuery(); // delete ����
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
			
			
			// TO DO: 11�� 2�� ���� ����~
			// incresment_auto 
			// userNum���� ��ü ȸ�� ���� ����ؾߵǴµ� incresment_auto�� �����Ҷ��� +1�ǹǷ� �������� ����!! �̰� Ȯ���غ���.
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	// user�� 10�� �̻��� ��� ���� ������, ���ٸ� ��ư ���� (pagination)
	// Ư�� �������� �����ϴ��� Ȯ��
	public boolean nextPage(int pageNumber) {
		String SQL = "SELECT * FROM user WHERE userNum < ? ORDER BY userNum DESC LIMIT 10";
		
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext() - (pageNumber - 1) * 10);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				return true;
			}
			
			
			// TO DO: 11�� 2�� ���� ����~
			// incresment_auto 
			// userNum���� ��ü ȸ�� ���� ����ؾߵǴµ� incresment_auto�� �����Ҷ��� +1�ǹǷ� �������� ����!! �̰� Ȯ���غ���.
		} catch (Exception e) {
			e.printStackTrace();
		}
		return false;
	}
}
