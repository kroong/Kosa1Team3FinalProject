package com.team03.albumit.controller;

import java.util.*;

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
	
	@RequestMapping("/allAlbumList")
	public String allAlbumList(@ModelAttribute("member") Member member, Model model) {
		Map<Album, Thumbnail> albumList = albumService.showAllAlbumList();
		model.addAttribute(albumList);
		
		//친구목록 모델에 추가하기!!
		List<FriendList> friends = memberService.friendList(member);
		//System.out.println("컨트롤러에서 친구목록: "+friends.get(0).getMember_email()+"  ->이게 d이여야 한다!");
		model.addAttribute("friendList", friends);
		return "albumList";
	}
	
	@RequestMapping("/myAlbumList")
	public String myAlbumList(@ModelAttribute("member") Member member, Model model) {
		Map<Album, Thumbnail> albumList = albumService.showMyAlbumList(member);
		model.addAttribute(albumList);
		
		return "albumList";
	}
	
	@RequestMapping("/sharedAlbumList")
	public String sharedAlbumList(@ModelAttribute("member") Member member, Model model) {
		Map<Album, Thumbnail> albumList = albumService.showMySharedAlbumList(member);
		model.addAttribute(albumList);
		
		return "albumList";
	}
	
	@RequestMapping("/likedAlbumList")
	public String likedAlbumList(@ModelAttribute("member") Member member, Model model) {
		Map<Album, Thumbnail> albumList = albumService.showMyLikedAlbumList(member);
		model.addAttribute(albumList);
		
		return "albumList";
	}
	
	@RequestMapping("/makeAlbum")
	public String makeAlbum(Album album, MemberList memberList) {
		Integer album_no = albumService.makeAlbum(album);
		// TODO: when owner want to make shared album which is shared with friends at creation
		if(memberList != null) {
			List<Integer> friends_uid = new ArrayList<>();
			for(Member m : memberList.getMemberList()) {
				friends_uid.add(m.getUid());
			}
			albumService.shareAlbum(album_no, album.getUid(), friends_uid.toArray(new Integer[0]));
		}
		
		return "redirect:/myAlbumList";
	}
	
	@RequestMapping("/showFriendsList")
	public String showFriendsList(Member member, Model model) {
		List<Member> friendsList = memberService.showMyFriendsList(member);
		model.addAttribute("friendsList", friendsList);
		
		return "showFriendsList_json";
	}
}
