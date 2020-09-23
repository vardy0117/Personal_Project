package Reserve;

public class ReserveBean {
	private int num;
	private String id;
	private String date;
	private String time;
	private String dogname;
	private String order;
	private String reserve;
	
	
	
	
	public ReserveBean() {}
	public ReserveBean(int num, String id, String date, String time, String dogname, String order,String reserve) {
		super();
		this.num = num;
		this.id = id;
		this.date = date;
		this.time = time;
		this.dogname = dogname;
		this.order = order;
		this.reserve = reserve;
	}


	public int getNum() {
		return num;
	}
	public void setNum(int num) {
		this.num = num;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getDate() {
		return date;
	}
	public void setDate(String date) {
		this.date = date;
	}
	public String getTime() {
		return time;
	}
	public void setTime(String time) {
		this.time = time;
	}
	public String getDogname() {
		return dogname;
	}
	public void setDogname(String dogname) {
		this.dogname = dogname;
	}
	public String getOrder() {
		return order;
	}
	public void setOrder(String order) {
		this.order = order;
	}
	
	public String getReserve() {
		return reserve;
	}
	public void setReserve(String reserve) {
		this.reserve = reserve;
	}
	@Override
	public String toString() {
		return "ReserveBean [num=" + num + ", id=" + id + ", date=" + date + ", time=" + time + ", dogname=" + dogname
				+ ", order=" + order + ", reserve=" + reserve + "]";
	}

	
	
}
