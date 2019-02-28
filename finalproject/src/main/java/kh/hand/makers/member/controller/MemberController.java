package kh.hand.makers.member.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.servlet.ModelAndView;

import kh.hand.makers.member.model.service.MemberService;
import kh.hand.makers.member.model.vo.Member;



@SessionAttributes("member")
@Controller
public class MemberController {
	

	private Logger logger=LoggerFactory.getLogger(MemberController.class);
	@Autowired
	MemberService service;
	@Autowired
	BCryptPasswordEncoder pwEncoder;
	
	
	@RequestMapping("/member/memberEnroll.do")
	public String memberEnroll()
	{
		return "member/memberEnroll";
	}
	
	@RequestMapping("/member/memberEnrollEnd.do")
	public String memberEnrollEnd(Member m, Model model)
	{
		
		System.out.println(m);
		String rawPw=m.getMemberPwd();
		System.out.println("암호화전 " +rawPw);
		//System.out.println("암호화후 "+pwEncoder.encode(rawPw));		
		m.setMemberPwd(pwEncoder.encode(rawPw));
		int result=service.memberEnroll(m);
		String msg="";
		String loc="/";
		if(result>0)
		{
			msg="회원가입을 성공하였습니다.";
		}
		else {
			msg="회원가입 실패하였습니다.";
		}
		model.addAttribute("msg",msg);
		model.addAttribute("loc",loc);
		return "common/msg"; 
		
	}
	
	@RequestMapping("/member/memberLogin.do")
	public String memberLogin()
	{
		return "member/memberLogin";
	}
	
	@RequestMapping("/member/memberLoginEnd.do")
	//public String login(String userId, String password, Model model)
	public ModelAndView memberLoginEnd(Member m)
	{
		ModelAndView mv=new ModelAndView();
		System.out.println("m : "+m);
		logger.debug("로그인 제대로 들어옴!");
		logger.debug("파라미터확인 memberId : "+m.getMemberId()+" memberPwd : "+m.getMemberPwd());

		Member result = service.memberLogin(m.getMemberId());
		System.out.println("result : "+result);
		logger.debug("로그인결과 : "+result);
		String msg="";
		String loc="/";
		if(result!=null)
		{
			if(pwEncoder.matches(m.getMemberPwd(), result.getMemberPwd()))
			{
				msg="로그인성공";
		
				mv.addObject("member",result);
			}
			else
			{
				msg="패스워드가 일치하지 않습니다.";
				loc="/member/memberLogin.do";
			}
		}
		else {
			msg="아이디가 존재하지 않습니다.";
			loc="/member/memberLogin.do";
		}

		mv.addObject("msg",msg);
		mv.addObject("loc",loc);
		mv.setViewName("common/msg");

		return mv;
	}
	
	@RequestMapping("/member/memberLogout.do")
	public String memberLogout(SessionStatus status)
	{
		//SessionAttributes등록 로그인이면 : sessionStatus객체의 
		//setComplete()매소드 이용로그아웃 처리
		//HttpSession이용 로그인이면 : HttpSession.invalide();
		if(!status.isComplete())
		{
			status.setComplete();
		}
		return "redirect:/index.jsp";
	}
	
	@RequestMapping("/member/myPage.do")
	public String memberMyPage()
	{
		return "member/myPage";
	}
	
	@RequestMapping("/member/adminPage.do")
	public String adminMyPage()
	{
		return "member/adminPage";
	}
}
