package com.team03.albumit.controller;

import java.io.*;
import java.util.*;

import javax.servlet.*;
import javax.servlet.http.*;

import org.slf4j.*;
import org.springframework.beans.factory.annotation.*;
import org.springframework.stereotype.*;
import org.springframework.ui.*;
import org.springframework.validation.*;
import org.springframework.web.bind.annotation.*;

import com.team03.albumit.dao.*;
import com.team03.albumit.dto.*;
import com.team03.albumit.service.*;

@Controller
@SessionAttributes("member")

public class MemberController {
	@Autowired

	private MemberService memberService;
	private static final Logger logger = LoggerFactory.getLogger(MemberController.class);

	@RequestMapping(value="/",method=RequestMethod.GET)
	public String loginForm(Member loginMember){
		return "loginForm";
	}

	@RequestMapping(value="/",method=RequestMethod.POST)
	public String login(Member loginMember, Model model,HttpSession session){
		Boolean loginCheck;

		//로그인 성공시 세션객체에 등록하기!
		String email = loginMember.getMember_email();
		String pw = loginMember.getMember_password();
		loginCheck = memberService.login(email,pw);



		if(loginCheck){
			Member loginMem=memberService.findMember(email);
			model.addAttribute("member",loginMem);
			session.setAttribute("loginmember",loginMem);
			Member m =(Member) session.getAttribute("loginmember");
			System.out.println("로그인시 session: "+m.getMember_email());
			
		
			
			logger.info("로그인성공");
			return "redirect:/allAlbumList";
		}
		logger.info("로그인 실패");
		return "redirect:/login";	
	}

	@RequestMapping(value="join", method=RequestMethod.GET)
	public String joinForm(Member m){
		return "joinForm";
	}

	@RequestMapping(value="join", method=RequestMethod.POST)
	public String join(Member joinMember, HttpSession session, BindingResult bindingResult){

		ServletContext application =session.getServletContext();
		String dirPath = application.getRealPath("/resources/image");
		logger.info("Beforefilecheck");


		//회원 가입시 필수 기입사항 확인 
		new JoinValidator().validate(joinMember, bindingResult);
		if(bindingResult.hasErrors()) {
			logger.info("validator");
			return "joinForm";
		}

		//파일 경로 구하기
		if(joinMember.getAttach() !=null){
			String originalFilename = joinMember.getAttach().getOriginalFilename();
			String filesystemName = System.currentTimeMillis() +"-" + originalFilename;
			String contentType = joinMember.getAttach().getContentType();

			if(!joinMember.getAttach().isEmpty()){
				try{
					joinMember.getAttach().transferTo(new File(dirPath+ "/"+ filesystemName));
				}catch(Exception e) {e.printStackTrace();}
			}

			joinMember.setMember_original_file_name(originalFilename);
			joinMember.setMember_filesystem_name(filesystemName);
			joinMember.setMember_content_type(contentType);

			//회원등록 성공하면 로그인폼으로 이동
			if(memberService.register(joinMember)){
				return "redirect:/";
			}
		}


		//회원 가입 실패시 다시 회원가입폼으로 이동
		return "redirect:/join";
	}

	@RequestMapping(value="findPw",method=RequestMethod.GET)
	public String findPwForm(){
		return "";
	}

	@RequestMapping(value="findPw", method=RequestMethod.POST)
	public String findPw(){
		return "";
	}

	@RequestMapping(value="addFriend", method={RequestMethod.POST,RequestMethod.GET})
	public String addFriend(@RequestParam("femail")String femail,HttpSession session ,Model model){
		Member mem=(Member) session.getAttribute("loginmember");
		System.out.println("****Controller****umemberUid:*****"+mem.getUid());
		System.out.println("****Controller****umemberUid:*****"+mem.getMember_email());

		int check= memberService.addFriend(mem, femail);

		if(check ==1){
			logger.info(femail);
			logger.info("notRegister");
			return "notRegister";
		}
		else if(check ==2){
			logger.info("addedFriend");
			return "addedFriend";
		}

		else if(check==3){
			logger.info("친구추가");
			List<FriendList> flist= memberService.friendList(mem);
			model.addAttribute("friends",flist);
			return "confirmAad";
		}

		return "confirmAad";
	}

	@RequestMapping(value="leave",method={RequestMethod.POST,RequestMethod.GET})
	public String leave(HttpSession session){
		Member leaveMember = (Member) session.getAttribute("loginmember");
		boolean leave_check = memberService.leave(leaveMember.getUid());
		if(leave_check){
			System.out.println("컨트롤러-----회원탈퇴 성공!!!!!");
			return "redirect:/";
		}
		System.out.println("컨트롤러-----회원탈퇴 실패!!!!!");
		return "error_leave";
	}

	@RequestMapping(value="modifyProfile", method={RequestMethod.GET,RequestMethod.POST})
	public String modifyProfile(@RequestParam("email")String email,HttpSession session, Model model) {
		Member Modifiedmem = memberService.findMember(email);	
		System.out.println("모디파이 프로필 컨트롤러!!!!!! :"+email);
		model.addAttribute("Modifiedmem",Modifiedmem);
		return "modifyForm_mem";
	}
	@RequestMapping(value="showProfile", method={RequestMethod.GET})
	public String showProfile(@RequestParam("email")String email,Model model)
	{
		Member memProfile = memberService.findMember(email);
		model.addAttribute("memProfile",memProfile);
		return "showProfile";
	}
	
	@RequestMapping(value="modifyMember", method={RequestMethod.POST})
	public String modifyMember(Member member,Model model,HttpSession session){
		System.out.println("컨트롤러 modify:"+member.getMember_email()+"멤버 이메일");
		System.out.println("컨트롤러 modify:"+member.getMember_nickname()+"멤버 닉네임");
		System.out.println("컨트롤러 modify:"+member.getMember_profile()+"멤버 profile");
		System.out.println("컨트롤러 modify:"+member.getUid()+"멤버 uid");
		System.out.println("컨트롤러 modify:"+member.getMember_original_file_name());
		System.out.println("컨트롤러 modify:"+member.getMember_original_file_name());

		ServletContext application =session.getServletContext();
		String dirPath = application.getRealPath("/resources/image");

		//파일 경로 구하기
		if(member.getAttach() !=null){
			String originalFilename = member.getAttach().getOriginalFilename();
			String filesystemName = System.currentTimeMillis() +"-" + originalFilename;
			String contentType = member.getAttach().getContentType();

			if(!member.getAttach().isEmpty()){
				try{
					member.getAttach().transferTo(new File(dirPath+ "/"+ filesystemName));
				}catch(Exception e) {e.printStackTrace();}
			}

			member.setMember_original_file_name(originalFilename);
			member.setMember_filesystem_name(filesystemName);
			member.setMember_content_type(contentType);
			memberService.memberModify(member);
		}
		
		System.out.println("멤버 수정 완료  modify- 컨트롤러!!!");
		return  "redirect:/allAlbumList";
	}
	
	@RequestMapping(value="blockFriend", method={RequestMethod.GET,RequestMethod.POST})
	public String blockFriend (@RequestParam("blockFriend")String blockFriend, Model model, HttpSession session){
		Member member = (Member) session.getAttribute("loginmember");
		System.out.println("blockFriend 컨트롤러에서 :"+blockFriend);
		memberService.block(member, blockFriend);
		return "Blockfriend";
	
	}
	
	@RequestMapping(value="friendList", method={RequestMethod.GET, RequestMethod.POST })
	public String friendList(HttpSession session, Model model){
		Member mem = (Member) session.getAttribute("loginmember");
		System.out.println("친구리스트 컨트롤러에서 유아이디::"+mem.getUid());
		List<FriendList> flist= memberService.friendList(mem);
		model.addAttribute("flist",flist);
	
		return "friendLists";
	}
	@RequestMapping(value="blockPage", method={RequestMethod.GET, RequestMethod.POST })
	public String blockPage(HttpSession session, Model model){
		Member mem = (Member) session.getAttribute("loginmember");
		List<FriendList> flist= memberService.friendList(mem);
		model.addAttribute("flist",flist);
		
		return "friendTable";
	}
	
}


