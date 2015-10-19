package com.team03.albumit.dao;

import java.sql.*;
import java.util.*;

import org.springframework.beans.factory.annotation.*;
import org.springframework.dao.*;
import org.springframework.jdbc.core.*;
import org.springframework.jdbc.support.*;
import org.springframework.stereotype.*;

import com.team03.albumit.dto.*;

@Component
public class MemberDao {
@Autowired 
	private JdbcTemplate jdbcTemplate;

	public Integer insert(Member member) {
		Integer pk = null;
		String sql = "insert into Member ("
				+ " member_email, member_nickname, member_password, "
				+ " member_profile, member_original_file_name, "
				+ " member_filesystem_name, member_content_type) "
				+ " values(?,?,?,?,?,?,?)";

		KeyHolder keyHolder = new GeneratedKeyHolder();
		jdbcTemplate.update(new PreparedStatementCreator() {
			@Override
			public PreparedStatement createPreparedStatement(Connection conn) throws SQLException {
				PreparedStatement pstmt = conn.prepareStatement(sql, new String[] {"uid"});
				pstmt.setString(1,member.getMember_email());
				pstmt.setString(2,member.getMember_nickname() );
				pstmt.setString(3,member.getMember_password());
				pstmt.setString(4,member.getMember_profile());
				pstmt.setString(5,member.getMember_original_file_name());
				pstmt.setString(6,member.getMember_filesystem_name());
				pstmt.setString(7, member.getMember_content_type());
				return pstmt;
	
			}
		},keyHolder);
		Number keyNumber = keyHolder.getKey();
		pk = keyNumber.intValue();
		return pk;
	}

	public Member selectByUid(int uid){
		String sql =" select * from Member where uid = ?";
		Member mem =jdbcTemplate.queryForObject(sql, new Object[]{uid},
				new RowMapper<Member>(){
			@Override
			public Member mapRow(ResultSet rs, int rowNum) throws SQLException {
				Member member = new Member();
				member.setMember_profile(rs.getString("member_profile"));
				member.setMember_password(rs.getString("member_password"));
				member.setMember_original_file_name(rs.getString("member_original_file_name"));
				member.setMember_nickname(rs.getString("member_nickname"));
				member.setMember_filesystem_name(rs.getString("member_filesystem_name"));
				member.setMember_email(rs.getString("member_email"));
				member.setMember_content_type(rs.getString("member_content_type"));
				member.setUid(rs.getInt("uid"));
				return member;
			}
		});
		return mem;
	}
	
	public Member selectByEmail(String email){
		String sql =" select * from Member where member_email = ? ";
		try{ return jdbcTemplate.queryForObject(sql, new Object[]{email},
				new RowMapper<Member>(){
			@Override
			public Member mapRow(ResultSet rs, int rowNum) throws SQLException {
				Member member = new Member();
				member.setMember_content_type(rs.getString("member_content_type"));
				member.setMember_filesystem_name(rs.getString("member_filesystem_name"));
				member.setMember_original_file_name(rs.getString("member_original_file_name"));
				member.setMember_email(rs.getString("member_email"));
				member.setMember_nickname(rs.getString("member_nickname"));
				member.setMember_password(rs.getString("member_password"));
				member.setMember_profile(rs.getString("member_profile"));
				member.setUid(rs.getInt("uid"));
				return member;
				}
		}	
		); }catch (EmptyResultDataAccessException e) {
	           return null;
	       }
	}
	
	public List<Member> selectAll(int uid){
		String sql =" select * from Member where uid=?";
		List<Member> member = jdbcTemplate.query(sql, new Object[]{uid}, new RowMapper<Member>(){

			@Override
			public Member mapRow(ResultSet rs, int rowNum) throws SQLException {
				Member mem = new Member();
				mem.setMember_content_type(rs.getString("member_content_type"));
				mem.setMember_filesystem_name(rs.getString("member_filesystem_name"));
				mem.setMember_original_file_name(rs.getString("member_original_file_name"));
				mem.setMember_email(rs.getString("member_email"));
				mem.setMember_nickname(rs.getString("member_nickname"));
				mem.setMember_password(rs.getString("member_password"));
				mem.setMember_profile(rs.getString("member_profile"));
				mem.setUid(rs.getInt("uid"));
				return mem;
			}
		});
		return member;
	}
	
	public List<Member> selectFriendsMember(int uid) {
		List<Member> list = null;
		String sql = "SELECT * FROM Member WHERE uid "
				+ "IN (SELECT f_uid FROM Friend WHERE uid=?)";
		
		list = jdbcTemplate.query(sql, new Object[] {uid}, new RowMapper<Member>() {
			@Override
			public Member mapRow(ResultSet rs, int rowNum) throws SQLException {
				Member member = new Member();
				member.setMember_content_type(rs.getString("member_content_type"));
				member.setMember_filesystem_name(rs.getString("member_filesystem_name"));
				member.setMember_original_file_name(rs.getString("member_original_file_name"));
				member.setMember_email(rs.getString("member_email"));
				member.setMember_nickname(rs.getString("member_nickname"));
				member.setMember_password(rs.getString("member_password"));
				member.setMember_profile(rs.getString("member_profile"));
				member.setUid(rs.getInt("uid"));
				return member;
			}
		});
		
		return list;
	}

	public Integer memberUpdate(Member member){
		String sql ="update Member set member_profile=?,"
				+ " member_nickname=?, member_filesystem_name=?,"
				+ " member_content_type =?, member_original_file_name=?, member_password=? "
				+ " where uid=?";

		int rows = jdbcTemplate.update(sql,member.getMember_profile(),
				member.getMember_nickname(),member.getMember_filesystem_name(),
				member.getMember_content_type(),member.getMember_original_file_name(),member.getMember_password(),
				member.getUid());

		return rows;
	}
	
	public Integer passwordUpdate(Member member){
		String sql= "update Member set member_password=? where uid = ?";
		
		int rows = jdbcTemplate.update(sql,member.getMember_password(),member.getUid());
		return rows;
	} 
	
	public int delete(int uid){
		String sql= "delete from Member where uid = ?";
		int rows = jdbcTemplate.update(sql,uid);
		return rows;
	}

}
