package likey;

public class LikeyDTO {

	String userID;
	int bucketID;
	String userIP;
	public String getUserID() {
		return userID;
	}
	public void setUserID(String userID) {
		this.userID = userID;
	}
	public int getBucketID() {
		return bucketID;
	}
	public void setBucketID(int bucketID) {
		this.bucketID = bucketID;
	}
	public String getUserIP() {
		return userIP;
	}
	public void setUserIP(String userIP) {
		this.userIP = userIP;
	}
	
	public LikeyDTO() {
		
	}
	public LikeyDTO(String userID, int bucketID, String userIP) {
		super();
		this.userID = userID;
		this.bucketID = bucketID;
		this.userIP = userIP;
	}
	
	
}
