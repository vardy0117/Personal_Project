package Member;

public class MemberBean {
	private String id;
	private String pw;
	private String name;			
	private String email;			
	private String phone;			
	private String address_code;
	private String roadAddress;
	private String detailAddress;
	
	public MemberBean(){}
	public MemberBean(String id,String pw,String name,String email,String phone,String address_code,String roadAddress,String detailAddress){
		this.id=id;
		this.pw=pw;
		this.name=name;
		this.email=email;
		this.phone=phone;
		this.address_code=address_code;
		this.roadAddress=roadAddress;
		this.detailAddress=detailAddress;
	}
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getPw() {
		return pw;
	}
	public void setPw(String pw) {
		this.pw = pw;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public String getAddress_code() {
		return address_code;
	}
	public void setAddress_code(String address_code) {
		this.address_code = address_code;
	}
	public String getRoadAddress() {
		return roadAddress;
	}
	public void setRoadAddress(String roadAddress) {
		this.roadAddress = roadAddress;
	}
	public String getDetailAddress() {
		return detailAddress;
	}
	public void setDetailAddress(String detailAddress) {
		this.detailAddress = detailAddress;
	}

	@Override
	public String toString() {
		return id + "|" + pw + "|"+ name + "|"+ phone + "|"+ email + "|"+ address_code + "|"+ roadAddress + "|"+ detailAddress + "|";
	}
	
	
	
}
