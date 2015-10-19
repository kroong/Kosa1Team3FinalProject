package com.team03.albumit.dao;

import java.sql.*;
import java.util.*;

import org.springframework.beans.factory.annotation.*;
import org.springframework.jdbc.core.*;
import org.springframework.stereotype.*;

import com.team03.albumit.dto.*;

@Component
public class LikedAlbumDao {

	@Autowired
	private JdbcTemplate jdbcTemplate;
	
	// C
	public void insert(int album_no, int uid) {
		String sql = "INSERT INTO LikedAlbum(album_no, uid) VALUES(?,?)";
		
		jdbcTemplate.update(new PreparedStatementCreator() {
			
			@Override
			public PreparedStatement createPreparedStatement(Connection con) throws SQLException {
				PreparedStatement pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, album_no);
				pstmt.setInt(2, uid);
				return pstmt;
			}
		});
	}
	
	// R
	public List<LikedAlbum> selectByUid(int uid) {
		String sql = "SELECT * FROM LikedAlbum WHERE uid=?";
		
		List<LikedAlbum> list = jdbcTemplate.query(sql, 
				new Object[] {uid},
				new RowMapper<LikedAlbum>() {
					@Override
					public LikedAlbum mapRow(ResultSet rs, int rowNum) throws SQLException {
						LikedAlbum likedAlbum = new LikedAlbum();
						likedAlbum.setAlbum_no(rs.getInt("album_no"));
						likedAlbum.setUid(rs.getInt("uid"));
						return likedAlbum;
					}
				});
		
		return list;
	}
	
	// U
	// not needed
	
	// D
	public int delete(LikedAlbum likedAlbum) {
		String sql = "DELETE FROM LikedAlbum WHERE album_no=? and uid=?";
		int row = jdbcTemplate.update(sql, likedAlbum.getAlbum_no(), likedAlbum.getUid());
		
		return row;
	}
}
