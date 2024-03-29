package com.team03.albumit.controller;

import java.util.*;

import javax.servlet.http.*;

import org.slf4j.*;
import org.springframework.beans.factory.annotation.*;
import org.springframework.stereotype.*;
import org.springframework.ui.*;
import org.springframework.web.bind.annotation.*;

import com.team03.albumit.dto.*;
import com.team03.albumit.service.*;

@Controller
@SessionAttributes("member")
public class AlbumController {

	private static final Logger logger = LoggerFactory.getLogger(AlbumController.class);
	
	@Autowired
	private AlbumService albumService;
	@Autowired
	private MemberService memberService;
	
	@RequestMapping("/main")
	public String main(@ModelAttribute("member") Member member, Model model,HttpSession session) {
		//친구목록 모델에 추가하기!!
		List<FriendList> friends = memberService.friendList(member);
		session.setAttribute("friendList", friends);
		
		return "main";
	}

	@RequestMapping("/allAlbumList")
	public String allAlbumList(@ModelAttribute("member") Member member, Model model) {
		Map<Album, Thumbnail> albumList = albumService.showAllAlbumList();
		model.addAttribute("albumList", albumList);
		
		String curAlbumList = "allAlbumList";
		model.addAttribute("curAlbumList", curAlbumList);
		
		return "albumList";
	}
	
	@RequestMapping("/myAlbumList")
	public String myAlbumList(@ModelAttribute("member") Member member, Model model) {
		Map<Album, Thumbnail> albumList = albumService.showMyAlbumList(member);
		model.addAttribute("albumList", albumList);
		
		String curAlbumList = "myAlbumList";
		model.addAttribute("curAlbumList", curAlbumList);
		
		return "albumList";
	}
	
	@RequestMapping("/sharedAlbumList")
	public String sharedAlbumList(@ModelAttribute("member") Member member, Model model) {
		Map<Album, Thumbnail> albumList = albumService.showMySharedAlbumList(member);
		model.addAttribute("albumList", albumList);
		
		String curAlbumList = "sharedAlbumList";
		model.addAttribute("curAlbumList", curAlbumList);
		
		return "albumList";
	}
	
	@RequestMapping("/likedAlbumList")
	public String likedAlbumList(@ModelAttribute("member") Member member, Model model) {
		Map<Album, Thumbnail> albumList = albumService.showMyLikedAlbumList(member);
		model.addAttribute("albumList", albumList);
		
		String curAlbumList = "likedAlbumList";
		model.addAttribute("curAlbumList", curAlbumList);
		
		return "albumList";
	}
	
	@RequestMapping("/makeAlbum")
	public String makeAlbum(Album album, MemberList memberList, Model model) {
		boolean success = false;
		Integer album_no = albumService.makeAlbum(album);
		if(album_no != null) success = true;
		if(memberList != null) {
			List<Integer> friends_uid = new ArrayList<>();
			for(Member m : memberList.getMemberList()) {
				friends_uid.add(m.getUid());
			}
			albumService.shareAlbum(album_no, album.getUid(), friends_uid.toArray(new Integer[0]));
		}
		
		if(success) {
			model.addAttribute("message", "Success to create an Album!");
			return "ajax_ok";
		} else {
			model.addAttribute("message", "Fail to create an album");
			return "ajax_fail";
		}
	}
	
	@RequestMapping("/showFriendsList")
	public String showFriendsList(Member member, Model model) {
		List<Member> friendsList = memberService.showMyFriendsList(member);
		model.addAttribute("friendsList", friendsList);
		
		return "showFriendsList_json";
	}
	
	@RequestMapping("/searchAlbum")
	public String searchAlbum(String album_name, Model model){
		List<Album> albumList = albumService.searchAlbum(album_name);
		model.addAttribute("albumList",albumList);
		
		return "albumList";
	}
	
	@RequestMapping("/deleteAlbum")
	public String deleteAlbum(int album_no, String album_name, Model model) {
		int row = albumService.removeOneAlbum(album_no);
		
		if(row != 0) {
			model.addAttribute("message", "Successfully deleted an album [" + album_name +"]");
			return "ajax_ok";
		} else {
			model.addAttribute("message", "Failed to delete an album...");
			return "ajax_fail";
		}
	}
	
	@RequestMapping("/modifyAlbum")
	public String modifyAlbum(Album album, Model model) {
		int row = albumService.modifyAlbum(album);
		
		if(row != 0) {
			model.addAttribute("message", "Successfully modified an album!");
			return "ajax_ok";
		} else {
			model.addAttribute("message", "Failed to modify an album...");
			return "albumList";
		}
	}
}
