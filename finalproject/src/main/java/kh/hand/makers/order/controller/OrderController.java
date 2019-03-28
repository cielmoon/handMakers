package kh.hand.makers.order.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.siot.IamportRestClient.IamportClient;
import com.siot.IamportRestClient.exception.IamportResponseException;
import com.siot.IamportRestClient.request.CancelData;
import com.siot.IamportRestClient.response.AccessToken;
import com.siot.IamportRestClient.response.IamportResponse;
import com.siot.IamportRestClient.response.Payment;

import kh.hand.makers.member.model.vo.Member;
import kh.hand.makers.order.model.service.OrderService;
import kh.hand.makers.order.model.service.OrderServiceImpl;
import kh.hand.makers.order.model.vo.Delivery;
import kh.hand.makers.order.model.vo.Order;
import kh.hand.makers.product.model.service.ProductService;
import kh.hand.makers.product.model.vo.DefaultProduct;
import kh.hand.makers.shop.model.service.ShopService;
import kh.hand.makers.shop.model.vo.SmallCategory;

@Controller
public class OrderController {

	private Logger logger = LoggerFactory.getLogger(OrderController.class);

	@Autowired
	OrderService service = new OrderServiceImpl();
	@Autowired
	ProductService productService;
	@Autowired
	ShopService shopService;

	@RequestMapping("/order/orderEnroll.do")
	public ModelAndView orderEnroll(@RequestParam Map<String, Object> map, HttpSession session) {

		String memberNo = ((Member) session.getAttribute("member")).getMemberNo();

		ModelAndView mv = new ModelAndView();

		logger.debug(map + "");

		// 장바구니 비슷한 구매전에 업데이트 우선 함!!! 나중에 결제 안되면 롤백!!!
		/* int updateOrder = service.updateOrder(map); */

		String productOptionNo = (String) map.get("productOption");

		Map<String, String> productOption = service.selectProductOption(productOptionNo);

		String productNo = (String) map.get("productNo");

		Map<String, String> product = productService.selectProduct(productNo);

		Map<String, String> categoryMap = service.selectCategoryMap(productNo);

		String bcTitle = productService.selectBcTitle(categoryMap.get("BC_NO"));

		List<SmallCategory> scList = shopService.selectScList(categoryMap.get("BC_NO"));

		logger.debug(productOption + "");

		List<Map<String, String>> deliveryList = service.selectDeliveryList(memberNo);

		mv.addObject("product", product);
		mv.addObject("bcTitle", bcTitle);
		mv.addObject("scList", scList);
		mv.addObject("deliveryList", deliveryList);
		mv.addObject("orderList", map);
		mv.addObject("productOption", productOption);
		mv.setViewName("order/orderEnroll");

		return mv;
	}

	@RequestMapping("/order/orderEnrollEnd.do")
	public ModelAndView orderEnrollEnd(@RequestParam Map<String, Object> map) {

		ModelAndView mv = new ModelAndView();

		String msg = "";
		String loc = "";
		String memberNo = (String) map.get("member_no"); // 회원 번호
		String productNo = (String) map.get("product_no"); // 상품 번호
		String imp_uid = (String) map.get("imp_uid"); // 아임포트 고유 번호
		String merchant_uid = (String) map.get("merchant_uid"); // 아임포트 주문번호
		int orderTotalPrice = Integer.parseInt((String) map.get("order_total_price")); // 결제 총 금액
		String orderPayType = (String) map.get("order_payType"); // 상품 결제 타입
		int productOptionQty = Integer.parseInt((String) map.get("productOptionQty")); // 상품 수량
		String productOption = (String) map.get("productOption"); // 상품 옵션
		String orderPayStatus = (String) map.get("order_payStatus");
		String postCode = (String) map.get("postCode"); // 우편번호
		String deliveryAddr = (String) map.get("addr"); // 주소
		String deliveryDetailAddr = (String) map.get("detailAddr"); // 상세주소

		logger.debug(orderPayStatus);
		logger.debug(memberNo);
		logger.debug(productNo);
		logger.debug(imp_uid);
		logger.debug(merchant_uid);
		logger.debug(orderTotalPrice + "");
		logger.debug(orderPayType);
		logger.debug(productOptionQty + "");
		logger.debug(productOption);
		logger.debug(postCode);
		logger.debug(deliveryAddr);
		logger.debug(deliveryDetailAddr);

		Order order = new Order();

		order.setOrderTotalPrice(orderTotalPrice);
		order.setOrderPayType(orderPayType);
		order.setOrderPayStatus(orderPayStatus);
		order.setProductNo(productNo);
		order.setMemberNo(memberNo);
		order.setImp_uid(imp_uid);
		order.setMerchant_uid(merchant_uid);
		order.setProductOption(productOption);
		order.setProductOptionQty(productOptionQty);

		order.setDeliveryPostCode(postCode);
		order.setDeliveryAddr(deliveryAddr);
		order.setDeliveryDetailAddr(deliveryDetailAddr);

		// 다시 한번 체크 확인
		DefaultProduct dp = productService.selectDefaltProduct(productNo);

		String state = "";
		int result = 0;

		System.out.println("최대수량: " + dp.getProductMax());
		System.out.println("현재판매량: " + dp.getProductCurSell());
		System.out.println("구매가능한량: " + (dp.getProductMax() - dp.getProductCurSell()));
		System.out.println("사려는수량: " + order.getProductOptionQty());

		if (dp.getProductMax() < (dp.getProductCurSell() + order.getProductOptionQty())) {
			state = "F";

			// 결제 환불
			IamportClient client;

			String accessToken = null;

			String test_api_key = "0709424890638444";
			String test_api_secret = "AblFnSFrDGn4XNWRNAdC4E4dgOosLqbmCx1ZpHr3oP8mC5dqFq3K57YmWmOIN04px6pXOR1cH9zkfMKV";
			client = new IamportClient(test_api_key, test_api_secret);

			try {
				IamportResponse<AccessToken> auth_response = client.getAuth();
				accessToken = auth_response.getResponse().getToken();

			} catch (IamportResponseException e) {
				System.out.println(e.getMessage());

				switch (e.getHttpStatusCode()) {
				case 401:
					// TODO
					break;
				case 500:
					// TODO
					break;
				}
			} catch (IOException e) {
				// 서버 연결 실패
				e.printStackTrace();
			}

			/*
			 * String oNo = order.getOrderNo(); // 배송번호 String oState =
			 * order.getOrderPayState(); // 상태값 String uid = order.getImp_uid(); // 배송취소에
			 * 필요한 고유 번호 String productNo = order.getProductNo();// 상품 번호 String
			 * productOptionQty = order.getProductOptionQty();// 상품 수량
			 */
			/*
			 * logger.debug(uid); logger.debug(oNo);
			 */

			Map<String, String> orderMap = new HashMap();
			Map<String, Object> productMap = new HashMap();

			/* String memberNo = order.getMemberNo(); */

			/* String uid = order.getImp_uid(); */

			orderMap.put("orderState", order.getOrderPayState());
			orderMap.put("imp_uid", imp_uid);
			orderMap.put("memberNo", memberNo);
			orderMap.put("productNo", order.getProductNo());
			productMap.put("productOptionQty", order.getProductOptionQty());
			productMap.put("productNo", order.getProductNo());

			int cancelResult = 0;

			try {
				// 주문 상태 바꾸는 로직
				cancelResult = service.updateOrderState(orderMap);

				/*
				 * if (result > 0) { // 상품 현재 판매량 수량에 맞춰서 마이너스 cancelResult =
				 * productService.updateProductMinus(productMap); }
				 */
			} catch (Exception e) {
				e.printStackTrace();
			}

			/* String imp_uid = uid; */
			CancelData cancel_data = new CancelData(imp_uid, true); // imp_uid를 통한 전액취소

			try {
				IamportResponse<Payment> payment_response = client.cancelPaymentByImpUid(cancel_data);
				logger.debug(payment_response.getMessage());

			} catch (IamportResponseException e) {
				/* System.out.println(e.getMessage()); */

				switch (e.getHttpStatusCode()) {
				case 401:
					// TODO
					break;
				case 500:
					// TODO
					break;
				}
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}

			msg = "재고량이 없어 환불 되었습니다.";
			loc = "/order/orderEnroll.do?productNo=" + productNo;

		} else {
			/*
			 * 0. 재고확인 1. order insert 2. 판매종료 확인 -> 성공 : 판매종료로 update -> 판매이력 insert ->
			 * product update -> 판매종료가 아니면 그냥 다음단계 3.
			 */
			state = "T";


			// 1. 재고확인
			DefaultProduct dps = productService.selectDefaltProduct(productNo);

			if (dps.getProductMax() > (dps.getProductCurSell() + order.getProductOptionQty())) {
				// 재고가 남을 경우 : order insert + product update : 누적x 현재: +수량만큼
				int orderInsertResult = service.orderInsert(order);
				if (orderInsertResult > 0) {

					Map<String, Object> updateProduct = new HashMap();
					updateProduct.put("productNo", productNo);
					updateProduct.put("productOptionQty", order.getProductOptionQty());
					// Product Update
					int updateProductQtyResult = service.updateProductQty(updateProduct);
					if (updateProductQtyResult > 0) {
						msg = "결제 완료되었습니다 이용해주셔서 감사합니다.";
						loc = "/member/manageOrder.do";

					} else {
						int deleteResult = service.deleteOrder(order.getOrderNo());
						logger.debug("주문 실패 했기 때문에 Insert한 Order를 삭제 : Rollback");
						msg = "결제 실패하였습니다.";
						loc = "/order/orderEnroll.do";
					}

				} else {
					int deleteResult = service.deleteOrder(order.getOrderNo());
					logger.debug("주문 실패 했기 때문에 Insert한 Order를 삭제 : Rollback");
					msg = "결제 실패하였습니다.";
					loc = "/order/orderEnroll.do";
					

				}

			} else if (dps.getProductMax() == (dps.getProductCurSell() + order.getProductOptionQty())) {
				// 재고가 같을경우 : 판매종료를 시켜야함
				int orderInsertResult = service.orderInsert(order);
				if (orderInsertResult > 0) {
					// 판매이력으로 insert
					
					Map<String, Object> updateProduct = new HashMap();
					updateProduct.put("productNo", productNo);
					updateProduct.put("productOptionQty", order.getProductOptionQty());

					int updateProductQtyResult = service.updateProductQty(updateProduct);
					if (updateProductQtyResult > 0) {
						DefaultProduct ds = productService.selectDefaltProduct(productNo);
						logger.debug("ProductUpdate 성공 - 판매이력 Insert하러옴");
						System.out.println("가져온Product:"+ds);
						int saleInsertResult = service.salesInsert(ds);
				

						if (saleInsertResult > 0) {
							// 판매이력 insert 성공
							logger.debug("판매이력 Insert 성공 ");
							// product 초기화 cursell + 누적 cursell = 0 state = 3
							int updateProductCSResult = service.updateProductCS(productNo);

							if (updateProductCSResult > 0) {
								logger.debug("초기화 성공 ");
								msg = "결제 완료되었습니다 이용해주셔서 감사합니다.";
								loc = "/member/manageOrder.do";
								// Product Update
							} else {
								// saleInsert 삭제시켜야함
								logger.debug("초기화 실패 ");
								msg = "결제 실패하였습니다.";
								loc = "/order/orderEnroll.do";
							}

						} else {
							int deleteResult = service.deleteOrder(order.getOrderNo());
							logger.debug("주문 실패 했기 때문에 Insert한 Order를 삭제 : Rollback");
							msg = "결제 실패하였습니다.";
							loc = "/order/orderEnroll.do";
						}

					} else {
						// int deleteSalesResult = service.deleteSales();
						int deleteResult = service.deleteOrder(order.getOrderNo());
						logger.debug("주문 실패 했기 때문에 Insert한 Order를 삭제 : Rollback");
						msg = "결제 실패하였습니다.";
						loc = "/order/orderEnroll.do";
					}

				} else {
					int deleteResult = service.deleteOrder(order.getOrderNo());
					logger.debug("주문 실패 했기 때문에 Insert한 Order를 삭제 : Rollback");
					msg = "결제 실패하였습니다.";
					loc = "/order/orderEnroll.do";
				}

			} else {
				// 재고보다 많을 경우

			}

		}
		mv.addObject("loc", loc);
		mv.addObject("msg", msg);
		mv.setViewName("/common/msg");

		return mv;

	}

	@RequestMapping("/delivery/selectDelivery.do")
	public ModelAndView selectDelivery(String deliveryNo, HttpSession session) {

		String memberNo = ((Member) session.getAttribute("member")).getMemberNo();

		ModelAndView mv = new ModelAndView();

		Delivery delivery = new Delivery();

		delivery.setDeliveryNo(deliveryNo);
		delivery.setMemberNo(memberNo);

		delivery = service.selectDelivery(delivery);

		logger.debug(delivery + "");

		mv.addObject("delivery", delivery);
		mv.setViewName("jsonView");

		return mv;
	}

	@RequestMapping("/order/updateResetOrder.do")
	public ModelAndView updateResetOrder(@RequestParam Map<String, String> map) {

		ModelAndView mv = new ModelAndView();

		logger.debug(map + "");

		int result = service.updateResetOrder(map);

		String msg = "결제 실패 하셨습니다.";
		String loc = "/product/productView.do?productNo=" + map.get("productNo");

		mv.addObject("loc", loc);
		mv.addObject("msg", msg);
		mv.setViewName("/common/msg");

		return mv;
	}

}
