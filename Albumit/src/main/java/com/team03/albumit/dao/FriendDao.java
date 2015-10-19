package com.team03.albumit.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.*;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.PreparedStatementCreator;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.jdbc.support.*;
import org.springframework.stereotype.Component;

import com.team03.albumit.dto.*;

@Component
public class FriendDao {
	@Autowired
	private JdbcTemplate jdbcTemplate;

	public Integer insert(Member umember, int fUid){
		Integer pk = null;
		String sql = "insert into Friend ( f_uid, uid, friend_block) values(?,?,?)";
		System.out.println("********umemberUid:*****"+umember.getUid());
		pk = jdbcTemplate.update(new PreparedStatementCreator() {
			@Override
			public PreparedStatement createPreparedStatement(Connection conn) throws SQLException {
				PreparedStatement pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1,fUid);
				pstmt.setInt(2, umember.getUid());
				pstmt.setBoolean(3,true);
				return pstmt;
			}
		});
	return pk;
	}


	public Integer update(Member umember,Member fmember, Boolean block){
		String sql="update Friend set frined_block=? where uid =? and f_uid =?";
		int rows = jdbcTemplate.update(sql,block,umember.getUid(),fmember.getUid());
		return rows;
	}

	
	public Integer delete(Member umember,Member fmember){
		String sql ="delete from Friend where uid=? and f_uid=?";
		int rows =jdbcTemplate.update(sql,umember.getUid(),fmember.getUid());
		return rows;

	}

	public List<Friend> selectAll(Member umember){
		String sql ="select * from Friend where uid=?  ";
		List<Friend> friends =jdbcTemplate.query(sql, new Object[]{umember.getUid()},
				new RowMapper<Friend>(){
			@Override
			public Friend mapRow(ResultSet rs, int rowNum) throws SQLException {
				Friend fr = new Friend();
				fr.setF_uid(rs.getInt("f_uid"));
				fr.setUid(rs.getInt("uid"));
				fr.setFrined_block(rs.getBoolean("friend_block"));
				return fr;
			}
		});
		return friends;
	}

	public Friend select(Member umember,int fuid){
		String sql = "select * from Friend where uid=? and f_uid=?";
		try{ return jdbcTemplate.queryForObject(sql, new Object[]{umember.getUid(),fuid},
				new RowMapper<Friend>(){
			@Override
			public Friend mapRow(ResultSet rs, int rowNum) throws SQLException {
				Friend friends = new Friend();
				friends.setF_uid(rs.getInt("f_uid"));
				friends.setUid(rs.getInt("uid"));
				friends.setFrined_block(rs.getBoolean("friend_block"));
				return friends;
			}
		}); }catch(EmptyResultDataAccessException e) {
	           return null;
	       }
	
	}	
}
	
	