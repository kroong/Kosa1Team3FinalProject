package com.team03.albumit.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.PreparedStatementCreator;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.jdbc.support.GeneratedKeyHolder;
import org.springframework.jdbc.support.KeyHolder;
import org.springframework.stereotype.Component;

import com.team03.albumit.dto.Thumbnail;



@Component
public class ThumbnailDao {
	@Autowired
	private JdbcTemplate jdbcTemplate;
	
	public Integer insert(Thumbnail thumbnail) {
		Integer pk = null;
		String sql = "insert into Thumbnail (thumbnail_original_file_name, thumbnail_filesystem_name, thumbnail_content_type) values(?, ?, ?)";
		KeyHolder keyHolder = new GeneratedKeyHolder();
		jdbcTemplate.update(new PreparedStatementCreator() {
			@Override
			public PreparedStatement createPreparedStatement(Connection conn) throws SQLException {
				PreparedStatement pstmt = conn.prepareStatement(sql, new String[] {"thumbnail_no"});
				pstmt.setString(1, thumbnail.getThumbnail_original_file_name());
				pstmt.setString(2, thumbnail.getThumbnail_filesystem_name());
				pstmt.setString(3, thumbnail.getThumbnail_content_type());
				return pstmt;
			}
		},keyHolder);
		Number keyNumber = keyHolder.getKey();
		pk = keyNumber.intValue();
		return pk;
	}
	

	
	public Thumbnail selectByPk(int thumbnail_no) {
		String sql = "select * from boards where thumbnail_no=?";
		Thumbnail thumbnail = jdbcTemplate.queryForObject(
			sql,
			new Object[] {thumbnail_no},
			new RowMapper<Thumbnail>() {
				@Override
				public Thumbnail mapRow(ResultSet rs, int rowNum) throws SQLException {
					Thumbnail thumbnail = new Thumbnail();
					thumbnail.setThumbnail_no(rs.getInt("thumbnail_no"));
					thumbnail.setThumbnail_original_file_name(rs.getString("thumbnail_original_file_name"));
					thumbnail.setThumbnail_filesystem_name(rs.getString("thumbnail_filesystem_name"));
					thumbnail.setThumbnail_content_type(rs.getString("thumbnail_content_type"));
				
					return thumbnail;
				}
			}
		);
		return thumbnail;
	}
	
	public List<Thumbnail> selectInAlbumList(String incluase) {
		List<Thumbnail> list = null;
		String sql = "SELECT a.thumbnail_no, thumbnail_original_file_name, "
				+ "thumbnail_content_type, thumbnail_filesystem_name "
				+ "FROM Thumbnail a, Album b WHERE a.thumbnail_no IN"
				+ "(SELECT b.thumbnail_no FROM Album WHERE album_no IN(" + incluase
				+ "))";
		list = jdbcTemplate.query(sql, new RowMapper<Thumbnail>(){

			@Override
			public Thumbnail mapRow(ResultSet rs, int rowNum) throws SQLException {
				Thumbnail th = new Thumbnail();
				th.setThumbnail_no(rs.getInt("thumbnail_no"));
				th.setThumbnail_original_file_name(rs.getString("thumbnail_original_file_name"));
				th.setThumbnail_filesystem_name(rs.getString("thumbnail_filesystem_name"));
				th.setThumbnail_content_type(rs.getString("thumbnail_content_type"));
				
				return th;
			}
			
		});
		
		return list;
	}

	
	public int delete(long thumbnail_no) {
		String sql = "delete from Thumbnail where thumbnail_no=?";
		int rows = jdbcTemplate.update(
			sql,
			thumbnail_no
		);
		return rows;
	}
	

	public int selectCount() {
		String sql = "select count(*) from Thumbnail";
		int rows = jdbcTemplate.queryForObject(sql, Integer.class);
		return rows;
	}

}
