package com.team03.albumit.service;

import java.util.*;

import org.springframework.beans.factory.annotation.*;
import org.springframework.stereotype.*;

import com.team03.albumit.dao.*;
import com.team03.albumit.dto.*;

@Component
public class PhotoService {
	
	@Autowired
	private PhotoDao photoDao;
	@Autowired
	private SharedPhotoDao sharedPhotoDao;
	@Autowired
	private ReportedPhotoDao reportedPhotoDao;
	@Autowired
	private ThumbnailDao thumbnailDao;
	@Autowired
	private CommentDao commentDao;
	
	//---------------- 사진 기본------------------------------
	//사진등록
	public void addPhoto(Photo photo) {
		photoDao.insert(photo);
	}
	
	//사진 수정
	public void modifyPhoto(Photo photo) {
		photoDao.update(photo);
	}
	
	//사진삭제
	public void removePhoto(int photo_no, int album_no) {
		
		//퍼온 사진인지 확인하기위해  삭제할 사진 가져옴
		List<SharedPhoto> sharedphoto = sharedPhotoDao.selectByAlbumPhotoNo(album_no, photo_no);
		
		//null이면 지울 사진이 퍼온사진이 아님 --> 원본사진임
		if(sharedphoto == null){
			//원본사진을 퍼갔는지 확인
			//퍼간사진이 없으면 원본사진 삭제
			if(sharedPhotoDao.selectByPhotoNo(photo_no) == null){
				photoDao.delete(photo_no);
			}else{//퍼간사진이 있을때
				
				Photo photo = photoDao.selectByPk(photo_no);
				//퍼간사진들을 list로 가져옴
				List<SharedPhoto> sharedphoto2 = sharedPhotoDao.selectByPhotoNo(photo_no);
				//list중 0번째 uid를 가져와서 원본사진의 uid로 만듬ㄱ
				photoDao.updateUid(photo, sharedphoto2.get(0).getUid());
			}
			
		}else{//퍼간사진 사진임 --> 그냥 삭제
			
			sharedPhotoDao.delete(photo_no, album_no);
		}
		
	}
	
	//사진 퍼가기
	public void sharePhoto(SharedPhoto sharedPhoto){
		sharedPhotoDao.insert(sharedPhoto);
	}
	
	//사진 옮기기
	public void movePhoto(Photo photo) {
		photoDao.updateAlbum(photo);
	}
	//조회수 증가
	public void addHitcount(int photo_no, int album_no) {
		List<SharedPhoto> sharedphoto = sharedPhotoDao.selectByAlbumPhotoNo(album_no, photo_no);
		
		if(sharedphoto == null){
			photoDao.updateHitcount(photo_no);
			
		}else{
			
			sharedPhotoDao.updateHitcount(photo_no, album_no);
		}
	}	
	
	//사진 좋아요 증가
	public void addLike(int photo_no, int album_no) {
		List<SharedPhoto> sharedphoto = sharedPhotoDao.selectByAlbumPhotoNo(album_no, photo_no);
		
		if(sharedphoto == null){
			photoDao.updateLike(photo_no);
			
		}else{
			
			sharedPhotoDao.updateLike(photo_no, album_no);
		}
	}
	//사진신고
	public void reportPhoto(ReportedPhoto reportedPhoto){
		reportedPhotoDao.insert(reportedPhoto);		
	}
	
	//-----------------------사진 보기-------------------------------------
	
	
	//사진목록보기 (최신순 정렬)
	public List<Photo> showLaPhoto(int album_no){
		List<Photo> list1 = photoDao.selectByAlbumNo(album_no);
		List<SharedPhoto> list2 = sharedPhotoDao.selectByAlbumNo(album_no);
		
		for(SharedPhoto sharedPhoto : list2){
			Photo photo = photoDao.selectByPk(sharedPhoto.getPhoto_no());
			photo.setPhoto_date(sharedPhoto.getShare_date());
			photo.setAlbum_no(sharedPhoto.getAlbum_no());
			photo.setPhoto_like(sharedPhoto.getShare_like());
			photo.setPhoto_hitcount(sharedPhoto.getShare_hitcount());
			list1.add(photo);
		}
		
		Collections.sort(list1, new Comparator<Photo>() {
			@Override
			public int compare(Photo o1, Photo o2) {
				return o2.getPhoto_date().compareTo(o1.getPhoto_date());
			}
		});
		
		return list1;
	}
	
	//사진목록보기 (인기순 정렬)
	public List<Photo> showLiPhoto(int album_no){
		List<Photo> list1 = photoDao.selectByAlbumNo(album_no);
		List<SharedPhoto> list2 = sharedPhotoDao.selectByAlbumNo(album_no);
		
		for(SharedPhoto sharedPhoto : list2){
			Photo photo = photoDao.selectByPk(sharedPhoto.getPhoto_no());
			photo.setPhoto_date(sharedPhoto.getShare_date());
			photo.setAlbum_no(sharedPhoto.getAlbum_no());
			photo.setPhoto_like(sharedPhoto.getShare_like());
			photo.setPhoto_hitcount(sharedPhoto.getShare_hitcount());
			list1.add(photo);
		}

		Collections.sort(list1, new Comparator<Photo>(){
			@Override
			public int compare(Photo p1, Photo p2) {
				if(p1.getPhoto_like()<p2.getPhoto_like()) {
					return 1;
				} else if(p1.getPhoto_like()==p2.getPhoto_like()) {
					return 0;
				} else {
					return -1;
				}
			}
		});
		
		return list1;
	}
	
	//사진 상세 보기
	public Photo getPhoto(int photo_no){
		Photo photo= photoDao.selectByPk(photo_no);
		
		return photo;
	}

	
	//사진등록
	public void add(Photo photo) {
		photoDao.insert(photo);
	}
	
	//사진삭제
	public void remove(int photo_no, int album_no) {
		
		List<SharedPhoto> sharedphoto = sharedPhotoDao.selectByAlbumPhotoNo(album_no, photo_no);
		
		
		if(sharedphoto.size() == 0){
			
			List<SharedPhoto> list= sharedPhotoDao.selectByPhotoNo(photo_no);
			if(list.size() == 0){
				photoDao.delete(photo_no);
			}else{
				
				Photo photo = photoDao.selectByPk(photo_no);
				List<SharedPhoto> sharedphoto2 = sharedPhotoDao.selectByPhotoNo(photo_no);
				photoDao.updateUid(photo, sharedphoto2.get(0).getUid());
			}
	
		}else{
			
			sharedPhotoDao.delete(photo_no, album_no);
		}
		
	}

	//퍼간 사진 보기
	public void showShared(int album_no,int photo_no){
		sharedPhotoDao.selectByAlbumPhotoNo(album_no, photo_no);
	}
	
	//신고된 사진(관리자)
	public void showreported(){
		reportedPhotoDao.selectAll();
	}
	
	//---------------------댓글-----------------------------
	//댓글달기
	public void addComment(Comment comment){
		commentDao.insert(comment);
	}
	
	//댓글보기
	public List<Comment> listComment(int photo_no){
		List<Comment> comment = commentDao.selectByPN(photo_no);
		return comment;
	}
	
	//댓글삭제
	public void removeComment(int comment_no){
		commentDao.delete(comment_no);
	}
	
	//댓글 수정
	public void modifyComment(Comment comment){
		commentDao.update(comment);
	}
	
	
	
}
