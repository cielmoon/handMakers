package kh.hand.makers.shop.controller;

import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletRequest;
import javax.servlet.http.HttpSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import kh.hand.makers.common.PageFactory;
import kh.hand.makers.member.model.vo.Member;
import kh.hand.makers.order.model.vo.Order;
import kh.hand.makers.product.model.service.ProductService;
import kh.hand.makers.product.model.vo.Product;
import kh.hand.makers.shop.model.service.ShopService;
import kh.hand.makers.shop.model.vo.BigCategory;
import kh.hand.makers.shop.model.vo.Brand;
import kh.hand.makers.shop.model.vo.PreProduct;
import kh.hand.makers.shop.model.vo.SmallCategory;

@Controller
public class ShopController {
	private Logger logger=LoggerFactory.getLogger(ShopController.class);
	
	@Autowired
	ShopService service;
	@Autowired
	ProductService productService;
	
	@RequestMapping("/shop/shopCart.do")
	public String shopCart()
	{
		return "shop/shopCart";
	}
	
	// 입점 신청 페이지
	@RequestMapping("/shop/shopEnroll.do")
	public ModelAndView shopEnroll(HttpSession session)
	{	
		String memberNo = ((Member)session.getAttribute("member")).getMemberNo();
		ModelAndView mv = new ModelAndView();
		List<Brand> list = service.selectBrandList(memberNo);
		mv.addObject("list", list);
		mv.setViewName("shop/shopEnroll");
		return mv;
	}
	
	// 브랜드 등록 페이지
	@RequestMapping("/shop/brandEnroll.do")
	public ModelAndView brandEnroll(String brandNo)
	{
		ModelAndView mv = new ModelAndView();

		if(brandNo != null) //반려된 브랜드 재등록 요청일 경우
		{
			Brand brand = service.selectBrand(brandNo);
			mv.addObject("brand", brand);
		}	
		mv.setViewName("shop/brandEnroll");
		return mv;
	}
	
	@RequestMapping("/shop/brandEnrollEnd.do")
	public ModelAndView brandEnrollEnd(String memberNo, Brand b)
	{
		String brandNo = b.getBrandNo();
		
		ModelAndView mv = new ModelAndView();
		Map<String, String> map = new HashMap<>();
		map.put("brandTitle", b.getBrandTitle());
		map.put("brandLicense", b.getBrandLicense());
		map.put("brandType", b.getBrandType());
		map.put("brandAddr", b.getBrandAddr());
		map.put("brandDetailAddr", b.getBrandDetailAddr());
		map.put("memberNo", memberNo);

		int result = -1;
		String msg="";
		String loc="/shop/shopEnroll.do";
		
		if(brandNo.trim().isEmpty()) // 신규 브랜드 등록
		{
			result = service.insertBrand(map);
			if(result>0)
			{
				msg="브랜드 등록이 정상적으로 접수되었습니다.";
			}
			else {
				msg="브랜드 등록 접수에 실패하였습니다.";
			}
		}else { // 반려된 브랜드 재등록 요청
			map.put("brandNo", brandNo);
			result = service.updateBrand(map);
			if(result>0)
			{
				msg="브랜드 재등록 요청이 정상적으로 접수되었습니다.";
			}
			else {
				msg="브랜드 재등록 요청에 실패하였습니다.";
			}
		}
		mv.addObject("msg",msg);
		mv.addObject("loc",loc);
		mv.setViewName("common/msg");
		return mv;
	}

	// 상품 제안 페이지
	@RequestMapping("/shop/productEnroll.do")
	public ModelAndView productEnroll(String brandNo, String preNo)
	{
		ModelAndView mv = new ModelAndView();
		Brand brand = service.selectBrand(brandNo);	
		List<BigCategory> bcList = service.selectBcList();
		List<SmallCategory> scList = service.selectScList("B_C_NO_1");
		
		mv.addObject("brand", brand);
		mv.addObject("bcList", bcList);
		mv.addObject("scList", scList);
		mv.setViewName("shop/productEnroll");
		return mv;
	}
	
	@RequestMapping("/shop/productEnrollEnd.do")
	public ModelAndView productEnrollEnd(PreProduct p)
	{
		ModelAndView mv = new ModelAndView();
		Map<String, String> map = new HashMap<>();
		map.put("preProductTitle", p.getPreProductTitle());
		map.put("preProductDiscript", p.getPreProductDiscript());
		map.put("brandNo", p.getBrandNo());
		map.put("bcNo", p.getBcNo());
		map.put("scNo", p.getScNo());

		int result = service.insertPreProduct(map);
		
		String msg="";
		String loc="/shop/shopEnroll.do";
		if(result>0)
		{
			msg="상품 제안이 정상적으로 접수되었습니다.";
		}
		else {
			msg="상품 제안 접수에 실패하였습니다.";
		}
		mv.addObject("msg",msg);
		mv.addObject("loc",loc);
		mv.setViewName("common/msg");
		return mv;
		
	}
	
	@RequestMapping("/shop/productEnrollScSet.do")
	public ModelAndView productEnrollScSet(String bcNo)
	{
		ModelAndView mv = new ModelAndView();

		List<SmallCategory> scList = service.selectScList(bcNo);
		mv.addObject("scList", scList);
		
		mv.setViewName("jsonView");
		return mv;
	}
	
	// 판매자 브랜드 메인 페이지
	@RequestMapping("/shop/brandHome.do")
	public ModelAndView brandHome(HttpSession session, String brandNo, @RequestParam(value="cPage", required=false, defaultValue="1") int cPage)
	{
		ModelAndView mv = new ModelAndView();
		String memberNo = ((Member)session.getAttribute("member")).getMemberNo();
		List<Map<String, String>> reqList = service.selectSellerReqList(memberNo);
		Brand brand = service.selectBrand(brandNo);	
		
		int numPerPage = 5;
		int contentCount = service.selectPreProductCount(brandNo);
		List<PreProduct> preList = service.selectPreProductList(brandNo, cPage, numPerPage);
		List<BigCategory> bcList = service.selectBcList();
		
		mv.addObject("reqList", reqList);
		mv.addObject("brand", brand);
		mv.addObject("preList", preList);
		mv.addObject("pageBar",PageFactory.getConditionPageBar(contentCount, cPage, numPerPage, "/makers/shop/brandHome.do?brandNo=" + brandNo));
		mv.addObject("bcList", bcList);
		mv.setViewName("shop/brandHome");
		
		return mv;
	}
	
	// 상품 제안 상세 정보
	@RequestMapping("/shop/preProductView.do")
	public ModelAndView preProductView(String preNo)
	{
		ModelAndView mv = new ModelAndView();
		PreProduct pre = service.selectPreProduct(preNo);				
		mv.addObject("pre", pre);
		mv.setViewName("jsonView");
		return mv;
	}
	
	// 현재 판매중인 상품 목록 페이지
	@RequestMapping("/shop/brandSaleProduct.do")
	public ModelAndView brandSaleProduct(HttpSession session, String brandNo, @RequestParam(value="cPage", required=false, defaultValue="1") int cPage)
	{
		ModelAndView mv = new ModelAndView();
		String memberNo = ((Member)session.getAttribute("member")).getMemberNo();

		Map<String, Object> map = new HashMap<>();
		map.put("brandNo", brandNo);
		map.put("productState", "('0', '1')"); //현재 판매중이거나 중지요청 상태
		
		int numPerPage = 6;
		int contentCount = service.selectBrandProductCount(map);
		List<Map<String, Object>> productList = service.selectBrandProductList(map, cPage, numPerPage);	
		List<BigCategory> bcList = service.selectBcList();
		
		List<Map<String, String>> reqList = service.selectSellerReqList(memberNo);
		Brand brand = service.selectBrand(brandNo);	
		
		mv.addObject("reqList", reqList);
		mv.addObject("brand", brand);
		mv.addObject("productList", productList);
		mv.addObject("pageBar",PageFactory.getConditionPageBar(contentCount, cPage, numPerPage, "/makers/shop/brandSaleProduct.do?brandNo=" + brandNo));
		mv.addObject("bcList", bcList);
		mv.setViewName("shop/brandSaleProduct");
		return mv;
	}
	
	// 상품 상세 메인 페이지
	@RequestMapping("/shop/brandProductHome.do")
	public ModelAndView brandProductHome(String productNo, String brandNo, @RequestParam(value="cPage", required=false, defaultValue="1") int cPage)
	{
		ModelAndView mv = new ModelAndView();
		Brand brand = service.selectBrand(brandNo);	
		
		Map<String, String> product = service.selectProduct(productNo);
		int numPerPage = 5;
		int contentCount = service.selectOrderCount(productNo);
		List<Map<String, String>> orderList = service.selectOrderList(productNo, cPage, numPerPage);
		
		mv.addObject("brand", brand);
		mv.addObject("product", product);
		mv.addObject("orderList", orderList);
		mv.addObject("pageBar",PageFactory.getConditionPageBar(contentCount, cPage, numPerPage, "/makers/shop/brandProductHome.do?productNo=" + productNo + "&brandNo=" + brandNo));
		mv.setViewName("shop/brandProductHome");
		
		return mv;

	}
	
	// 상품 상세 문의관리 페이지
	@RequestMapping("/shop/brandProductQna.do")
	public ModelAndView brandProductQna(String productNo, String brandNo, @RequestParam(value="cPage", required=false, defaultValue="1") int cPage)
	{
		ModelAndView mv = new ModelAndView();
		Brand brand = service.selectBrand(brandNo);	
		
		Map<String, String> product = service.selectProduct(productNo);
		int numPerPage = 5;
		int contentCount = service.selectProductQnaCount(productNo);
		List<Map<String, String>> qnaList = service.selectProductQnaList(productNo, cPage, numPerPage);
		List<Map<String, String>> answerList = service.selectProductAnswerList(productNo);
		
		mv.addObject("brand", brand);
		mv.addObject("product", product);
		mv.addObject("qnaList", qnaList);
		mv.addObject("answerList", answerList);
		mv.addObject("pageBar",PageFactory.getConditionPageBar(contentCount, cPage, numPerPage, "/makers/shop/brandProductQna.do?productNo=" + productNo + "&brandNo=" + brandNo));
		mv.setViewName("shop/brandProductQna");
		
		return mv;

	}
	
	//상품 답변 가져오기
	@RequestMapping("/shop/selectProductQnaAnswer.do")
	public ModelAndView selectProductQnaAnswer(String refNo)
	{
		ModelAndView mv = new ModelAndView();
		Map<String, String> answer = service.selectProductQnaAnswer(refNo);				
		mv.addObject("answer", answer);
		mv.setViewName("jsonView");
		return mv;
	}
	
	@RequestMapping("/shop/productQnaAnswer.do")
	public ModelAndView productQnaAnswer(String state, String brandNo,
			@RequestParam(value="commentRef") String commentRef, 
			@RequestParam(value="sellerNo") String sellerNo, 
			@RequestParam(value="productNo") String productNo, 
			@RequestParam(value="content") String content)
	{
		ModelAndView mv = new ModelAndView();
		Map<String, String> map = new HashMap<>();
		map.put("commentRef", commentRef);
		map.put("sellerNo", sellerNo);
		map.put("productNo", productNo);
		map.put("content", content);
		map.put("state", state);
		
		int result = service.productQnaAnswer(map);

		String msg="";
		String loc="/shop/brandProductQna.do?productNo=" + productNo + "&brandNo=" + brandNo;
		if(result>0)
		{
			msg="답변이 정상적으로 등록되었습니다.";
		}
		else {
			msg="답변 등록에 실패하였습니다.";
		}
		mv.addObject("msg",msg);
		mv.addObject("loc",loc);
		mv.setViewName("common/msg");
		return mv;

	}
	
	@RequestMapping("/shop/sellerRequest.do")
	public ModelAndView sellerRequest(HttpSession session,
			@RequestParam(value="brandNo") String brandNo,
			@RequestParam(value="requestTitle") String requestTitle, 
			@RequestParam(value="requestReason") String requestReason, 
			@RequestParam(value="requestRef") String requestRef, 
			@RequestParam(value="requestType") String requestType,
			@RequestParam(value="requestState") String requestState,
			@RequestParam(value="requestLoc") String requestLoc)
	{
		String memberNo = ((Member)session.getAttribute("member")).getMemberNo();
		ModelAndView mv = new ModelAndView();
		Map<String, String> map = new HashMap<>();
		map.put("memberNo", memberNo);
		map.put("requestTitle", requestTitle);
		map.put("requestReason", requestReason);
		map.put("requestRef", requestRef);
		map.put("requestType", requestType);
		map.put("requestState", requestState);
		
		int result = service.insertSellerRequest(map);
		result += service.updateSellerRequestRef(map);

		String msg="";
		String loc= requestLoc + brandNo;
		if(result>1)
		{
			msg="요청이 정상적으로 등록되었습니다.";
		}
		else {
			msg="요청 등록에 실패하였습니다.";
		}
		mv.addObject("msg",msg);
		mv.addObject("loc",loc);
		mv.setViewName("common/msg");
		return mv;

	}
	
	// 요청 중복 검사
	@RequestMapping("/shop/selectReqState.do")
	public ModelAndView selectReqState(String reqRef, String reqState)
	{
		ModelAndView mv = new ModelAndView();
		Map<String, String> map = new HashMap<>();
		map.put("reqRef", reqRef);
		map.put("reqState", reqState);
		
		int result = service.selectReqState(map);				
		mv.addObject("result", result);
		mv.setViewName("jsonView");
		return mv;
	}
	
	@RequestMapping("/shop/brandEndProduct.do")
	public ModelAndView brandEndProduct(HttpSession session, String brandNo, @RequestParam(value="cPage", required=false, defaultValue="1") int cPage)
	{
		ModelAndView mv = new ModelAndView();
		String memberNo = ((Member)session.getAttribute("member")).getMemberNo();

		Map<String, Object> map = new HashMap<>();
		map.put("brandNo", brandNo);
		map.put("productState", "('3', '4')"); //판매종료 상태
		
		int numPerPage = 6;
		int contentCount = service.selectBrandProductCount(map);
		List<Map<String, Object>> productList = service.selectBrandProductList(map, cPage, numPerPage);	
		List<BigCategory> bcList = service.selectBcList();
		
		List<Map<String, String>> reqList = service.selectSellerReqList(memberNo);
		Brand brand = service.selectBrand(brandNo);	
		
		mv.addObject("reqList", reqList);
		mv.addObject("brand", brand);
		mv.addObject("productList", productList);
		mv.addObject("pageBar",PageFactory.getConditionPageBar(contentCount, cPage, numPerPage, "/makers/shop/brandEndProduct.do?brandNo=" + brandNo));
		mv.addObject("bcList", bcList);
		mv.setViewName("shop/brandEndProduct");
		return mv;
	}
	
	@RequestMapping("/shop/exportOrders.do")
	public ModelAndView exportOrders(String[] orders, String productNo, String brandNo)
	{
		ModelAndView mv = new ModelAndView();
		int result = 0;
		for(int i = 0; i < orders.length; i++)
		{
			result += service.exportOrders(orders[i]);
		}

		String msg="";
		String loc= "/shop/brandProductHome.do?productNo=" + productNo + "&brandNo=" + brandNo;
		
		if(result == orders.length)
		{
			msg="출고처리가 정상적으로 완료되었습니다.";
		}
		else {
			msg="출고처리가 정상적으로 완료되지 않았습니다. 관리자에게 문의해주세요.";
		}
		mv.addObject("msg",msg);
		mv.addObject("loc",loc);
		mv.setViewName("common/msg");
		return mv;
	}
	
	@RequestMapping("/shop/orderView.do")
	public ModelAndView orderView(String orderNo)
	{
		ModelAndView mv = new ModelAndView();
		
		Map<String, String> order = service.selectOrder(orderNo);				
		mv.addObject("order", order);
		mv.setViewName("jsonView");
		return mv;
	}
	
	@RequestMapping("/shop/updateTracking.do")
	public ModelAndView updateTracking(String orderNo, String trackingNo, String productNo, String brandNo)
	{
		ModelAndView mv = new ModelAndView();
		
		Map<String, String> map = new HashMap<>();		
		map.put("orderNo", orderNo);
		map.put("trackingNo", trackingNo);
		
		service.updateTracking(map);		
		mv.setViewName("redirect:/shop/brandProductHome.do?productNo=" + productNo + "&brandNo=" + brandNo);
		return mv;
	}
	
	// 상품 상세 판매이력 관리 페이지
	@RequestMapping("/shop/brandProductSalesRecords.do")
	public ModelAndView brandProductSalesRecords(String productNo, String brandNo, @RequestParam(value="cPage", required=false, defaultValue="1") int cPage)
	{
		ModelAndView mv = new ModelAndView();
		Brand brand = service.selectBrand(brandNo);	
		
		Map<String, String> product = service.selectProduct(productNo);
		int numPerPage = 5;
		int contentCount = service.selectSalesRecordsCount(productNo);
		List<Map<String, String>> salesRecordsList = service.selectSalesRecordsList(productNo, cPage, numPerPage);
		
		mv.addObject("brand", brand);
		mv.addObject("product", product);
		mv.addObject("salesRecordsList", salesRecordsList);
		mv.addObject("pageBar",PageFactory.getConditionPageBar(contentCount, cPage, numPerPage, "/makers/shop/brandProductSaleRecords.do?productNo=" + productNo + "&brandNo=" + brandNo));
		mv.setViewName("shop/brandProductSalesRecords");
		
		return mv;

	}
	
	@RequestMapping("/shop/recordView")
	public ModelAndView recordView(String recordNo)
	{
		ModelAndView mv = new ModelAndView();
		
		Map<String, String> record = service.selectRecord(recordNo);				
		mv.addObject("record", record);
		mv.setViewName("jsonView");
		return mv;
	}
}
