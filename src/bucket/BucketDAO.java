package bucket;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import util.DatabaseUtil;

public class BucketDAO {

	public int write(BucketDTO bucketDTO) {
		String SQL="INSERT INTO BUCKET VALUES (NULL, ?, ?, ?, ?, ?, ?, ?, 0)";
		Connection conn=null;
		PreparedStatement pstmt =null;
		ResultSet rs=null;
		try {	
			conn=DatabaseUtil.getConnection();
			pstmt =conn.prepareStatement(SQL);
			pstmt.setString(1, bucketDTO.getUserID());
			pstmt.setString(2, bucketDTO.getBucketName());
			pstmt.setString(3, bucketDTO.getBucketType());
			pstmt.setInt(4, bucketDTO.getAddYear());
			pstmt.setInt(5, bucketDTO.getAddMonth());
			pstmt.setInt(6, bucketDTO.getAddDay());
			pstmt.setString(7, bucketDTO.getBucketContent());
			return pstmt.executeUpdate();
		}catch(Exception e){
			e.printStackTrace();
		}finally {
			try{if(conn!=null)conn.close();} catch(Exception e){ e.printStackTrace();}
			try{if(pstmt!=null)pstmt.close();} catch(Exception e){ e.printStackTrace();}
			try{if(rs!=null)rs.close();} catch(Exception e){ e.printStackTrace();}
		}
		return -1;//디비오류발생
	}
	
	public ArrayList<BucketDTO> getList(String bucketType, String searchType, String search, int pageNumber){
		if(bucketType.equals("전체")) {
			bucketType="";
		}
		ArrayList<BucketDTO> bucketList=null;
		String SQL="";
		Connection conn=null;
		PreparedStatement pstmt =null;
		ResultSet rs=null;
		try {	
			if(searchType.equals("최신순")) {
				SQL="SELECT * FROM BUCKET WHERE bucketType LIKE ? AND CONCAT(bucketName, bucketType, bucketContent) LIKE " +
						"? ORDER BY bucketID DESC LIMIT " + pageNumber * 5 + ", " + pageNumber * 5 + 6;
			}else if(searchType.equals("추천순")) {
				SQL="SELECT * FROM BUCKET WHERE bucketType LIKE ? AND CONCAT(bucketName, bucketType, bucketContent) LIKE " +
						"? ORDER BY likeCount DESC LIMIT " + pageNumber * 5 + ", " + pageNumber * 5 + 6;
			}
			conn=DatabaseUtil.getConnection();
			pstmt =conn.prepareStatement(SQL);
			pstmt.setString(1, "%" + bucketType + "%");
			pstmt.setString(2, "%" + search + "%");
			rs=pstmt.executeQuery();
			bucketList=new ArrayList<BucketDTO>();
			while(rs.next()) {
				BucketDTO bucket =new BucketDTO(
					rs.getInt(1),
					rs.getString(2),
					rs.getString(3),
					rs.getString(4),
					rs.getInt(5),
					rs.getInt(6),
					rs.getInt(7),
					rs.getString(8),
					rs.getInt(9)
				);
				bucketList.add(bucket);
			}
		}catch(Exception e){
			e.printStackTrace();
		}finally {
			try{if(conn!=null)conn.close();} catch(Exception e){ e.printStackTrace();}
			try{if(pstmt!=null)pstmt.close();} catch(Exception e){ e.printStackTrace();}
			try{if(rs!=null)rs.close();} catch(Exception e){ e.printStackTrace();}
		}
		return bucketList;
	}

	public int like(String bucketID) {
		String SQL="UPDATE BUCKET SET likeCount = likeCount=likeCount+1 bucketID = ?";
		Connection conn=null;
		PreparedStatement pstmt =null;
		ResultSet rs=null;
		try {	
			conn=DatabaseUtil.getConnection();
			pstmt =conn.prepareStatement(SQL);
			pstmt.setInt(1, Integer.parseInt(bucketID));
			return pstmt.executeUpdate();
		}catch(Exception e){
			e.printStackTrace();
		}finally {
			try{if(conn!=null)conn.close();} catch(Exception e){ e.printStackTrace();}
			try{if(pstmt!=null)pstmt.close();} catch(Exception e){ e.printStackTrace();}
			try{if(rs!=null)rs.close();} catch(Exception e){ e.printStackTrace();}
		}
		return -1;//디비오류
	}
	
	public int delete(String bucketID) {
		String SQL="DELETE FROM BUCKET WHERE bucketID = ?";
		Connection conn=null;
		PreparedStatement pstmt =null;
		ResultSet rs=null;
		try {	
			conn=DatabaseUtil.getConnection();
			pstmt =conn.prepareStatement(SQL);
			pstmt.setInt(1, Integer.parseInt(bucketID));
			return pstmt.executeUpdate();
		}catch(Exception e){
			e.printStackTrace();
		}finally {
			try{if(conn!=null)conn.close();} catch(Exception e){ e.printStackTrace();}
			try{if(pstmt!=null)pstmt.close();} catch(Exception e){ e.printStackTrace();}
			try{if(rs!=null)rs.close();} catch(Exception e){ e.printStackTrace();}
		}
		return -1;//디비오류
	}
	
	public String getUserID(String bucketID) {
		String SQL="SELECT userID FROM BUCKET WHERE bucketID = ?";
		Connection conn=null;
		PreparedStatement pstmt =null;
		ResultSet rs=null;
		try {	
			conn=DatabaseUtil.getConnection();
			pstmt =conn.prepareStatement(SQL);
			pstmt.setInt(1, Integer.parseInt(bucketID));
			rs =pstmt.executeQuery();
			if(rs.next()) {
				return rs.getString(1);
			}
		}catch(Exception e){
			e.printStackTrace();
		}finally {
			try{if(conn!=null)conn.close();} catch(Exception e){ e.printStackTrace();}
			try{if(pstmt!=null)pstmt.close();} catch(Exception e){ e.printStackTrace();}
			try{if(rs!=null)rs.close();} catch(Exception e){ e.printStackTrace();}
		}
		return null;//존재하지 않는 글
	}
}
