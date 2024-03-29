package com.team03.albumit.controller;

import java.io.*;
import java.net.*;
import java.util.*;

import javax.servlet.*;
import javax.servlet.http.*;

import org.slf4j.*;
import org.springframework.beans.factory.annotation.*;
import org.springframework.stereotype.*;
import org.springframework.ui.*;
import org.springframework.util.*;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.*;

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
	public String PhotoReg(MultipartFile attach, Model model, HttpServletRequest request) throws IOException {
		
		String originalFilename = attach.getOriginalFilename();
		String saveFilename = request.getRealPath("/resources/uploadfiles/"+originalFilename);
		FileOutputStream fos = new FileOutputStream(saveFilename);
		
		InputStream is = attach.getInputStream();
		
		int byteNo;
		byte[] data = new byte[1024];
		while((byteNo = is.read(data)) != -1) {
			fos.write(data, 0, byteNo);
		}
		fos.flush();
		fos.close();

		model.addAttribute("fileName", originalFilename);
		
		return "/photoReg";
	}
	
	@Autowired
	ServletContext servletContext;
	

	
	//사진 등록 
	@RequestMapping(value="/addPhoto",method=RequestMethod.POST)	
	public String write(Photo photo, HttpSession session) throws IOException {	
		logger.info("addPhoto()");
		
		Member m = (Member)session.getAttribute("loginmember");
		photo.setUid(m.getUid());
	
		//파일 정보 얻기
		ServletContext application = session.getServletContext();
		String dirPath = application.getRealPath("/resources/uploadfiles");
		if(!photo.getAttach().isEmpty()) {
			
			photo.setPhoto_original_file_name(photo.getAttach().getOriginalFilename());
			photo.setPhoto_filesystem_name(System.currentTimeMillis() + "-" + photo.getPhoto_original_file_name());
			photo.setPhoto_content_type(photo.getAttach().getContentType());
			photo.getAttach().transferTo(new File(dirPath + "/" + photo.getPhoto_filesystem_name()));
		}
		
		photoService.addPhoto(photo);
		
		logger.info(photo.getPhoto_place());
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
	
	//저장된 사진 보여주기 
	@RequestMapping("/fileDownload")
	public void fileDownload(int album_no, int photo_no, HttpServletRequest request, HttpServletResponse response) throws IOException {
		//응답헤더(3개: 1)순수파일이름, 2)파일타입, 3)파일크기)
		
		Photo photo = photoService.getPhotoBy(photo_no, album_no);
		
		String originalFilename = photo.getAttach().getOriginalFilename();
		String saveFilename = photo.getPhoto_filesystem_name();
		
		
		
		String fileType = photo.getPhoto_content_type();
		File file = new File(saveFilename);
		long fileSize = file.length();
		
		//1)순수 파일 이름 설정
		String userAgent = request.getHeader("User-Agent");
		if(userAgent.indexOf("MSIE") != -1) {
			originalFilename = URLEncoder.encode(originalFilename, "UTF-8");
		} else {
			originalFilename = new String(
				originalFilename.getBytes("UTF-8"),
				"ISO-8859-1"
			);
		}
		response.setHeader("Content-Disposition", "attachment; filename=\""+originalFilename+"\";");
		//2)파일 타입
		response.setContentType(fileType);
		//3)파일 크기
		response.setContentLength((int)fileSize);
		
		//응답본문(파일의 데이터)
		response.setHeader("Content-Transfer-Encoding", "binary");
		FileInputStream fis = new FileInputStream(file);
		OutputStream os = response.getOutputStream();
		

		
		//how2
		FileCopyUtils.copy(fis, os);
		os.flush();
		os.close();
		fis.close();
	}
	
	
	//사진 큰화면 보여주기
	@RequestMapping("/photoDetail")
	public String photoDetail(
					int photo_no,
					int album_no,
					Model model,
					HttpSession session){
		Member m = (Member)session.getAttribute("loginmember");
		String nickname=m.getMember_nickname();
		photoService.addHitcount(photo_no, album_no);
		Photo photo = photoService.getPhoto(photo_no);
		
	
		List<Comment> commentList =photoService.listComment(photo_no);
		model.addAttribute("commentList", commentList);
		
		model.addAttribute("photo",photo);
		model.addAttribute("nickname",nickname);
		
		return "/photoDetail";
		
	}
	
	
	//사진 수정
	@RequestMapping("/photoUpdateForm")
	public String photoUpdateForm(int photo_no, int album_no, Model model){
		Photo photo = photoService.getPhotoBy(photo_no, album_no);
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
		
		return "redirect:/photoList?album_no="+album_no;
	}
	//사진 검색
	@RequestMapping("/searchPhoto")
	public String searchPhoto(String photo_title, HttpSession session){
		photoService.searchPhoto(photo_title);
		
		return "redirect:/photoList?";
	}
	
	
	//댓글 달기
	@RequestMapping("/addComment")
	public String addComment(@RequestParam("content")String c_content,@RequestParam("photo_no")int photo_no, Photo photo, Model model, HttpSession session){
		System.out.println("로고확인!!!");
		System.out.println("댓글:"+c_content);
		Member m = (Member)session.getAttribute("loginmember");
		System.out.println("&&&&&&&&&&&&&&&first");
		Comment comment =new Comment();
		
		comment.setUid(m.getUid());
		comment.setPhoto_no(photo_no);
		comment.setComment_content(c_content);
		comment.setCwriter(m.getMember_nickname());
		System.out.println("&&&&&&&&&&&&&&&front");
		photoService.addComment(comment);
		System.out.println("&&&&&&&&&&&&&&&back");
		
		List<Comment> commentList =photoService.listComment(comment.getPhoto_no());

		model.addAttribute("comment", comment);
		model.addAttribute("commentList", commentList);
		
		return "comment";
	}
	
	//댓글 지우기
	@RequestMapping("/removeComment")
	public String removeComment(@RequestParam("c_no")int c_no, Model model, HttpSession session){
		Member m = (Member)session.getAttribute("loginmember");
		Comment comment = photoService.getComment(c_no);
		
		
		if(comment.getUid() == m.getUid()){
			photoService.removeComment(c_no);
		
		}else{
			
		}
		
		logger.info("comment_content"+comment.getComment_content());
		
		model.addAttribute(c_no);
		
		return "removedComment";
	}
	
	//댓글 수정
	@RequestMapping("/modifyComment")
	public String modifyComment(Comment comment, Photo photo, HttpSession session){
		photoService.modifyComment(comment);
		
		return "redirect:/photoDetail?photo_no=" + photo.getPhoto_no();
	}
	
	//좋아요 누르기
	@RequestMapping(value="/addLike", method=RequestMethod.POST)
	public String addLike( @RequestParam("photoNo")int photoNo, @RequestParam("albumNo")int albumNo, Model model, HttpSession session){
		System.out.println("좋아요 개수 증가!!!");

		photoService.addLike(albumNo, photoNo);
		
		List<Photo> latest = photoService.showLaPhoto(albumNo);
		List<Photo> popularest =photoService.showLiPhoto(albumNo);
		Photo likePhoto = photoService.getPhotoBy(photoNo, albumNo);
		
		model.addAttribute("laList",latest);
		model.addAttribute("liList",popularest);
		model.addAttribute("photo",likePhoto);
		System.out.println("사진 번호:"+photoNo);
		
		return "likePhoto";
	}


	@RequestMapping(value="/minusLike", method=RequestMethod.POST)
	public String minusLike( @RequestParam("photoNo")int photoNo, @RequestParam("albumNo")int albumNo, Model model, HttpSession session){
		System.out.println("좋아요 개수 감소!!!");
		photoService.minusLike(albumNo, photoNo);
		
		List<Photo> latest = photoService.showLaPhoto(albumNo);
		List<Photo> popularest =photoService.showLiPhoto(albumNo);
		
		Photo UnlikePhoto = photoService.getPhotoBy(photoNo, albumNo);
		model.addAttribute("photo",UnlikePhoto);
		model.addAttribute("laList",latest);
		model.addAttribute("liList",popularest);
		
		System.out.println("사진 번호:"+photoNo);
		
		return "likePhoto";
	}

}
