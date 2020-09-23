package Galary;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import Board.BoardBean;

public class GalaryDAO {

	//커넥션 연결
	private Connection getConnection() throws Exception {

		Connection con = null;
		Context init = new InitialContext();
		DataSource ds = (DataSource) init.lookup("java:/comp/env/jdbc/jspbeginner");
		con = ds.getConnection();
		return con;
	}

	//galaryUpload.jsp에서 게시글 업로드하기 버튼을 클릭했을때 DB와 연동하여 insert작업 수행
	public void insertGalary(GalaryBean gBean){
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql ="";
		try {
			// DB의 num을 1씩 증가해주면서 고유한 속성으로 만들어주기
			int number=0;
			
			con = getConnection();
			sql="select max(num) from animalProjectGalary";
			pstmt=con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if(rs.next()){
				number=rs.getInt(1)+1;
			}
			// 갤러리 게시판 글 작성 화면에서 작성한 내용 DB에 삽입
			sql="insert into animalProjectGalary values(?,?,?,?,now(),?)";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, gBean.getName());
			pstmt.setString(2, gBean.getSubject());
			pstmt.setString(3, gBean.getFile());
			pstmt.setString(4, gBean.getContent());
			pstmt.setInt(5, number);
			pstmt.executeUpdate();

			
		} catch (Exception e) {
			System.out.println("insertGalary()내부에서 예외 발생 : "+e);
		}  finally {
			try {
				if(rs != null)rs.close();
				if(pstmt != null)pstmt.close();
				if(con != null)con.close();
				
			} catch (SQLException e) {
				System.out.println("insertGalary메소드 내부의 자원해제 예외 발생 : "+e);
			}
		}
	}//insertGalary() 끝
	
	// 갤러리 게시판에 리스트로 뿌려주는 역할
	public ArrayList<GalaryBean> selectGalary(){
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql ="";
		ArrayList<GalaryBean> list=null;
		try {
			con=getConnection();
			sql="select * from animalProjectGalary order by num desc";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			list = new ArrayList<GalaryBean>();
			while(rs.next()){
				GalaryBean gBean = new GalaryBean();
				gBean.setName(rs.getString(1));
				gBean.setSubject(rs.getString(2));
				gBean.setFile(rs.getString(3));
				gBean.setContent(rs.getString(4));
				gBean.setDate(rs.getString(5));
				gBean.setNum(rs.getInt(6));
				list.add(gBean);
			}
		} catch (Exception e) {
			System.out.println("selectGalary() 내부에서 예외 발생 : "+e);
		}  finally {
			try {
				if(rs != null)rs.close();
				if(pstmt != null)pstmt.close();
				if(con != null)con.close();
				
			} catch (SQLException e) {
				System.out.println("selectGalary메소드 내부의 자원해제 예외 발생 : "+e);
			}
		}
		
		return list;
	}//selectGalary() 끝
	
	
	//게시글을 클릭했을때 하나의 게시글을 자세히 보여준다
	public GalaryBean detailGalary(int num){
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql ="";
		GalaryBean gBean = null;
		try {
			con=getConnection();
			sql="select * from animalProjectGalary where num=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			if(rs.next()){
				gBean = new GalaryBean();
				gBean.setName(rs.getString(1));
				gBean.setSubject(rs.getString(2));
				gBean.setFile(rs.getString(3));
				gBean.setContent(rs.getString(4));
				gBean.setDate(rs.getString(5));
				gBean.setNum(rs.getInt(6));
			}
		} catch (Exception e) {
			System.out.println("detailGalary() 예외 발생 : "+ e);
		}  finally {
			try {
				if(rs != null)rs.close();
				if(pstmt != null)pstmt.close();
				if(con != null)con.close();
				
			} catch (SQLException e) {
				System.out.println("detailGalary메소드 내부의 자원해제 예외 발생 : "+e);
			}
		}
		return gBean;
	
	}//detailGalary() 끝
	
	
	//galaryDetail.jsp에서 글 삭제 버튼을 클릭했을때 deleteGalary.jsp로 글 num을 들고 이동을 한다
	// 그때 삭제 작업을 수행
	public int deleteGalary(int num){
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql ="";
		int result = 0;
		try {
			con=getConnection();
			sql="delete from animalProjectGalary where num=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, num);
			result = pstmt.executeUpdate();
			
		} catch (Exception e) {
			System.out.println("deleteGalary() 내부에서 예외 발생 : "+e);
		}   finally {
			try {
				if(rs != null)rs.close();
				if(pstmt != null)pstmt.close();
				if(con != null)con.close();
				
			} catch (SQLException e) {
				System.out.println("deleteGalary메소드 내부의 자원해제 예외 발생 : "+e);
			}
		}
		return result;
		
	}//deleteGalary() 끝
	
	// galaryDetail.jsp에서 글 수정 버튼을 클릭했을때 updateGalary.jsp로 이동하는데
	// 그 이동한 페이지에서 기존에 존재하던 게시글 내용을 띄워주는 역할을 하는 메소드
	public GalaryBean galaryUpdateSelect(int num){
		
		GalaryBean gBean = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql ="";
		try {
			con = getConnection();
			sql="select * from animalProjectGalary where num=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			if(rs.next()){
				gBean = new GalaryBean();
				gBean.setName(rs.getString(1));
				gBean.setSubject(rs.getString(2));
				gBean.setFile(rs.getString(3));
				gBean.setContent(rs.getString(4));
				gBean.setDate(rs.getString(5));
				gBean.setNum(rs.getInt(6));
			}
		} catch (Exception e) {
			System.out.println("galaryUpdateSelect() 내부에서 예외 발생 : "+e);
		}   finally {
			try {
				if(rs != null)rs.close();
				if(pstmt != null)pstmt.close();
				if(con != null)con.close();
				
			} catch (SQLException e) {
				System.out.println("galaryUpdateSelect메소드 내부의 자원해제 예외 발생 : "+e);
			}
		
		}
		return gBean;
	}//galaryUpdateSelect() 끝

	//게시글 수정하기 버튼 클릭했을때 DB와 연동하여 UPDATE 작업을 수행할 메소드
	public int updateGalary(GalaryBean gBean,int num){
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql ="";
		int result = 0;
		try {
			con = getConnection();
			sql="update animalProjectGalary set name=?,subject=?,file=?,content=?,date=now(),num=? where num=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, gBean.getName());
			pstmt.setString(2, gBean.getSubject());
			pstmt.setString(3, gBean.getFile());
			pstmt.setString(4, gBean.getContent());
			pstmt.setInt(5, num);
			pstmt.setInt(6, num);
			result = pstmt.executeUpdate();
		} catch (Exception e) {
			System.out.println("updateGalary() 내부에서 예외 발생 : "+e);
		}   finally {
			try {
				if(rs != null)rs.close();
				if(pstmt != null)pstmt.close();
				if(con != null)con.close();
				
			} catch (SQLException e) {
				System.out.println("updateGalary메소드 내부의 자원해제 예외 발생 : "+e);
			}
		
		}
		return result;
	}//updateGalary() 끝
	
	//게시글 수정하기 버튼 클릭했을때 DB와 연동하여 UPDATE 작업을 수행하는데 이미지 변경은 하지 않을경우 실행되는 메소드
	public int updateGalary2(GalaryBean gBean2,int num){
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql ="";
		int result = 0;
		try {
			con = getConnection();
			sql="update animalProjectGalary set name=?,subject=?,content=?,date=now() where num=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, gBean2.getName());
			pstmt.setString(2, gBean2.getSubject());
			pstmt.setString(3, gBean2.getContent());
			pstmt.setInt(4, num);
			result = pstmt.executeUpdate();
		} catch (Exception e) {
			System.out.println("updateGalary2() 내부에서 예외 발생 : "+e);
		}   finally {
			try {
				if(rs != null)rs.close();
				if(pstmt != null)pstmt.close();
				if(con != null)con.close();
				
			} catch (SQLException e) {
				System.out.println("updateGalary2메소드 내부의 자원해제 예외 발생 : "+e);
			}
		
		}
		return result;
	}//updateGalary2() 끝

	/////////////////////////////////페 이 징 작 업//////////////////////////////////////////
	
	
	//페이징작업
		public int getBoardCount(){
			
			int count = 0;	//글개수
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			String sql ="";
			try {
				con = getConnection();
				sql="select count(*) from animalProjectGalary";
				pstmt=con.prepareStatement(sql);
				rs = pstmt.executeQuery();
				if(rs.next()){
					count = rs.getInt(1);
				}
			} catch (Exception e) {
				System.out.println("getBoardCount() 내부에서 예외 발생 : "+e);
			} finally {
				try {
					if(rs != null)rs.close();
					if(pstmt != null)pstmt.close();
					if(con != null)con.close();
					
				} catch (SQLException e) {
					System.out.println("getBoardCount메소드 내부의 자원해제 예외 발생 : "+e);
				}
			}
			return count;
			
		}//getBoardCount() 끝
		
	//글목록 검색해서 가져오는 메소드
	public List<GalaryBean> getBoardList(int startRow,int pageSize){
	
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql ="";
		List<GalaryBean> galaryList = new ArrayList<GalaryBean>();
		
		try {
			//DB연결
			con = getConnection();
			//SQL문 만들기
			sql = "select * from animalProjectGalary order by num desc limit ?,?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, startRow);
			pstmt.setInt(2, pageSize);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()){
				
				//검색한 글목록중.. 한줄단위의 데이터를 저장할 용도로 객체 생성
				GalaryBean gBean = new GalaryBean();
				// rs => BoardBean객체의 각 변수에 저장
				gBean.setName(rs.getString(1));
				gBean.setSubject(rs.getString(2));
				gBean.setFile(rs.getString(3));
				gBean.setContent(rs.getString(4));
				gBean.setDate(rs.getString(5));
				gBean.setNum(rs.getInt(6));
				//BoardBean 객체 => ArrayList배열에 추가
				galaryList.add(gBean);
				
				
			}//while반복문 끝
			
		} catch (Exception e) {
			System.out.println("getBoardList메소드 내부에서 예외 발생 : "+ e);
		} finally {
			try {
				if(rs != null)rs.close();
				if(pstmt != null)pstmt.close();
				if(con != null)con.close();
				
			} catch (SQLException e) {
				System.out.println("getBoardList메소드 내부의 자원해제 예외 발생 : "+e);
			}
		}
		return galaryList;	//검색한 글정보들 (BoardBean객체들)을 저장하고 있는 배열공간인??
	
	}//getBoardList메소드 끝
	
	

}// DAO 끝
