package com.team03.albumit.service;

import java.util.*;

import org.springframework.beans.factory.annotation.*;
import org.springframework.stereotype.*;

import com.team03.albumit.dao.*;
import com.team03.albumit.dto.*;

@Component
public class AlbumService {

	@Autowired
	private AlbumDao albumDao;
	@Autowired
	private MemberDao memberDao;
	@Autowired
	private SharedAlbumDao sharedAlbumDao;
	@Autowired
	private LikedAlbumDao likedAlbumDao;
	@Autowired
	private ThumbnailDao thumbnailDao;
	
	// C
	public Integer makeAlbum(Album album) {
		Integer albumNo = albumDao.insert(album);
		
		return albumNo;		
	}
	
	// R
	public Map<Album, Thumbnail> showMyAlbumList(Member member) {
		List<Album> list = null;
		
		int uid = member.getUid();
		list = albumDao.selectAlbumByUid(uid);
		String sql = "";
		for(int i = 0; i < list.size(); i++) {
			if(i == list.size()-1) {
				sql += list.get(i).getAlbum_no();
			} else {
				sql += list.get(i).getAlbum_no() + ",";
			}
		}
		List<Thumbnail> thList = thumbnailDao.selectInAlbumList(sql);
		
		Map<Album, Thumbnail> map = new HashMap<Album, Thumbnail>();
		for(int i = 0; i < list.size(); i++) {
			map.put(list.get(i), thList.get(i));
		}
		
		return map;
	}
	
	public Map<Album, Thumbnail> showMySharedAlbumList(Member member) {
		int uid = member.getUid();
		String sql = "a.album_no IN (SELECT b.album_no FROM SharedAlbum b WHERE b.f_uid=?)";
				
		List<Album> list = albumDao.selectAlbumByUid(uid, sql);
		String incluase = "";
		for(int i = 0; i < list.size(); i++) {
			if(i == list.size()-1) {
				incluase += list.get(i).getAlbum_no();
			} else {
				incluase += list.get(i).getAlbum_no() + ",";
			}
		}
		List<Thumbnail> thList = thumbnailDao.selectInAlbumList(incluase);
		
		Map<Album, Thumbnail> map = new HashMap<>();
		for(int i = 0; i < list.size(); i++) {
			map.put(list.get(i), thList.get(i));
		}
		
		return map;
	}
	
	public Map<Album, Thumbnail> showMyLikedAlbumList(Member member) {
		int uid = member.getUid();
		String sql = "a.album_no IN (SELECT b.album_no FROM LikedPhoto b WHERE b.uid=?)";
		
		List<Album> list = albumDao.selectAlbumByUid(uid, sql);
		
		String incluase = "";
		for(int i = 0; i < list.size(); i++) {
			if(i == list.size()-1) {
				incluase += list.get(i).getAlbum_no();
			} else {
				incluase += list.get(i).getAlbum_no() + ",";
			}
		}
		List<Thumbnail> thList = thumbnailDao.selectInAlbumList(incluase);
		
		Map<Album, Thumbnail> map = new HashMap<>();
		for(int i = 0; i < list.size(); i++) {
			map.put(list.get(i), thList.get(i));
		}
		
		return map;
	}
	
	public Map<Album, Thumbnail> showAllAlbumList() {
		List<Album> list = albumDao.selectAllAlbum();
		
		String incluase = "";
		for(int i = 0; i < list.size(); i++) {
			if(i == list.size()-1) {
				incluase += list.get(i).getAlbum_no();
			} else {
				incluase += list.get(i).getAlbum_no() + ",";
			}
		}
		List<Thumbnail> thList = thumbnailDao.selectInAlbumList(incluase);
		
		Map<Album, Thumbnail> map = new HashMap<>();
		for(int i = 0; i < list.size(); i++) {
			map.put(list.get(i), thList.get(i));
		}
		
		return map;
	}
	
	// U
	public int modifyAlbum(Album album) {
		int row = albumDao.update(album);
		
		return row;
	}
	
	
	// D
	public int removeAlbum(List<Album> albumList) {
		int row = 0;
		for(Album album : albumList) {
			int album_no = album.getAlbum_no();
			row += albumDao.delete(album_no);
		}
		
		return row;
	}
	
	// ETC
	//--------------- share an album with friends -------------------//
	public void shareAlbum(int album_no, int owner_uid, Integer[] friends_uid) {
		for(int f : friends_uid) {
			SharedAlbum sharedAlbum = new SharedAlbum();
			sharedAlbum.setAlbum_no(album_no);
			sharedAlbum.setUid(owner_uid);
			sharedAlbum.setF_uid(f);
			sharedAlbumDao.insert(sharedAlbum);
		}
	}
	
	//-------------- Related to liked album ------------------//
	public void likeAlbum(int album_no, Member member) {
		likedAlbumDao.insert(album_no, member.getUid());
	}
	public void unlikeAlbum(LikedAlbum likedAlbum) {
		likedAlbumDao.delete(likedAlbum);
	}
	
	//--------------- show friend who share this album -------------------//
	public List<Member> showShareFriendList(int album_no) {
		List<SharedAlbum> sharedlist = sharedAlbumDao.selectByAlbumNo(album_no);
		
		List<Member> list = new ArrayList<Member>();
		for(SharedAlbum s : sharedlist) {
			Member member = memberDao.selectByUid(s.getF_uid());
			list.add(member);
		}
		
		return list;
	}
	
	//---------------- block friend from shared album -----------------//
	public void blockFriendFromAlbum(int f_uid, int album_no) {
		sharedAlbumDao.delete(album_no, f_uid);
	}
	
	
}
