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

import com.team03.albumit.dto.SharedAlbum;
import com.team03.albumit.dto.SharedPhoto;

@Component
public class SharedPhotoDao {
	
	
		@Autowired
		private JdbcTemplate jdbcTemplate;
		
		public void insert(SharedPhoto sharedPhoto) {
			Integer pk = null;
			String sql = "insert into Sharedphoto (photo_no, uid, album_no, share_date, share_like, share_hitcount ) values(?, ?, ?, now(), ?, ?)";
			
			jdbcTemplate.update(new PreparedStatementCreator() {
				@Override
				public PreparedStatement createPreparedStatement(Connection conn) throws SQLException {
					PreparedStatement pstmt = conn.prepareStatement(sql);
					pstmt.setInt(1, sharedPhoto.getPhoto_no());
					pstmt.setInt(2, sharedPhoto.getUid());
					pstmt.setInt(3, sharedPhoto.getAlbum_no());
					pstmt.setInt(4, sharedPhoto.getShare_like());
					pstmt.setInt(5, sharedPhoto.getShare_hitcount());
				
					return pstmt;
				}
			});
			
		}
		
		public int updateLike(int photo_no, int album_no) {
			String sql = "update Sharedphoto set share_like=share_like+1 where photo_no=?";
			int rows = jdbcTemplate.update(sql, photo_no, album_no);
			return rows;
		}
		
		public int updateHitcount(int photo_no, int album_no) {
			String sql = "update Sharedphoto set share_hitcount=share_hitcount+1 where photo_no=? and album_no=?";
			int rows = jdbcTemplate.update(sql, photo_no, album_no);
			return rows;
		}
		
		
		public List<SharedPhoto> selectByPhotoNo(int photo_no) {
			String sql = "select * from Sharedphoto where photo_no=?";
			List<SharedPhoto> list = jdbcTemplate.query(
				sql,
				new Object[] {photo_no},
				new RowMapper<SharedPhoto>() {
					@Override
					public SharedPhoto mapRow(ResultSet rs, int rowNum) throws SQLException {
						SharedPhoto sharedPhoto = new SharedPhoto();
						sharedPhoto.setPhoto_no(rs.getInt("photo_no"));
						sharedPhoto.setUid(rs.getInt("uid"));
						sharedPhoto.setAlbum_no(rs.getInt("album_no"));
						sharedPhoto.setShare_date(rs.getDate("share_date"));
						sharedPhoto.setShare_like(rs.getInt("share_like"));
						sharedPhoto.setShare_hitcount(rs.getInt("share_hitcount"));
						return sharedPhoto;
					}
				});
			return list;
		}
		
		public List<SharedPhoto> selectByAlbumPhotoNo(int album_no,int photo_no) {
			String sql = "select * from Sharedphoto where album_no=? and photo_no=?";
			List<SharedPhoto> list = jdbcTemplate.query(
				sql,
				new Object[] {album_no, photo_no},
				new RowMapper<SharedPhoto>() {
					@Override
					public SharedPhoto mapRow(ResultSet rs, int rowNum) throws SQLException {
						SharedPhoto sharedPhoto = new SharedPhoto();
						sharedPhoto.setPhoto_no(rs.getInt("photo_no"));
						sharedPhoto.setUid(rs.getInt("uid"));
						sharedPhoto.setAlbum_no(rs.getInt("album_no"));
						sharedPhoto.setShare_date(rs.getDate("share_date"));
						sharedPhoto.setShare_like(rs.getInt("share_like"));
						sharedPhoto.setShare_hitcount(rs.getInt("share_hitcount"));
						return sharedPhoto;
					}
				});
			return list;
		}
		
		
		public List<SharedPhoto> selectByAlbumNo(int album_no) {
			String sql = "select * from Sharedphoto where album_no=?";
			List<SharedPhoto> list = jdbcTemplate.query(
				sql,
				new Object[] {album_no},
				new RowMapper<SharedPhoto>() {
					@Override
					public SharedPhoto mapRow(ResultSet rs, int rowNum) throws SQLException {
						SharedPhoto sharedPhoto = new SharedPhoto();
						sharedPhoto.setPhoto_no(rs.getInt("photo_no"));
						sharedPhoto.setUid(rs.getInt("uid"));
						sharedPhoto.setAlbum_no(rs.getInt("album_no"));
						sharedPhoto.setShare_date(rs.getTime("share_date"));
						sharedPhoto.setShare_like(rs.getInt("share_like"));
						sharedPhoto.setShare_hitcount(rs.getInt("share_hitcount"));
						
						return sharedPhoto;
					}
				});
			return list;
		}
		
		
		
		public int delete(int photo_no, int album_no) {
			String sql = "delete from Sharedphoto where photo_no=? and album_no=? ";
			int rows = jdbcTemplate.update(
				sql,
				photo_no,
				album_no
			);
			return rows;
		}

}
