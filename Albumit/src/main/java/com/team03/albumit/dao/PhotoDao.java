package com.team03.albumit.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.*;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.PreparedStatementCreator;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.jdbc.support.GeneratedKeyHolder;
import org.springframework.jdbc.support.KeyHolder;
import org.springframework.stereotype.Component;

import com.team03.albumit.dto.Photo;


@Component
public class PhotoDao {
	@Autowired
	private JdbcTemplate jdbcTemplate;
	
	public Integer insert(Photo photo) {
		Integer pk = null;
		String sql = "insert into Photo (photo_place, album_no, photo_date, photo_original_file_name, photo_filesystem_name, photo_content_type, photo_like, photo_hitcount, photo_content, photo_title, uid) values(?, ?, now(), ?, ?, ?, ?, ?, ?, ?, ?)";
		KeyHolder keyHolder = new GeneratedKeyHolder();
		jdbcTemplate.update(new PreparedStatementCreator() {
			@Override
			public PreparedStatement createPreparedStatement(Connection conn) throws SQLException {
				PreparedStatement pstmt = conn.prepareStatement(sql, new String[] {"photo_no"});
				pstmt.setString(1, photo.getPhoto_place());
				pstmt.setInt(2, photo.getAlbum_no());
				pstmt.setString(3, photo.getPhoto_original_file_name());
				pstmt.setString(4, photo.getPhoto_filesystem_name());
				pstmt.setString(5, photo.getPhoto_content_type());
				pstmt.setInt(6, photo.getPhoto_like());
				pstmt.setInt(7, photo.getPhoto_hitcount());
				pstmt.setString(8, photo.getPhoto_content());
				pstmt.setString(9, photo.getPhoto_title());
				pstmt.setInt(10, photo.getUid());
				return pstmt;
			}
		},keyHolder);
		Number keyNumber = keyHolder.getKey();
		pk = keyNumber.intValue();
		return pk;
	}
	

	public Photo selectByPk(int photo_no) {
		String sql = "select * from Photo where photo_no=?";
		Photo photo = jdbcTemplate.queryForObject(
			sql,
			new Object[] {photo_no},
			new RowMapper<Photo>() {
				@Override
				public Photo mapRow(ResultSet rs, int rowNum) throws SQLException {
					Photo photo = new Photo();
					photo.setPhoto_no(rs.getInt("photo_no"));
					photo.setAlbum_no(rs.getInt("album_no"));
					photo.setPhoto_date(rs.getDate("photo_date"));
					photo.setPhoto_original_file_name(rs.getString("photo_original_file_name"));
					photo.setPhoto_filesystem_name(rs.getString("photo_filesystem_name"));
					photo.setPhoto_content_type(rs.getString("photo_content_type"));  
					photo.setPhoto_like(rs.getInt("photo_like"));
					photo.setPhoto_hitcount(rs.getInt("photo_hitcount"));
					photo.setPhoto_content(rs.getString("photo_content"));
					photo.setPhoto_title(rs.getString("photo_title"));
					photo.setUid(rs.getInt("uid"));
					return photo;
				}
			}
		);
		return photo;
	}
	
	public int update(Photo photo) {
		String sql = "update Photo set photo_place=? photo_title=?, photo_content=? where photo_no=?";
		int rows = jdbcTemplate.update(
			sql,
			photo.getPhoto_place(),
			photo.getPhoto_title(),
			photo.getPhoto_content(),
			photo.getPhoto_no()
		);
		return rows;
	}
	
	public int updateUid(Photo photo, int uid) {
		String sql = "update Photo set uid=? where photo_no=?";
		int rows = jdbcTemplate.update(
			sql,
			photo.getUid(),
			photo.getPhoto_no()
		);
		return rows;
	}
	
	
	public int updateAlbum(Photo photo) {
		String sql = "update Photo set album_no=? where photo_no=?";
		int rows = jdbcTemplate.update(
			sql,
			photo.getAlbum_no(),
			photo.getPhoto_no()
		);
		return rows;
	}
	
	public int delete(int photo_no) {
		String sql = "delete from Photo where photo_no=?";
		int rows = jdbcTemplate.update(
			sql,
			photo_no
		);
		return rows;
	}
	
	public int updateHitcount(int photo_no) {
		String sql = "update Photo set photo_hitcount=photo_hitcount+1 where photo_no=?";
		int rows = jdbcTemplate.update(sql, photo_no);
		return rows;
	}	
	
	public int updateLike(int photo_no) {
		String sql = "update Photo set photo_like=photo_like+1 where photo_no=?";
		int rows = jdbcTemplate.update(sql, photo_no);
		return rows;
	}
	
	public int selectCount() {
		String sql = "select count(*) from Photo";
		int rows = jdbcTemplate.queryForObject(sql, Integer.class);
		return rows;
	}


	public List<Photo> selectByAlbumNo(int album_no) {
		String sql = "select * from Photo where album_no=?";
		List<Photo> list = jdbcTemplate.query(
			sql,
			new Object[] {album_no},
			new RowMapper<Photo>() {
				@Override
				public Photo mapRow(ResultSet rs, int rowNum) throws SQLException {
					Photo photo = new Photo();
					photo.setPhoto_no(rs.getInt("photo_no"));
					photo.setAlbum_no(rs.getInt("album_no"));
					photo.setPhoto_date(rs.getTimestamp("photo_date"));
					photo.setPhoto_original_file_name(rs.getString("photo_original_file_name"));
					photo.setPhoto_filesystem_name(rs.getString("photo_filesystem_name"));
					photo.setPhoto_content_type(rs.getString("photo_content_type"));  
					photo.setPhoto_like(rs.getInt("photo_like"));
					photo.setPhoto_hitcount(rs.getInt("photo_hitcount"));
					photo.setPhoto_content(rs.getString("photo_content"));
					photo.setPhoto_title(rs.getString("photo_title"));
					photo.setUid(rs.getInt("uid"));
					return photo;
				}
			}
		);
		return list;
		
	}
	
	public List<Photo> selectDate(int album_no) {
		String sql = "select p.photo_no, share_date, photo_date from Photo p, Sharedphoto s where p.photo_no=s.photo_no;";
		List<Photo> list = jdbcTemplate.query(
			sql,
			new Object[] {album_no},
			new RowMapper<Photo>() {
				@Override
				public Photo mapRow(ResultSet rs, int rowNum) throws SQLException {
					Photo photo = new Photo();
					photo.setPhoto_no(rs.getInt("photo_no"));
					photo.setAlbum_no(rs.getInt("album_no"));
					photo.setPhoto_date(rs.getDate("photo_date"));
					photo.setPhoto_original_file_name(rs.getString("photo_original_file_name"));
					photo.setPhoto_filesystem_name(rs.getString("photo_filesystem_name"));
					photo.setPhoto_content_type(rs.getString("photo_content_type"));  
					photo.setPhoto_like(rs.getInt("photo_like"));
					photo.setPhoto_hitcount(rs.getInt("photo_hitcount"));
					photo.setPhoto_content(rs.getString("photo_content"));
					photo.setPhoto_title(rs.getString("photo_title"));
					photo.setUid(rs.getInt("uid"));
					return photo;
				}
			}
		);
		return list;
		
	}


}
