package Galary;

public class GalaryBean {
	private String name;		
	private String subject;		
	private String file;		
	private String content;		
	private String date;
	private int num;
	
	public GalaryBean(){}
	public GalaryBean(String subject, String file, String content) {
		this.subject = subject;
		this.file = file;
		this.content = content;
	}
	public GalaryBean(String name, String subject, String file, String content) {
		this.name = name;
		this.subject = subject;
		this.file = file;
		this.content = content;
	}

	public GalaryBean(String name, String subject, String file, String content,int num) {
		this.name = name;
		this.subject = subject;
		this.file = file;
		this.content = content;
		this.num = num;
	}
	public GalaryBean(String name, String subject, String file, String content, String date,int num) {
		this.name = name;
		this.subject = subject;
		this.file = file;
		this.content = content;
		this.date = date;
		this.num = num;
	}
	
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getSubject() {
		return subject;
	}
	public void setSubject(String subject) {
		this.subject = subject;
	}
	public String getFile() {
		return file;
	}
	public void setFile(String file) {
		this.file = file;
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
	public int getNum() {
		return num;
	}
	public void setNum(int num) {
		this.num = num;
	}
	@Override
	public String toString() {
		String s = this.name+"/"+this.subject+"/"+this.file+"/"+this.content+"/"+this.date+"/"+this.num;
		return s;
	}
	
	
	
	
}
