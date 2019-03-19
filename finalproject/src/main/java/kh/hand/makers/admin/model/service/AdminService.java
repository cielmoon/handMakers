package kh.hand.makers.admin.model.service;

import java.util.List;
import java.util.Map;

import kh.hand.makers.admin.model.vo.AdminProduct;
import kh.hand.makers.admin.model.vo.SellerRequest;
import kh.hand.makers.admin.model.vo.managePreProduct;
import kh.hand.makers.member.model.vo.Member;
import kh.hand.makers.shop.model.vo.Brand;
import kh.hand.makers.shop.model.vo.PreProduct;

public interface AdminService {	
	
	int selectProductCount();
	List<Brand> selectBrandList(int cPage,int numPerPage);
	int selectBrandCount();
	int brandStateUpdate(Map<String,String> bs);
	int productStateUpdate(Map<String,String> ps);
	
	int reqProcessUpdate(Map<String,String> sr1);
	int reqStateUpdate(Map<String,String> sr2);
	
	
	List<managePreProduct> selectPreProductList(int cPage,int numPerPage);
	PreProduct selectPreProduct(String preProductNo);
	int selectPreProductCount();
	int preProductStateUpdate(Map<String,String> ps);
	List<AdminProduct> selectProductList(int cPage,int numPerPage);
	int selectMemberCount();
	List<Member> selectMemberList(int cPage,int numPerPage);
	
	int selectRequestCount(String reqRefType);
	List<SellerRequest> selectRequestList(String reqRefType, int cPage,int numPerPage);
	String selectBrandName(String reqRef);
	String selectProductName(String reqRef);
}
