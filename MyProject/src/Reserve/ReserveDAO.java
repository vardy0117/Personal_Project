package Reserve;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class ReserveDAO {
	//커넥션 연결
		private Connection getConnection() throws Exception {

			Connection con = null;
			Context init = new InitialContext();
			DataSource ds = (DataSource) init.lookup("java:/comp/env/jdbc/jspbeginner");
			con = ds.getConnection();
			return con;
		}

	//reserveDogGrooming.jsp에서 예약하기 버튼을 클릭했을떄 Pro.jsp로 이동하여 이 메소드를 호출해서 DB에 INSERT작업 수행
	public int insertReserve(ReserveBean rBean){
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql ="";
		int result = 0;
		
		try {
			con = getConnection();
			sql="insert into animalProjectReserve values(null,?,?,?,?,?,0)";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, rBean.getId());
			pstmt.setString(2, rBean.getDate());
			pstmt.setString(3, rBean.getTime());
			pstmt.setString(4, rBean.getDogname());
			pstmt.setString(5, rBean.getOrder());
			result = pstmt.executeUpdate();
		} catch (Exception e) {
			System.out.println("insertReserve() 내부에서 예외 발생 : "+e);
		}  finally {
			try {
				if(rs != null)rs.close();
				if(pstmt != null)pstmt.close();
				if(con != null)con.close();
				
			} catch (SQLException e) {
				System.out.println("insertReserve메소드 내부의 자원해제 예외 발생 : "+e);
			}
		}
	
		return result;
	
	}//insertReserve() 끝
		
	// 페이지 상단에 RESERVE <a>태그를 클릭했을때 myReserve.jsp로 이동된다
	// 그 페이지에서 로그인중인 id값을 활용하여 모든 예약정보를 띄워주는 작업
	public ArrayList<ReserveBean> selectReserve(String id){
		
		ArrayList<ReserveBean> list = null;	//해당하는 id의 모든 예약정보를 가지고 갈 가변길이 배열
		ReserveBean rBean = null;	//id에해당하는 글을 하나씩 담을 객체
		
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql ="";
		try {
			con = getConnection();
			sql="select * from animalProjectReserve where id=? order by reserve asc , date asc";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			list = new ArrayList<ReserveBean>();
			while(rs.next()){
				rBean= new ReserveBean();
				rBean.setNum(rs.getInt(1));
				rBean.setId(rs.getString(2));
				rBean.setDate(rs.getString(3));
				rBean.setTime(rs.getString(4));
				rBean.setDogname(rs.getString(5));
				rBean.setOrder(rs.getString(6));
				rBean.setReserve(rs.getString(7));
				list.add(rBean);
			}
		} catch (Exception e) {
			System.out.println("selectReserve() 내부에서 예외 발생 : "+e);
		}   finally {
			try {
				if(rs != null)rs.close();
				if(pstmt != null)pstmt.close();
				if(con != null)con.close();
				
			} catch (SQLException e) {
				System.out.println("selectReserve메소드 내부의 자원해제 예외 발생 : "+e);
			}
		}
		return list;
	}//selectReserve() 끝
		
	
	public ArrayList<ReserveBean> selectAll(){
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql ="";
		ArrayList<ReserveBean> list = null;	//가변길이 배열
		
		try {
			con = getConnection();
			sql="select * from animalProjectReserve order by reserve asc , date asc";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			list = new ArrayList<ReserveBean>();
			while(rs.next()){
				ReserveBean rBean = new ReserveBean();
				rBean.setNum(rs.getInt(1));
				rBean.setId(rs.getString(2));
				rBean.setDate(rs.getString(3));
				rBean.setTime(rs.getString(4));
				rBean.setDogname(rs.getString(5));
				rBean.setOrder(rs.getString(6));
				rBean.setReserve(rs.getString(7));
				list.add(rBean);
			}
		} catch (Exception e) {
			System.out.println("selectAll()내부에서 예외 발생 : "+e);
		}    finally {
			try {
				if(rs != null)rs.close();
				if(pstmt != null)pstmt.close();
				if(con != null)con.close();
				
			} catch (SQLException e) {
				System.out.println("selectAll메소드 내부의 자원해제 예외 발생 : "+e);
			}
		}
		return list;
	}//selectAll() 끝
		
	// adminReserve.jsp에서 [접수]버튼을 클릭했을때 adminReservePro.jsp로 ajax통신을 이용하여 num을 넘겨줬따
	// 그리고 Pro.jsp에서 DB와 연동하여 해당 예약 정보의 check값을 1로 변경해주는 작업
	public int submit(int num){
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql ="";
		int result = 0;	//상태 체크 변수
		try {
			con = getConnection();
			sql="update animalProjectReserve set reserve=1 where num=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			result = pstmt.executeUpdate();
		} catch (Exception e) {
			System.out.println("submit()내에서 예외 발생 : "+e);
		} finally {
			try {
				if(rs != null)rs.close();
				if(pstmt != null)pstmt.close();
				if(con != null)con.close();
				
			} catch (SQLException e) {
				System.out.println("submit메소드 내부의 자원해제 예외 발생 : "+e);
			}
		}
		
		return result;
	}//submit() 끝
	
	// 예약 취소 버튼을 클릭했을때 해당 글의 num을 가지고 DB에서 delete작업 수행
	public int deleteReserve(int num){
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql ="";
		int result = 0;	//상태 체크 변수
		
		try {
			con = getConnection();
			sql="delete from animalProjectReserve where num=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			result = pstmt.executeUpdate();
		} catch (Exception e) {
			System.out.println("deleteReserve() 내부에서 예외 발생  :"+e);
		}  finally {
			try {
				if(rs != null)rs.close();
				if(pstmt != null)pstmt.close();
				if(con != null)con.close();
				
			} catch (SQLException e) {
				System.out.println("deleteReserve메소드 내부의 자원해제 예외 발생 : "+e);
			}
		}
		
		return result;
	}//deleteReserve() 끝
	
	
}//클래스

