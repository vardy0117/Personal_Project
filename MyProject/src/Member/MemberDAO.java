package Member;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class MemberDAO {
	
	
	//커넥션 연결
	private Connection getConnection() throws Exception {

		Connection con = null;
		Context init = new InitialContext();
		DataSource ds = (DataSource) init.lookup("java:/comp/env/jdbc/jspbeginner");
		con = ds.getConnection();
		return con;
	}
	
	//////////////////////////////////////////////////////////////////////
	
	// 로그인 기능을 할 메소드
	public int loginDAO(String id,String pw){
		
		int result = 0;	// ID와 PW 맞을시 0을반환
						// ID는 맞고 PW 틀릴시 1을 반환
						// 둘다 틀릴시 2를 반환
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql ="";
		
		
		try {
			con = getConnection();
			sql="select * from animalProject where id=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, id);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()){
				if(pw.equals(rs.getString("pw"))){
					result = 0;	//ID PW 둘다 맞는 경우
				
				
				}else{	//ID는 맞고 pw 틀릴 경우
					result = 1;
				}
			}else{	//ID 틀릴경우
				result = 2;
			}
		} catch (Exception e) {
			System.out.println("loginDAO 메소드 내부에서 예외 발생 : "+e);
		} finally {
			
				try {
					if(rs != null)rs.close();
					if(pstmt != null)pstmt.close();
					if(con != null)con.close();
					
				} catch (SQLException e) {
					System.out.println("loginDAO메소드 내부의 자원해제 예외 발생 : "+e);
				}
		}
		
		return result;
	}//loginDAO 메소드 끝
	
	//////////////////////////////////////////////////////////////////////////////
	
	// join.jsp에서 회원가입 버튼을 클릭했을 시 회원가입 기능을 처리할 insertDAO 메소드
	public int insertDAO(MemberBean mb){
		
		int result = 1;	// 회원가입이 성공적으로 완료되었을 경우 1을 반환해줄 변수
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql ="";
		
		try {
			con = getConnection();
			sql = "insert into animalProject values(?,?,?,?,?,?,?,?)";
			pstmt=con.prepareStatement(sql);
			
			pstmt.setString(1, mb.getId());
			pstmt.setString(2, mb.getPw());
			pstmt.setString(3, mb.getName());
			pstmt.setString(4, mb.getEmail());
			pstmt.setString(5, mb.getPhone());
			pstmt.setString(6, mb.getAddress_code());
			pstmt.setString(7, mb.getRoadAddress());
			pstmt.setString(8, mb.getDetailAddress());
			
			pstmt.executeUpdate();
			
			result = 1;
			
		} catch (Exception e) {
			System.out.println("insertDAO 메소드 내부에서 예외 발생 : "+e);
			result = 0;	//회원가입 실패
		} finally {
			
			try {
				if(rs != null)rs.close();
				if(pstmt != null)pstmt.close();
				if(con != null)con.close();
				
			} catch (SQLException e) {
				System.out.println("insertDAO메소드 내부의 자원해제 예외 발생 : "+e);
			}
		}
	
		return result;
	
	}

	///////////////////////////////////////////////////////////////////////////////
	//ID 중복검사를 위한 메소드
	public int checkId(String id){
		int result = 0;	// 중복된 아이디가 있으면 1, 없으면 0
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql ="";
		
		try {
			con=getConnection();
			sql="select * from animalProject where id=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			
			if(rs.next()){	// 입력한 ID가 중복된 아이디라면?
				result = 1;
			}else{
				result = 0;
			}
			
		} catch (Exception e) {
			System.out.println("checkID 메소드 내부에서 예외 발생: "+ e);
		} finally {
			
				try {
					if(rs != null)rs.close();
					if(pstmt != null)pstmt.close();
					if(con != null)con.close();
				} catch (SQLException e) {
					System.out.println("checkID의 자원해제 내부에서 예외 발생 : "+ e);
				}
			
		}
	
		return result;
	
	}
	
	
	/////////////////////////////////////////////////////////////////////////////////
	
	//modifiedMember.jsp에서 회원정보 수정을 할때 <input>태그에 기존에 회원정보들을 띄워주기위해 DB와 연동하여 작업
	
	public MemberBean selectOldMember(String oldId){
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql ="";
		
		MemberBean mb = new MemberBean();
		
		try {
			con=getConnection();
			sql="select * from animalProject where id=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, oldId);
			rs = pstmt.executeQuery();
			
			
			if(rs.next()){
				mb.setId(rs.getString(1));
				mb.setPw(rs.getString(2));
				mb.setName(rs.getString(3));
				mb.setEmail(rs.getString(4));
				mb.setPhone(rs.getString(5));
				mb.setAddress_code(rs.getString(6));
				mb.setRoadAddress(rs.getString(7));
				mb.setDetailAddress(rs.getString(8));
			}
			
		} catch (Exception e) {
			System.out.println("selectOldMember()내부에서 예외 발생 : "+ e);
		} finally {
			
			try {
				if(rs != null)rs.close();
				if(pstmt != null)pstmt.close();
				if(con != null)con.close();
			} catch (SQLException e) {
				System.out.println("selectOldMember의 자원해제 내부에서 예외 발생 : "+ e);
			}
		
		}
		return mb;
	
	
	
	}//selectOldMember()끝
	
	
	
	
	
	
	
	
	//modified.jsp에서 회원정보 수정을 눌렀을때 modifiedPro.jsp로 입력한 정보가 넘어간다
	//modifiedPro.jsp와 연동해서 DB의 정보를 새로 입력받은 정보로 수정하는 메소드
	public int updateMember(String oldId,MemberBean mBean){
		
		int result = 0;	//수정이 완료되면 0을반환 실패하면 1을반환
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql ="";
		
		try {
			con=getConnection();
			/*sql="update animalProject set id=?,pw=?,name=?,email=?,phone=?,"
					+ "address_code=?,roadAddress=?,detailAddress=? "
					+ "where id=?";*/
			
			sql="update animalProject set id=?,pw=?,name=?,email=?,phone=?,address_code=?,roadAddress=?,detailAddress=? where id=?";
			
			pstmt=con.prepareStatement(sql);
			
			pstmt.setString(1, mBean.getId());
			pstmt.setString(2, mBean.getPw());
			pstmt.setString(3, mBean.getName());
			pstmt.setString(4, mBean.getEmail());
			pstmt.setString(5, mBean.getPhone());
			pstmt.setString(6, mBean.getAddress_code());
			pstmt.setString(7, mBean.getRoadAddress());
			pstmt.setString(8, mBean.getDetailAddress());
			pstmt.setString(9, oldId);
			
			
			pstmt.executeUpdate();
			result = 0;
		
		} catch (Exception e) {
			System.out.println("updateMember메소드 내에서 예외 발생 : "+e);
			result = 1;
			
		}  finally {
			
			try {
				if(rs != null)rs.close();
				if(pstmt != null)pstmt.close();
				if(con != null)con.close();
			} catch (SQLException e) {
				System.out.println("updateMember의 자원해제 내부에서 예외 발생 : "+ e);
			}
		
		}
		return result;
	
	}//updateMember() 끝
	
	
	//deleteMemberPro.jsp에서 입력받은 비밀번호 값과 session에 저장되어있는 ID의 비밀번호와 일치하는지 확인
	// 확인후 delete작업도 바로 수행
	public int selectPwd(String id,String pwd){
		
		int result = 0;	//해당하는 정보가 있으면 0을반환 아니면 1반환
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql ="";
		try {
			con=getConnection();
			sql="select * from animalProject where id=?and pw=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setString(2, pwd);
			rs = pstmt.executeQuery();
			if(rs.next()){
				result=0;
				sql="delete from animalProject where id=?and pw=?";
				pstmt=con.prepareStatement(sql);
				pstmt.setString(1, id);
				pstmt.setString(2, pwd);
				pstmt.executeUpdate();
			}else{
				result=1;
			}
		} catch (Exception e) {
			System.out.println("selectPwd() 내부에서 예외 발생 : "+e);
			result = 1;
		} finally {
			
			try {
				if(rs != null)rs.close();
				if(pstmt != null)pstmt.close();
				if(con != null)con.close();
			} catch (SQLException e) {
				System.out.println("selectPwd의 자원해제 내부에서 예외 발생 : "+ e);
			}
		
		}
		
		return result;
		
	}//selectPwd()끝
	
	
	
	
	//lookUpMember.jsp에서 admin 관리자 계정으로 회원정보 조회를 클릭했을때 allMemberSelect.jsp로 이동하여
	// MemberDAO와 연동해서 DB에 select 작업을 수행해서 ajax로 뿌려준다
	public ArrayList<MemberBean> selectMember(){
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql ="";
		
		ArrayList<MemberBean> list = new ArrayList<MemberBean>();	// 모든회원정보들을 담을 변수
		
		try {
			con=getConnection();
			sql= "select * from animalProject where id not in ('admin')";
			pstmt=con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while(rs.next()){
				MemberBean mBean = new MemberBean();
				mBean.setId(rs.getString(1));
				mBean.setPw(rs.getString(2));
				mBean.setName(rs.getString(3));
				mBean.setEmail(rs.getString(4));
				mBean.setPhone(rs.getString(5));
				mBean.setAddress_code(rs.getString(6));
				mBean.setRoadAddress(rs.getString(7));
				mBean.setDetailAddress(rs.getString(8));
				list.add(mBean);
			}
		} catch (Exception e) {
			System.out.println("selectMember() 내에서 예외 발생"+e);
		} finally {
			
			try {
				if(rs != null)rs.close();
				if(pstmt != null)pstmt.close();
				if(con != null)con.close();
			} catch (SQLException e) {
				System.out.println("selectMember()의 자원해제 내부에서 예외 발생 : "+ e);
			}
		
		}
		return list;
	}//selectMember끝


	//dropMember.jsp (윈도우팝업)창에서 id를 입력하고 회원 탈퇴 버튼을 클릭했을때
	//dropMemberPro.jsp로 이동하여 DB와 연동해서 delete작업을 수행한다.
	public int dropMember(String id){
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql ="";
		int result = 1;	//상태변수 정상작동 0, 오류 1
		try {
			con = getConnection();
			sql="select * from animalProject where id=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			if(rs.next()){
				sql="delete from animalProject where id=?";
				pstmt=con.prepareStatement(sql);
				pstmt.setString(1, id);
				pstmt.executeUpdate();
				result = 0;
			}else{
				result = 1;
			}
			
		} catch (Exception e) {
			System.out.println("dropMember() 내부에서 예외 발생 : "+e);
		}  finally {
			
			try {
				if(rs != null)rs.close();
				if(pstmt != null)pstmt.close();
				if(con != null)con.close();
			} catch (SQLException e) {
				System.out.println("dropMember()의 자원해제 내부에서 예외 발생 : "+ e);
			}
		
		}
		
		return result;
	} //dropMember() 끝
	
	
}// 클래스
