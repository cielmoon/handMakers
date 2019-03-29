package kh.hand.makers.member.model.dao;

import java.util.List;
import java.util.Map;

import kh.hand.makers.member.model.vo.ManageOrder;
import kh.hand.makers.member.model.vo.Member;
import kh.hand.makers.order.model.vo.Delivery;
import kh.hand.makers.product.model.vo.Wish;
import kh.hand.makers.shop.model.vo.Brand;

public interface MemberDao {
	Member memberLogin(String memberId);
	int memberEnroll(Member m);
	int selectBrandCloseCount();
	List<Map<String,String>> selectBrandCloseList(int cPage,int numPerPage);
	int checkId(String memberId);
	int memberUpdate(Member m);
	int memberWithdrawal(String memberNo);
	List<Delivery> selectDeliveryList(String memberNo);
	int enrollLocation(Delivery delivery);
	int memberPwdUpdate(Member m);
	List<ManageOrder> selectOrderList(Member m, int cPage,int numPerPage);
	int selectOrderCount(String memberNo);
	List<Map<String,String>> selectWishList(String memberNo, int cPage, int numPerPage);
	int selectWishCount(String memberNo);
	int deleteLocation(String deliveryNo);
	String memberIdFind(String memberEmail);
	Member memberFind(Map<String,String> findMember);
	int memberNewPwdUpdate(Map<String,String> cP);
	int checkEmail(String memberEmail);

	int changeProfile(Member m);

	int updateOrderState(String orderNo);
	int selectProductState(String productNo);
	
	Member memberEmailFind(String memberEmail);
	List<Brand> selectBrand(String memberNo);
	int updateProductWithdrawl(String brandNo);
	int updateBrandWithdrawl(String brandNo);
	int updateProductState(String productNo);
	int deleteSaleProduct(String salesNo);
	
	String selectSalseNo(String productNo);
	int selectCerrSell(String salesNo);

}
