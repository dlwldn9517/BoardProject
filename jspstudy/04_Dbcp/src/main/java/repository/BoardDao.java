package repository;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;
import javax.swing.border.Border;

import domain.Board;

public class BoardDao {
	
	// field
	private Connection con;
	private PreparedStatement ps;
	private ResultSet rs;
	private String sql;
	
	// Connection Pool 관리
	private DataSource dataSource;
	
	// singleton - pattern
	private static BoardDao dao = new BoardDao();
	private BoardDao() {	// BoardDao()는 내부에서만 만들 수 있다. (외부X)
		try {
			// DataSource 객체 생성
			// context.xml에서 name="jdbc/oracle11g"인 Resource를 찾아서 생성(JNDI)
			Context ctx = new InitialContext();
			Context envCtx = (Context)ctx.lookup("java:comp/env");
			dataSource = (DataSource)envCtx.lookup("jdbc/oracle11g");
			// dataSource = (DataSource)ctx.lookup("java:comp/env/jdbc/oracle11g");	// 위 2줄을 1줄로
		} catch (NamingException e) {
			e.printStackTrace();
		}
		
	}
	
	public static BoardDao getInstance() {
		return dao;
	}
	
	
	// method
	
	// 1. 접속/자원 해제
	public void close(Connection con, PreparedStatement ps, ResultSet rs) {
		try {
			if(rs != null ) {rs.close();}
			if(ps != null ) {ps.close();}
			if(con != null ) {con.close();}  // Connection Pool의 close()는 Connection 종료가 아닌 Connection 반환으로 동작
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	// 2. 목록 반환하기
	public List<Board> selectAllBoards() {
		List<Board> boards = new ArrayList<Board>();
		try {
			
			con = dataSource.getConnection();	// Connection Pool로부터 Connection 대여
			sql = "SELECT BOARD_NO, TITLE, CONTENT, CREATE_DATE FROM BOARD ORDER BY BOARD_NO DESC";
			ps = con.prepareStatement(sql);
			rs = ps.executeQuery();	 // SELECT문은 executeQuery() 사용!
			
			
			while(rs.next()) {	// 목록보기는 while문
				
				// Board board는 한 개의 게시글을 의미
				Board board = new Board();
				board.setBoard_no(rs.getInt(1));		// rs.getInt("BOARD_NO")
				board.setTitle(rs.getString(2));		// rs.getString("TITLE")
				board.setContent(rs.getString(3));		// rs.getString("CONTENT")
				board.setCreate_date(rs.getDate(4));	// rs.getDate("CREATE_DATE")
				
				// 가져온 게시글을 리스트에 추가함
				boards.add(board);
			}
			
			// 최초 rs는 아무것도 가지고 오지 않고, rs.next() - 1행, 또다시 rs.next() - 2행 가지고 온다.
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(con, ps, rs);
		}
		return boards;
	}
	
	
}