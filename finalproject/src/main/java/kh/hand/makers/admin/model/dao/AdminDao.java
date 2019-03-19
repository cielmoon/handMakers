package kh.hand.makers.admin.model.dao;

import java.util.List;
import java.util.Map;

import kh.hand.makers.admin.model.vo.AdminProduct;
import kh.hand.makers.admin.model.vo.SellerRequest;
import kh.hand.makers.admin.model.vo.managePreProduct;
import kh.hand.makers.member.model.vo.Member;
import kh.hand.makers.shop.model.vo.BigCategory;
import kh.hand.makers.shop.model.vo.Brand;
import kh.hand.makers.shop.model.vo.PreProduct;
import kh.hand.makers.shop.model.vo.SmallCategory;

public interface AdminDao {

	int selectReProductCount();
	List<AdminProduct> selectReProductList(int cPage,int numPerPage);
	
	List<AdminProduct> selectProductList(int cPage,int numPerPage);
	List<Brand> selectBrandList(int cPage, int numPerPage);
	int selectProductCount();
	int selectBrandCount();
	int brandStateUpdate(Map<String,String> bs);
	int productStateUpdate(Map<String,String> ps);
	
	int reqProcessUpdate(Map<String,String> sr1);
	int reqStateUpdate(Map<String,String> sr2);
	
	List<managePreProduct> selectPreProductList(int cPage,int numPerPage);
	PreProduct selectPreProduct(String preProductNo);
	int selectPreProductCount();
	int preProductStateUpdate(Map<String,String> ps);
	int selectMemberCount();
	List<Member> selectMemberList(int cPage,int numPerPage);
	
	int selectRequestCount(String reqRefType);
	List<SellerRequest> selectRequestList(String reqRefType, int cPage,int numPerPage);
	String selectBrandName(String reqRef);
	String selectProductName(String reqRef);
	
	List<BigCategory> selectBcList();
	List<SmallCategory> selectScList(String bcNo);
}
