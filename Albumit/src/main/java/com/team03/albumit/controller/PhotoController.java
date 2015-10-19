package com.team03.albumit.controller;

import java.io.*;
import java.util.*;

import javax.servlet.*;
import javax.servlet.http.*;

import org.slf4j.*;
import org.springframework.beans.factory.annotation.*;
import org.springframework.stereotype.*;
import org.springframework.ui.*;
import org.springframework.web.bind.annotation.*;

import com.team03.albumit.dto.*;
import com.team03.albumit.service.*;

@Controller
public class PhotoController {
	private static final Logger logger = LoggerFactory.getLogger(PhotoController.class);
	
	@Autowired
	private PhotoService photoService;
	
	//사진 등록
	@RequestMapping(value="/addPhoto",method=RequestMethod.GET)
	public String PhotoWriteForm(int album_no, Model model) {
		model.addAttribute("album_no",album_no);
		
		
		
		return "/photoWriteForm";
	}
	
	//사진 미리보기 등록
		@RequestMapping(value="/preaddPhoto",method=RequestMethod.POST)
		public String PhotoWriteForm2(Photo photo, Model model, HttpSession session) {
			Member m = (Member)session.getAttribute("loginmember");
			photo.setUid(m.getUid());
			
			//파일 정보 얻기
			ServletContext application = session.getServletContext();
			String dirPath = application.getRealPath("/resources/uploadfiles");
			if(photo.getAttach() != null) {
				String photo_original_file_name = photo.getAttach().getOriginalFilename();
				String photo_filesystem_name = System.currentTimeMillis() + "-" + photo_original_file_name;
				String photo_content_type = photo.getAttach().getContentType();
				if(!photo.getAttach().isEmpty()) {	
					//파일에 저장하기
					try {
						photo.getAttach().transferTo(new File(dirPath + "/" + photo_filesystem_name));
					} catch (Exception e) { e.printStackTrace(); }
				}
				photo.setPhoto_original_file_name(photo_original_file_name);
				photo.setPhoto_filesystem_name(photo_filesystem_name);
				photo.setPhoto_content_type(photo_content_type);
			}
			
			photoService.addPhoto(photo);
			
			return "/photoWriteForm";
		}
	
	//사진 등록 
	@RequestMapping(value="/addPhoto",method=RequestMethod.POST)	
	public String write(Photo photo, HttpSession session) {	
		logger.info("addPhoto()");
		
		Member m = (Member)session.getAttribute("loginmember");
		photo.setUid(m.getUid());
	
		
		//파일 정보 얻기
		ServletContext application = session.getServletContext();
		String dirPath = application.getRealPath("/resources/uploadfiles");
		if(photo.getAttach() != null) {
			String photo_original_file_name = photo.getAttach().getOriginalFilename();
			String photo_filesystem_name = System.currentTimeMillis() + "-" + photo_original_file_name;
			String photo_content_type = photo.getAttach().getContentType();
			if(!photo.getAttach().isEmpty()) {	
				//파일에 저장하기
				try {
					photo.getAttach().transferTo(new File(dirPath + "/" + photo_filesystem_name));
				} catch (Exception e) { e.printStackTrace(); }
			}
			photo.setPhoto_original_file_name(photo_original_file_name);
			photo.setPhoto_filesystem_name(photo_filesystem_name);
			photo.setPhoto_content_type(photo_content_type);
		}
		
		photoService.addPhoto(photo);
		
		return "redirect:/photoList?album_no="+photo.getAlbum_no();
	}
	
	//사진 보여주기
	@RequestMapping("/photoList")
	public String PhotoList(
			int album_no,
			Model model,
			HttpSession session) {
		
		logger.info("photoList");
		
		List<Photo> laList = photoService.showLaPhoto(album_no);
		List<Photo> liList = photoService.showLiPhoto(album_no);
		logger.info("album_no", album_no);
		
		model.addAttribute("laList",laList);
		model.addAttribute("liList",liList);
		model.addAttribute("album_no", album_no);
		
	
		
		return "/photoList";
	

	}
	
	//사진 큰화면 보여주기
	@RequestMapping("/photoDetail")
	public String photoDetail(
					int photo_no,
					int album_no,
					Model model,
					HttpSession session){
		
		photoService.addHitcount(photo_no, album_no);
		Photo photo = photoService.getPhoto(photo_no);
		model.addAttribute("photo",photo);
		return "/photoDetail";
		
	}
	
	
	//사진 수정
	@RequestMapping("/photoUpdateForm")
	public String photoUpdateForm(int photo_no, Model model){
		Photo photo = photoService.getPhoto(photo_no);
		model.addAttribute("photo",photo);
		return "/photoUpdateForm";
		
	}
	//사진 수정
	@RequestMapping("/updatePhoto")
	public String updatePhoto(Photo photo, HttpSession session){
		photoService.modifyPhoto(photo);
		
		return "redirect:/photoDetail?photo_no="+photo.getPhoto_no()+"&&album_no="+photo.getAlbum_no();
	}
	
	//사진 옮기기
	@RequestMapping("/movePhoto")
	public String movePhoto(Photo photo, HttpSession session){
		photoService.movePhoto(photo);
		
		return "redirect:/movePhoto?album_no="+photo.getAlbum_no();
	}
	
	//사진 지우기
	@RequestMapping("/removePhoto")
	public String removePhoto(int photo_no, int album_no, HttpSession session){
		photoService.removePhoto(photo_no, album_no);
		
		return "redirect:/photoList";
	}
	
	//댓글 달기
	@RequestMapping("/addComment")
	public String addComment(Comment comment,Photo photo, HttpSession session){
		photoService.addComment(comment);
		
		return "redirect:/photoDetail?photo_no=" + photo.getPhoto_no();
	}
	//댓글 지우기
	@RequestMapping("/removeComment")
	public String removeComment(int comment_no, HttpSession session){
		photoService.removeComment(comment_no);
		
		return "redirect:/photoList";
	}
	
	//댓글 수정
	@RequestMapping("/modifyComment")
	public String modifyComment(Comment comment, Photo photo, HttpSession session){
		photoService.modifyComment(comment);
		
		return "redirect:/photoDetail?photo_no=" + photo.getPhoto_no();
	}
	

	
}
