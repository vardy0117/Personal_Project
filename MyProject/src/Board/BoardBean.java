package Board;

public class BoardBean {
	private int number;
	private String name;
	private String pass;
	private String subject;
	private String content;
	private String date;
	
	public BoardBean(){}
	public BoardBean(String name,String subject,String content){
		this.name = name;
		this.subject = subject;
		this.content = content;
	}
	public BoardBean(String name, String pass, String subject, String content){
		this.name=name;
		this.pass=pass;
		this.subject=subject;
		this.content=content;
	}
	
	public BoardBean(int number,String name, String pass, String subject, String content,String date){
		this.number = number;
		this.name=name;
		this.pass=pass;
		this.subject=subject;
		this.content=content;
		this.date = date;
	}
	public BoardBean(int number,String name, String pass, String subject, String content){
		this.number = number;
		this.name=name;
		this.pass=pass;
		this.subject=subject;
		this.content=content;
	}
	
	
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getPass() {
		return pass;
	}
	public int getNumber() {
		return number;
	}
	public void setNumber(int number) {
		this.number = number;
	}
	public void setPass(String pass) {
		this.pass = pass;
	}
	public String getSubject() {
		return subject;
	}
	public void setSubject(String subject) {
		this.subject = subject;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getDate() {
		return date;
	}
	public void setDate(String date) {
		this.date = date;
	}
	
	
	
}
