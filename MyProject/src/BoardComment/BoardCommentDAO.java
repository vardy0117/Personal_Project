package BoardComment;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class BoardCommentDAO {
	

	//커넥션 연결
		private Connection getConnection() throws Exception {

			Connection con = null;
			Context init = new InitialContext();
			DataSource ds = (DataSource) init.lookup("java:/comp/env/jdbc/jspbeginner");
			con = ds.getConnection();
			return con;
		}
		
		
		/*-----------------------------------------------------------------------------------------------*/	
		
		
		
		// boardComment.jsp에서 전달받은 댓글작성자 ID, 댓글Comment, 댓글의 페이지번호,댓글의 고유번호를 전달받아서
		// DB에 입력
		public int insertComment(BoardCommentBean bcBean){
			
			int result = 0;	//등록이 완료되면 0을반환 실패하면 1을반환
			
			//ArrayList<BoardCommentBean> list = new ArrayList<BoardCommentBean>();
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			String sql ="";
			try {
				int primaryNum = 0;
				
				con = getConnection();
				sql="select max(primaryNum) from animalProjectBoardComment";
				pstmt=con.prepareStatement(sql);
				rs = pstmt.executeQuery();
				if(rs.next()){
					primaryNum=rs.getInt(1)+1;
				}
				con=getConnection();
				sql="insert into animalProjectBoardComment values(?,?,?,now(),?)";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, bcBean.getNumber());
				pstmt.setString(2, bcBean.getId());
				pstmt.setString(3, bcBean.getComment());
				pstmt.setInt(4, primaryNum);
				pstmt.executeUpdate();
				result = 0;
				
				
			} catch (Exception e) {
				System.out.println("insertComment 내부에서 예외 발생: "+e);
				result = 1;
				
				
			} finally {
				try {
					if(rs != null)rs.close();
					if(pstmt != null)pstmt.close();
					if(con != null)con.close();
					
				} catch (SQLException e) {
					System.out.println("insertComment메소드 내부의 자원해제 예외 발생 : "+e);
				}
			}
			return result;
		
		}//insertComment() 끝
		
		
		/*-----------------------------------------------------------------------------------------------*/	
		
		
		//DB에 저장되어있는 댓글들을 보여주는 작업
		public ArrayList<BoardCommentBean> selectComment(int number){
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			String sql ="";
			
			ArrayList<BoardCommentBean> list = new ArrayList<BoardCommentBean>();
			
			try {
				con=getConnection();
				sql="select * from animalProjectBoardComment where number=?";
				pstmt=con.prepareStatement(sql);
				pstmt.setInt(1,number);
				rs = pstmt.executeQuery();
				
				while(rs.next()){
					BoardCommentBean bcBean2 = new BoardCommentBean();
					bcBean2.setNumber(rs.getInt(1));
					bcBean2.setId(rs.getString(2));
					bcBean2.setComment(rs.getString(3));
					bcBean2.setDate(rs.getString(4));
					bcBean2.setPrimaryNum(rs.getInt(5));
					list.add(bcBean2);
				}
			} catch (Exception e) {
				System.out.println("selectComment() 내부에서 예외 발생 : "+e);
			
			
			} finally {
				try {
					if(rs != null)rs.close();
					if(pstmt != null)pstmt.close();
					if(con != null)con.close();
					
				} catch (SQLException e) {
					System.out.println("selectComment메소드 내부의 자원해제 예외 발생 : "+e);
				}
			}
			
			return list;
			
		}//selectComment() 끝
		
		
		
		/*-----------------------------------------------------------------------------------------------*/
		
		
		//secessionBoardComment()는 회원 탈퇴했을때 회원이 작성한 댓글을 모두 삭제 해주는 작업
		public void secessionBoardComment(String id){
			
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			String sql ="";
			
			try {
				con=getConnection();
				sql="delete from animalProjectBoardComment where id=?";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, id);
				pstmt.executeUpdate();
			
			} catch (Exception e) {
				System.out.println("secessionBoardComment() 내에서 예외 발생 : "+ e);
			
			} finally {
				try {
					if(rs != null)rs.close();
					if(pstmt != null)pstmt.close();
					if(con != null)con.close();
					
				} catch (SQLException e) {
					System.out.println("secessionBoardComment메소드 내부의 자원해제 예외 발생 : "+e);
				}
			}
			
		}//	secessionBoardComment 끝
		
		
		//deleteBoardComment()는 게시글 삭제를 눌렀을때 해당 게시글에 있던 댓글도 삭제되는 작업
		public void deleteBoardComment(int number){
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			String sql ="";
			try {
				con=getConnection();
				sql="delete from animalProjectBoardComment where number=?";
				pstmt=con.prepareStatement(sql);
				pstmt.setInt(1, number);
				pstmt.executeUpdate();
				
			} catch (Exception e) {
				System.out.println("deleteBoardComment() 내부에서 예외 발생 : "+e);
			
			
			}  finally {
				try {
					if(rs != null)rs.close();
					if(pstmt != null)pstmt.close();
					if(con != null)con.close();
					
				} catch (SQLException e) {
					System.out.println("deleteBoardComment메소드 내부의 자원해제 예외 발생 : "+e);
				}
			}
			
		}//deleteBoardComment() 끝
		
		//deleteComment메소드는 자신이 작성한 댓글 옆에 [ X ] 버튼을 클릭했을때 댓글이 삭제되는 기능을 한다
		public void deleteComment(int primaryNum){
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			String sql ="";
			try {
				con = getConnection();
				sql="delete from animalProjectBoardComment where primaryNum=?";
				pstmt=con.prepareStatement(sql);
				pstmt.setInt(1, primaryNum);
				pstmt.executeUpdate();
			} catch (Exception e) {
				System.out.println("deleteComment()내부에서 예외 발생 : "+e);
			}  finally {
				try {
					if(rs != null)rs.close();
					if(pstmt != null)pstmt.close();
					if(con != null)con.close();
					
				} catch (SQLException e) {
					System.out.println("deleteComment메소드 내부의 자원해제 예외 발생 : "+e);
				}
			}
		
		}//deleteComment() 끝
		
		// 댓글의 수정하기 버튼클릭시 댓글의 고유번호인 primaryNum을 가지고 DB에서 select하는 작업
		public ArrayList<BoardCommentBean> getComment(int primaryNum){
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			String sql ="";
			
			ArrayList<BoardCommentBean> list = new ArrayList<BoardCommentBean>();
			
			try {
				con=getConnection();
				sql="select * from animalProjectBoardComment where primaryNum=?";
				pstmt=con.prepareStatement(sql);
				pstmt.setInt(1,primaryNum);
				rs = pstmt.executeQuery();
				
				while(rs.next()){
					BoardCommentBean bcBean2 = new BoardCommentBean();
					bcBean2.setNumber(rs.getInt(1));
					bcBean2.setId(rs.getString(2));
					bcBean2.setComment(rs.getString(3));
					bcBean2.setDate(rs.getString(4));
					bcBean2.setPrimaryNum(rs.getInt(5));
					list.add(bcBean2);
				}
			} catch (Exception e) {
				System.out.println("getComment() 내부에서 예외 발생 : "+e);
				
				
			} finally {
				try {
					if(rs != null)rs.close();
					if(pstmt != null)pstmt.close();
					if(con != null)con.close();
					
				} catch (SQLException e) {
					System.out.println("selectComment메소드 내부의 자원해제 예외 발생 : "+e);
				}
			}
			
			return list;
			
		}//getComment() 끝
		
		
		// boardDetail.jsp에서 회원이 등록한 댓글 수정 버튼 클릭시 수정작업
		public void updateComment(int primaryNum,String newComment){
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			String sql ="";
			try {
				con=getConnection();
				sql="select * from animalProjectBoardComment where primaryNum=?";
				pstmt=con.prepareStatement(sql);
				pstmt.setInt(1,primaryNum);
				rs = pstmt.executeQuery();
				if(rs.next()){
					sql="update animalProjectBoardComment set comment=?,date=now() where primaryNum=?";
					pstmt=con.prepareStatement(sql);
					pstmt.setString(1, newComment);
					pstmt.setInt(2, primaryNum);
					pstmt.executeUpdate();
				}
			} catch (Exception e) {
				System.out.println("updateComment()내에서 예외발생 : "+e);
			} finally {
				try {
					if(rs != null)rs.close();
					if(pstmt != null)pstmt.close();
					if(con != null)con.close();
					
				} catch (SQLException e) {
					System.out.println("updateComment메소드 내부의 자원해제 예외 발생 : "+e);
				}
			}
		}//updateComment()끝
}
