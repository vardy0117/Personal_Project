package GalaryComment;

public class GalaryCommentBean {
	private int number;	
	private String id;
	private String comment;
	private String date;
	private int primaryNum;
	
	public GalaryCommentBean() {
	}
	public GalaryCommentBean(int number, String id, String comment, String date, int primaryNum) {
		this.number = number;
		this.id = id;
		this.comment = comment;
		this.date = date;
		this.primaryNum = primaryNum;
	}
	
	public int getNumber() {
		return number;
	}
	public void setNumber(int number) {
		this.number = number;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getComment() {
		return comment;
	}
	public void setComment(String comment) {
		this.comment = comment;
	}
	public String getDate() {
		return date;
	}
	public void setDate(String date) {
		this.date = date;
	}
	public int getPrimaryNum() {
		return primaryNum;
	}
	public void setPrimaryNum(int primaryNum) {
		this.primaryNum = primaryNum;
	}
	
	
}
