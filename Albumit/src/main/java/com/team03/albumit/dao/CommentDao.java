package com.team03.albumit.dao;

import java.sql.*;
import java.util.*;

import org.springframework.beans.factory.annotation.*;
import org.springframework.jdbc.core.*;
import org.springframework.jdbc.support.*;
import org.springframework.stereotype.*;

import com.team03.albumit.dto.*;

@Component
public class CommentDao {
	
@Autowired
		private JdbcTemplate jdbcTemplate;
		
		// 
		public Integer insert(Comment comment) {
			Integer pk = null;
			String sql = "insert into Comment (photo_no, comment_no, cwriter, comment_content) "
					+ "values (?,?,?,?)";
			
			KeyHolder keyHolder = new GeneratedKeyHolder();
			jdbcTemplate.update(new PreparedStatementCreator() {

				@Override
				public PreparedStatement createPreparedStatement(Connection conn) throws SQLException {
					PreparedStatement pstmt = conn.prepareStatement(sql, new String[] { "comment_no" });
					pstmt.setInt(1, comment.getPhoto_no());
					pstmt.setInt(2, comment.getComment_no());
					pstmt.setString(3, comment.getCwriter());
					pstmt.setString(4, comment.getComment_content());
					return pstmt;
				}
			}, keyHolder);
			Number keyNumber = keyHolder.getKey();
			pk = keyNumber.intValue();
			return pk;
		}
		
		// 
		public List<Comment> selectByPN(int photo_no) {
			String sql = "select * from Comment where comment_no=?";
			
			List<Comment> comment = jdbcTemplate.query(
					sql,
					new Object[] {photo_no},
					new RowMapper<Comment> () {
						@Override
						public Comment mapRow(ResultSet rs, int rowNum) throws SQLException {
							Comment comment = new Comment();
							comment.setPhoto_no(rs.getInt("photo_no"));
							comment.setComment_no(rs.getInt("comment_no"));
							comment.setCwriter(rs.getString("cwriter"));
							comment.setComment_content(rs.getString("comment_no"));
							return comment;
						}
					}
				);
			return comment;
		}
				
		// 
		public int update(Comment comment) {
			String sql = "update Comment set photo_no=?, comment_no=?, cwriter=?, comment_content=? where comment_no=?";
			int rows = jdbcTemplate.update(
					sql,
					comment.getPhoto_no(),
					comment.getComment_no(), 
					comment.getCwriter(),
					comment.getComment_content()
				);
			return rows;
		}
		
		// 
		public int delete(int comment_no) {
			String sql = "delete from Comment where comment_no=? and cwirter=uid";
			int rows = jdbcTemplate.update(
					sql,
					comment_no
				);
			return rows;
			}
		}