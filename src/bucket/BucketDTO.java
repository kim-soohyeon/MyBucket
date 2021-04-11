package bucket;

public class BucketDTO {
	int bucketID;
	String userID;
	String bucketName;
	String bucketType;
	int addYear;
	int addMonth;
	int addDay;
	String bucketContent;
	int likeCount;
	
	public int getBucketID() {
		return bucketID;
	}
	public void setBucketID(int bucketID) {
		this.bucketID = bucketID;
	}
	public String getUserID() {
		return userID;
	}
	public void setUserID(String userID) {
		this.userID = userID;
	}
	public String getBucketName() {
		return bucketName;
	}
	public void setBucketName(String bucketName) {
		this.bucketName = bucketName;
	}
	public String getBucketType() {
		return bucketType;
	}
	public void setBucketType(String bucketType) {
		this.bucketType = bucketType;
	}
	public int getAddYear() {
		return addYear;
	}
	public void setAddYear(int addYear) {
		this.addYear = addYear;
	}
	public int getAddMonth() {
		return addMonth;
	}
	public void setAddMonth(int addMonth) {
		this.addMonth = addMonth;
	}
	public int getAddDay() {
		return addDay;
	}
	public void setAddDay(int addDay) {
		this.addDay = addDay;
	}
	public String getBucketContent() {
		return bucketContent;
	}
	public void setBucketContent(String bucketContent) {
		this.bucketContent = bucketContent;
	}
	public int getLikeCount() {
		return likeCount;
	}
	public void setLikeCount(int likeCount) {
		this.likeCount = likeCount;
	}
	
	public BucketDTO() {
	}
	
	public BucketDTO(int bucketID, String userID, String bucketName, String bucketType, int addYear, int addMonth,
			int addDay, String bucketContent, int likeCount) {
		super();
		this.bucketID = bucketID;
		this.userID = userID;
		this.bucketName = bucketName;
		this.bucketType = bucketType;
		this.addYear = addYear;
		this.addMonth = addMonth;
		this.addDay = addDay;
		this.bucketContent = bucketContent;
		this.likeCount = likeCount;
	}
	
}
