package kh.hand.makers.member.controller;

import java.io.UnsupportedEncodingException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.servlet.ModelAndView;

import kh.hand.makers.common.PageFactory;
import kh.hand.makers.member.model.service.MemberService;
import kh.hand.makers.member.model.vo.Member;
import kh.hand.makers.order.model.vo.Delivery;
import kh.hand.makers.shop.model.service.ShopService;
import kh.hand.makers.shop.model.vo.Brand;



@SessionAttributes("member")
@Controller
public class MemberController {
	

	private Logger logger=LoggerFactory.getLogger(MemberController.class);
	@Autowired
	MemberService service;
	@Autowired
	BCryptPasswordEncoder pwEncoder;
	@Autowired
	ShopService shopService;
	
	@RequestMapping("/member/checkId.do")
	/*public void checkId(String userId,HttpServletResponse response) throws IOException
	{
		logger.debug("중복체크");
		boolean isId=service.checkId(userId)==0?false:true;
		response.getWriter().print(isId);
	}*/
	public ModelAndView checkId(String memberId, ModelAndView mv) throws UnsupportedEncodingException
	{
		Map map=new HashMap();
		boolean isId=service.checkId(memberId)==0?false:true;
		map.put("isId", isId);
		
		System.out.println("checkId~~~~~~~~~~~");
		
		mv.addAllObjects(map);
		mv.setViewName("jsonView");
		
		return mv;	
	}
	
	@RequestMapping("/member/memberEnroll.do")
	public String memberEnroll()
	{
		return "member/memberEnroll";
	}
	
	@RequestMapping("/member/memberEnrollEnd.do")
	public String memberEnrollEnd(Member m, Model model)
	{
		
		System.out.println("m이다" + m);
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
	public ModelAndView memberMyPage(HttpSession session)
	{	
		// 판매회원일 경우 등록된 브랜드 목록 가져옴
		String memberNo = ((Member)session.getAttribute("member")).getMemberNo();
		ModelAndView mv=new ModelAndView();
		List<Brand> list = shopService.selectBrandList(memberNo);
		mv.addObject("brandList", list);
		System.out.println("브랜드 갯수: "+list.size());
		
		if(list.size() == 0) {
			System.out.println("있어? : ");
		}else {
			System.out.println("없어:");
		}
		
		mv.addObject("listSize",list.size());
		
		mv.setViewName("member/myPage");
		return mv;
	}
	
	@RequestMapping("/member/adminPage.do")
	public String adminMyPage()
	{
		return "member/adminPage";
	}
	
	@RequestMapping("/member/adminBrandCloseManage.do")
	public ModelAndView brandCloseList(
			@RequestParam(value="cPage", 
			required=false, defaultValue="0") int cPage
			)
	{
		int numPerPage=5;
		ModelAndView mv=new ModelAndView();
		int brandCloseCount=service.selectBrandCloseCount();
		List<Map<String,String>> brandCloseList = service.selectBrandCloseList(cPage,numPerPage);
		mv.addObject("pageBar",PageFactory.getPageBar(brandCloseCount, cPage, numPerPage, "/spring/board/boardList"));
		mv.addObject("brandCloseList", brandCloseList);
		mv.setViewName("admin/brandCloseList");
		return mv;
	}
	
	@RequestMapping("/member/wishList.do")
	public String wishList()
	{
		return "member/wishList";
	}
	
	//member/memberUpdateEnd.do
	@RequestMapping("/member/memberUpdate.do")
	public String memberUpdate()
	{
		return "member/memberInfo";
	}
	@RequestMapping("/member/memberUpdateEnd.do")
	public ModelAndView memberUpdateEnd(Member m)
	{
		ModelAndView mv=new ModelAndView();
		System.out.println("m : "+m);
		logger.debug("회원정보 수정");
		
		int result = service.memberUpdate(m);
	
		String msg="";
		String loc="/";
		if(result > 0)
		{
			msg="회원정보 수정이 완료되었습니다.";	

		}
		else {
			msg="회원정보 수정에 실패하였습니다.";
			loc="/member/myPage.do";
		}

		mv.addObject("msg",msg);
		mv.addObject("loc",loc);
		mv.setViewName("common/msg");

		return mv;
	}	
	
	@RequestMapping("/member/manageOrder.do")
	public String manageOrder()
	{
		return "member/manageOrder";
	}
	@RequestMapping("/member/memberWithdrawal.do")
	public String memberWithdrawal()
	{
		return "member/memberWithdrawal";
	}
	
	@RequestMapping("/member/checkPasswordEnd.do")
	public ModelAndView checkPasswordEnd(int checkNo, Member m)
	{
		logger.debug("회원탈퇴로 들어옴");
		ModelAndView mv=new ModelAndView();	
		Member result = service.memberLogin(m.getMemberId());
		String memberId = m.getMemberId();
		String msg="";
		String loc="/";
		if(result!=null)
		{
			if(pwEncoder.matches(m.getMemberPwd(), result.getMemberPwd()))
			{
				msg="패스워드가 일치합니다.";
				if(checkNo == 0) {
					loc="/member/memberWithdrawalEnd.do";
				}else if(checkNo == 1) {
					loc="/member/changePassword.do";
				}else if(checkNo == 2) {
					loc="/member/memberUpdate.do";
				}else if(checkNo == 3) {
					loc="/member/enrollLocationView.do";
				}

			}
			else
			{
				msg="패스워드가 일치하지 않습니다.";
				loc="/member/checkPassword.do?checkNo="+checkNo;
			}
		}
		else {
			msg="패스워드가 일치하지 않습니다.";
			loc="/member/checkPassword.do?checkNo="+checkNo;
		}
		mv.addObject("msg",msg);
		mv.addObject("loc",loc);
		mv.setViewName("common/msg");

		return mv;
	}
	

	
	
	@RequestMapping("/member/memberWithdrawalEnd.do")
	public String memberWithdrawalEnd()
	{		
		return "member/memberWithdrawalEnd";
	}
	
	@RequestMapping("/member/memberWithdrawalEnds.do")
	public ModelAndView memberWithdrawalEnds(String memberNo, SessionStatus status)
	{		
		logger.debug("회원탈퇴 대상 : "+memberNo);
		ModelAndView mv=new ModelAndView();	
		int result = service.memberWithdrawal(memberNo);
		String msg="";
		String loc="/";

		if(result>0)
		{
			msg="회원탈퇴가 완료되었습니다.";
			if(!status.isComplete())
			{
				status.setComplete();
			}			
			
		}
		else {
			msg="회원탈퇴에 실패하였습니다.";
			loc="/member/myPage.do";
		}
		mv.addObject("msg",msg);
		mv.addObject("loc",loc);
		mv.setViewName("common/msg");

		return mv;
	}
	
	
	@RequestMapping("/member/checkPassword.do")
	public ModelAndView checkPassword(int checkNo)
	{
		ModelAndView mv=new ModelAndView();	
		logger.debug("체크NO: "+checkNo);
		mv.addObject("checkNo",checkNo);
		mv.setViewName("/member/checkPassword");

		return mv;
	}
	
	@RequestMapping("/member/changePassword.do")
	public String changePassword()
	{
		return "member/changePassword";
	}
	
	@RequestMapping("/member/changePasswordEnd.do")
	public ModelAndView changePasswordEnd(Member m)
	{
		ModelAndView mv=new ModelAndView();		
		logger.debug("패스워드 변경");
		logger.debug("Member: "+m);
		m.setMemberPwd(pwEncoder.encode(m.getMemberPwd()));
		int result = service.memberPwdUpdate(m);
	
		String msg="";
		String loc="/";
		if(result > 0)
		{
			msg="비밀번호 변경이 완료되었습니다.";	
			loc="/member/myPage.do";
		}
		else {
			msg="비밀번호 변경에 실패했습니다.";
			loc="/member/changePassword.do";
		}

		mv.addObject("msg",msg);
		mv.addObject("loc",loc);
		mv.setViewName("common/msg");

		return mv;
	}
	
	@RequestMapping("/member/enrollLocationView.do")
	public ModelAndView enrollLocationView(Member m)
	{
		ModelAndView mv=new ModelAndView();		
		List<Delivery> deliveryList=service.selectDeliveryList(m.getMemberNo());
		mv.addObject("deliveryList",deliveryList);
		mv.setViewName("member/enrollLocationView");
		return mv;
	}
	
	@RequestMapping("/member/enrollLocation.do")
	public String enrollLocation()
	{
		
		return "/member/enrollLocation";
	}
	
	@RequestMapping("/member/enrollLocationEnd.do")
	public ModelAndView enrollLocationEnd(Member m, Delivery delivery)
	{
		ModelAndView mv=new ModelAndView();
		delivery.setMemberNo(m.getMemberNo());
		//System.out.println("암호화후 "+pwEncoder.encode(rawPw));		
		int result=service.enrollLocation(delivery);
		String msg="";
		String loc="/";
		if(result>0)
		{
			msg="배송지 등록에 성공했습니다.";
			loc="/member/myPage.do";
		}
		else {
			msg="배송지 등록에 실패했습니다.";
			loc="/member/enrollLocation.do";
		}
		mv.addObject("msg",msg);
		mv.addObject("loc",loc);
		mv.setViewName("common/msg");
		
		return mv; 
	}
	
	
	@RequestMapping("/member/searchId.do")
	public String searchId()
	{
		return "member/findMemberId";
	}
	@RequestMapping("/member/searchPassword.do")
	public String searchPassword()
	{
		return "member/searchPassword";
	}
	
}
