package Board;

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

public class BoardDAO {

	
	
	
	//커넥션 연결
		private Connection getConnection() throws Exception {

			Connection con = null;
			Context init = new InitialContext();
			DataSource ds = (DataSource) init.lookup("java:/comp/env/jdbc/jspbeginner");
			con = ds.getConnection();
			return con;
		}
		
/*-----------------------------------------------------------------------------------------------*/
		
	//board테이블에 insert작업을 할 insertBoard메소드
	// 게시글을 board테이블에 추가
	public int insertBoard(BoardBean bBean){
		int result = 0;	//추가작업이 완료되면 0을 반환할 변수
						//실패하면 1을 반환
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql ="";
		
		try {
			int number=0;
			
			con = getConnection();
			sql="select max(number) from animalProjectBoard";
			pstmt=con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if(rs.next()){
				number=rs.getInt(1)+1;
			}
			sql="insert into animalProjectBoard values(?,?,?,?,?,now())";
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, number);
			pstmt.setString(2, bBean.getName());
			pstmt.setString(3, bBean.getPass());
			pstmt.setString(4, bBean.getSubject());
			pstmt.setString(5, bBean.getContent());
			
			pstmt.executeUpdate();
			result = 0;
		} catch (Exception e) {
			System.out.println("insertBoard 메소드 내부에서 게시글 추가 작업 예외 발생 : "+ e);
			result = 1;
		} finally {
			try {
				if(rs != null)rs.close();
				if(pstmt != null)pstmt.close();
				if(con != null)con.close();
				
			} catch (SQLException e) {
				System.out.println("insertBoard메소드 내부의 자원해제 예외 발생 : "+e);
			}
		}
		
		return result;
	}//insertBoard() 끝

	
	/*-----------------------------------------------------------------------------------------------*/
	
	
	//페이징 작업하면서 ajax방식으로 게시글목록을 보여주는방식에 오류가생겨서 일단 보류
	
	//BoardList 게시판 글 목록에 게시글 목록을 보여줄 메소드
//	public ArrayList<BoardBean> selectAll(){
//		Connection con = null;
//		PreparedStatement pstmt = null;
//		ResultSet rs = null;
//		String sql ="";
//		
//		ArrayList<BoardBean> list = new ArrayList<BoardBean>();
//		
//		try {
//			con=getConnection();
//			sql="select * from animalProjectBoard order by number desc";
//			pstmt=con.prepareStatement(sql);
//			rs = pstmt.executeQuery();
//			while(rs.next()){
//				BoardBean bBean = new BoardBean();
//				bBean.setNumber(rs.getInt(1));
//				bBean.setName(rs.getString(2));
//				bBean.setSubject(rs.getString(4));
//				bBean.setDate(rs.getString(6));
//				
//				list.add(bBean);
//			}
//		} catch (Exception e) {
//			System.out.println("selectAll()메소드 내부에서 예외 발생 : "+e);
//		} finally {
//			try {
//				if(rs != null)rs.close();
//				if(pstmt != null)pstmt.close();
//				if(con != null)con.close();
//				
//			} catch (SQLException e) {
//				System.out.println("selectAll메소드 내부의 자원해제 예외 발생 : "+e);
//			}
//		}
//	
//		return list;
//	
//	}//selectALl()끝
	
	
	/*-----------------------------------------------------------------------------------------------*/
	
	//페이징작업
	public int getBoardCount(){
		
		int count = 0;	//글개수
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql ="";
		try {
			con = getConnection();
			sql="select count(*) from animalProjectBoard";
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
	
	//페이징작업
	public int getBoardCount(String value){
		
		int count = 0;	//글개수
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql ="";
		try {
			con = getConnection();
			sql="select count(*) from animalProjectBoard where subject like ? ";
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, "%"+value+"%");
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
		public List<BoardBean> getBoardList(int startRow,int pageSize){
		
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			String sql ="";
			List<BoardBean> boardList = new ArrayList<BoardBean>();
			
			try {
				//DB연결
				con = getConnection();
				//SQL문 만들기
				sql = "select * from animalProjectBoard order by number desc limit ?,?";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, startRow);
				pstmt.setInt(2, pageSize);
				
				rs = pstmt.executeQuery();
				
				while(rs.next()){
					
					//검색한 글목록중.. 한줄단위의 데이터를 저장할 용도로 객체 생성
					BoardBean bBean = new BoardBean();
					// rs => BoardBean객체의 각 변수에 저장
					bBean.setNumber(rs.getInt("number"));
					bBean.setName(rs.getString("name"));
					bBean.setPass(rs.getString("pass"));
					bBean.setSubject(rs.getString("subject"));
					bBean.setContent(rs.getString("content"));
					bBean.setDate(rs.getString("date"));
					
					//BoardBean 객체 => ArrayList배열에 추가
					boardList.add(bBean);
					
					
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
			return boardList;	//검색한 글정보들 (BoardBean객체들)을 저장하고 있는 배열공간인??
		
		}//getBoardList메소드 끝
		
		
		//글목록 검색해서 가져오는 메소드
		public List<BoardBean> getBoardList(int startRow,int pageSize,String value){
			
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			String sql ="";
			List<BoardBean> boardList = new ArrayList<BoardBean>();
			
			try {
				//DB연결
				con = getConnection();
				//SQL문 만들기
				sql = "select * from animalProjectBoard where subject like ? order by number desc limit ?,?";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, "%"+value+"%");
				pstmt.setInt(2, startRow);
				pstmt.setInt(3, pageSize);
				
				rs = pstmt.executeQuery();
				
				while(rs.next()){
					
					//검색한 글목록중.. 한줄단위의 데이터를 저장할 용도로 객체 생성
					BoardBean bBean = new BoardBean();
					// rs => BoardBean객체의 각 변수에 저장
					bBean.setNumber(rs.getInt("number"));
					bBean.setName(rs.getString("name"));
					bBean.setPass(rs.getString("pass"));
					bBean.setSubject(rs.getString("subject"));
					bBean.setContent(rs.getString("content"));
					bBean.setDate(rs.getString("date"));
					
					//BoardBean 객체 => ArrayList배열에 추가
					boardList.add(bBean);
					
					
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
			return boardList;	//검색한 글정보들 (BoardBean객체들)을 저장하고 있는 배열공간인??
			
		}//getBoardList메소드 끝
	
	/*-----------------------------------------------------------------------------------------------*/
	
	
	// boardList.jsp 에서 글목록에있는 글 하나를 클릭했을때
	// boardDetail.jsp로 get방식으로 Num을 가지고 이동해
	// boardDetail.jsp에서 해당 Num(number)를 가지고 DB에서 해당하는 글을 select 하는 작업
	public int selectContent(int number,BoardBean bBean){
		
		int a = 0;
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql ="";
		try {
			con=getConnection();
			sql="select * from animalProjectBoard where number=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, number);
			rs = pstmt.executeQuery();
			if(rs.next()){
				bBean.setNumber(rs.getInt(1));
				bBean.setName(rs.getString(2));
				bBean.setPass(rs.getString(3));
				bBean.setSubject(rs.getString(4));
				bBean.setContent(rs.getString(5));
				bBean.setDate(rs.getString(6));
			}
			
		} catch (Exception e) {
			System.out.println("selectCentent 메소드 내부에서 예외 발생 : "+ e);
		
		} finally {
			try {
				if(rs != null)rs.close();
				if(pstmt != null)pstmt.close();
				if(con != null)con.close();
				
			} catch (SQLException e) {
				System.out.println("getBoardCount메소드 내부의 자원해제 예외 발생 : "+e);
			}
		}
		
		return a;
	}//selectContent()끝
	
	/*-----------------------------------------------------------------------------------------------*/
	
	
	//secessionBoard()는 회원 탈퇴했을때 회원이 작성한 게시글을 모두 삭제 해주는 작업
	public void secessionBoard(String id){
		
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql ="";
		
		try {
			con=getConnection();
			sql="delete from animalProjectBoard where name=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.executeUpdate();
		
		} catch (Exception e) {
			System.out.println("secessionBoard() 내에서 예외 발생 : "+ e);
		
		} finally {
			try {
				if(rs != null)rs.close();
				if(pstmt != null)pstmt.close();
				if(con != null)con.close();
				
			} catch (SQLException e) {
				System.out.println("secessionBoard메소드 내부의 자원해제 예외 발생 : "+e);
			}
		}
		
		
	}//secessionBoard() 끝
	
	
	// 게시글 수정하기 버튼을 클릭했을때 DB와 연동하여 UPDATE작업을 수행
	public void updateBoard(BoardBean bBean){
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql ="";
		
		try {
			con=getConnection();
			sql = "update animalProjectBoard set number=?,name=?,pass=?,subject=?,content=?,date=now() where number=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, bBean.getNumber());
			pstmt.setString(2, bBean.getName());
			pstmt.setString(3, bBean.getPass());
			pstmt.setString(4, bBean.getSubject());
			pstmt.setString(5, bBean.getContent());
			pstmt.setInt(6, bBean.getNumber());
			
			pstmt.executeUpdate();
			
		} catch (Exception e) {
			System.out.println("updateBoard() 내부에서 예외 발생 : "+ e);
		
		}  finally {
			try {
				if(rs != null)rs.close();
				if(pstmt != null)pstmt.close();
				if(con != null)con.close();
				
			} catch (SQLException e) {
				System.out.println("updateBoard메소드 내부의 자원해제 예외 발생 : "+e);
			}
		}
	}//updateBoard 끝
	
	
	// 게시글 삭제하기 버튼을 클릭했을떄 DB와 연동하여 delete작업을 수행
	public void deleteBoard(int number){
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql ="";
		
		try {
			con = getConnection();
			sql = "delete from animalProjectBoard where number=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, number);
			pstmt.executeUpdate();
		} catch (Exception e) {
			System.out.println("deleteBoard() 내에서 예외 발생 : "+ e);
		}  finally {
			try {
				if(rs != null)rs.close();
				if(pstmt != null)pstmt.close();
				if(con != null)con.close();
				
			} catch (SQLException e) {
				System.out.println("deleteBoard메소드 내부의 자원해제 예외 발생 : "+e);
			}
		}
	}//deleteBoard 끝
	
	
}
