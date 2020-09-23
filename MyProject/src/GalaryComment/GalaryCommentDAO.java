package GalaryComment;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class GalaryCommentDAO {
		//커넥션 연결
		private Connection getConnection() throws Exception {
	
			Connection con = null;
			Context init = new InitialContext();
			DataSource ds = (DataSource) init.lookup("java:/comp/env/jdbc/jspbeginner");
			con = ds.getConnection();
			return con;
		}
			
//	-----------------------------------------------------------------------------------------
		
		// galaryDetail.jsp로 이동했을때 기존에 존재하던 댓글들을 글 넘버로 찾아와서 보여주기위한 DB작업
		public ArrayList<GalaryCommentBean> selectComment(int num){
			Connection con= null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			String sql ="";
			ArrayList<GalaryCommentBean> list = new ArrayList<GalaryCommentBean>();	//댓글들을 담아갈 가변길이 배열
			try {
				con=getConnection();
				sql="select * from animalProjectGalaryComment where number=?";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, num);
				rs = pstmt.executeQuery();
				GalaryCommentBean gcBean =null;
				while(rs.next()){
					gcBean= new GalaryCommentBean();
					gcBean.setNumber(rs.getInt(1));
					gcBean.setId(rs.getString(2));
					gcBean.setComment(rs.getString(3));
					gcBean.setDate(rs.getString(4));
					gcBean.setPrimaryNum(rs.getInt(5));
					list.add(gcBean);
				}
			} catch (Exception e) {
				System.out.println("selectComment() 내에서 예외 발생 : "+e);
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
		}//selectComment끝
		
		
		// galaryDetail.jsp에서 댓글 등록 버튼을 클릭 하면 ~~ 해당 글의 글번호, 작성한 글내용, 작성한 사람의 ID를 DB에 INSERT
		public void insertComment(String id,String comment,int num){
			Connection con= null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			String sql ="";
			try {
				int primaryNum = 0;
				con = getConnection();
				sql="select max(primaryNum) from animalProjectgalaryComment";
				pstmt=con.prepareStatement(sql);
				rs = pstmt.executeQuery();
				if(rs.next()){
					primaryNum=rs.getInt(1)+1;
				}
				
				sql="insert into animalprojectgalarycomment values(?,?,?,now(),?)";
				pstmt=con.prepareStatement(sql);
				pstmt.setInt(1, num);
				pstmt.setString(2, id);
				pstmt.setString(3, comment);
				pstmt.setInt(4, primaryNum);
				pstmt.executeUpdate();
			} catch (Exception e) {
				System.out.println("insertComment() 내부에서 예외 발생 : "+ e);
			}  finally {
				try {
					if(rs != null)rs.close();
					if(pstmt != null)pstmt.close();
					if(con != null)con.close();
					
				} catch (SQLException e) {
					System.out.println("insertComment메소드 내부의 자원해제 예외 발생 : "+e);
				}
			}
		}
		
		//galary.jsp 의 화면에서 각 게시글들이 보이는데 각 게시글마다 댓글의 수를 적용시키는 작업
		public int countComment(int num){
			
			int count=0;
			Connection con= null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			String sql ="";
			try {
				con=getConnection();
				sql="select count(*) from animalProjectGalaryComment where number=?";
				pstmt=con.prepareStatement(sql);
				pstmt.setInt(1, num);
				rs = pstmt.executeQuery();
				if(rs.next()){
					count=rs.getInt(1);
				}
			} catch (Exception e) {
				System.out.println("countComment()내에서 예외발생 : "+e);
			}  finally {
				try {
					if(rs != null)rs.close();
					if(pstmt != null)pstmt.close();
					if(con != null)con.close();
					
				} catch (SQLException e) {
					System.out.println("countComment메소드 내부의 자원해제 예외 발생 : "+e);
				}
			}
			return count;
		}//countComment() 끝
		
		//galaryDetail.jsp에서 자신이 작성한 댓글 삭제버튼을 클릭했을때 해당 댓글의 고유번호로 DB에서 DELETE작업
		public int deleteComment(int primaryNum){
			int result = 0;
			Connection con= null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			String sql ="";
			try {
				con=getConnection();
				sql="delete from animalprojectgalarycomment where primaryNum=?";
				pstmt=con.prepareStatement(sql);
				pstmt.setInt(1, primaryNum);
				result = pstmt.executeUpdate();
			} catch (Exception e) {
				System.out.println("deleteComment() 내에서 예외 발생 : "+e);
			}   finally {
				try {
					if(rs != null)rs.close();
					if(pstmt != null)pstmt.close();
					if(con != null)con.close();
					
				} catch (SQLException e) {
					System.out.println("deleteComment메소드 내부의 자원해제 예외 발생 : "+e);
				}
			}
			
			return result;
			
		}//deleteComment() 끝
		
		
		//galary.jsp에서 댓글 수정하기 버튼 클릭했을때 window.open()으로 새 창을 띄워준다 
		//그 창안에 해당 댓글의 primaryNum으로 DB에서 select해와서 해당 댓글을 띄워주는 작업
		public GalaryCommentBean selectDetailComment(int primaryNum){

			GalaryCommentBean gcBean =null;
			Connection con= null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			String sql ="";
			try {
				con = getConnection();
				sql="select * from animalProjectGalaryComment where primaryNum=?";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, primaryNum);
				rs = pstmt.executeQuery();
				if(rs.next()){
					gcBean = new GalaryCommentBean();
					gcBean.setNumber(rs.getInt(1));
					gcBean.setId(rs.getString(2));
					gcBean.setComment(rs.getString(3));
					gcBean.setDate(rs.getString(4));
					gcBean.setPrimaryNum(rs.getInt(5));
				}
			} catch (Exception e) {
				System.out.println("selectDetailComment() 내부에서 예외 발생 : "+e);
			}   finally {
				try {
					if(rs != null)rs.close();
					if(pstmt != null)pstmt.close();
					if(con != null)con.close();
					
				} catch (SQLException e) {
					System.out.println("selectDetailComment메소드 내부의 자원해제 예외 발생 : "+e);
				}
			}
			
			return gcBean;
		}//selectDetailComment() 끝
		
		//updateGalaryCOmment에서 댓글 수정하기 버튼 클릭시 수정하는 작업
		public int updateDetailComment(String comment,int primaryNum){
			int result = 0;
			Connection con= null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			String sql ="";
			try {
				con = getConnection();
				sql="update animalProjectGalaryComment set comment=? ,date=now() where primaryNum=? ";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, comment);
				pstmt.setInt(2, primaryNum);
				result = pstmt.executeUpdate();
			} catch (Exception e) {
				System.out.println("updateDetailComment() 내부에서 예외 발생 : "+e);
			}   finally {
				try {
					if(rs != null)rs.close();
					if(pstmt != null)pstmt.close();
					if(con != null)con.close();
					
				} catch (SQLException e) {
					System.out.println("updateDetailComment메소드 내부의 자원해제 예외 발생 : "+e);
				}
			}
			
			
			return result;
		}//updateDetailComment() 끝
		
}// 클래스
