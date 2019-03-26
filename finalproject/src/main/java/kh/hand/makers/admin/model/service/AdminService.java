package kh.hand.makers.admin.model.service;

import java.util.List;
import java.util.Map;

import kh.hand.makers.admin.model.vo.AdminProduct;
import kh.hand.makers.admin.model.vo.Products;
import kh.hand.makers.admin.model.vo.SellerRequest;
import kh.hand.makers.admin.model.vo.managePreProduct;
import kh.hand.makers.member.model.vo.Member;
import kh.hand.makers.product.model.vo.Product;
import kh.hand.makers.shop.model.vo.BigCategory;
import kh.hand.makers.shop.model.vo.Brand;
import kh.hand.makers.shop.model.vo.PreProduct;
import kh.hand.makers.shop.model.vo.SmallCategory;

public interface AdminService {	
	
	int selectProductCount(Map<String, String> sortingProductList);
	List<AdminProduct> selectProductList(int cPage,int numPerPage, Map<String, String> sortingProductList);
	/*List<AdminProduct> selectProductList(Map<String, String> sortingProductList);*/
	
	int selectReProductCount(Map<String, String> sortingProductList);
	List<AdminProduct> selectReProductList(int cPage,int numPerPage, Map<String, String> sortingProductList);
	
	List<Brand> selectBrandList(int cPage,int numPerPage);
	int selectBrandCount();
	int brandStateUpdate(Map<String,String> bs);
	int productStateUpdate(Map<String,String> ps);
	
	int reqProcessUpdate(Map<String,String> sr1);
	int reqStateUpdate(Map<String,String> sr2);
	
	
	List<managePreProduct> selectPreProductList(int cPage,int numPerPage,Map<String, String> sortingProductList);
	PreProduct selectPreProduct(String preProductNo);
	int selectPreProductCount(Map<String, String> sortingProductList);
	int preProductStateUpdate(Map<String,String> ps);
	
	int selectMemberCount(List<Member> memberList);
	List<Member> selectMemberList(int cPage,int numPerPage);
	
	int selectRequestCount(String reqRefType);
	List<SellerRequest> selectRequestList(String reqRefType, int cPage,int numPerPage);
	String selectBrandName(String reqRef);
	String selectProductName(String reqRef);
	
	List<BigCategory> selectBcList();
	List<SmallCategory> selectScList(String bcNo);
	
	int enrollProduct(Products p);
	int enrollProductDetail(Map<String, String> detail);
	int enrollProductImg(Map<String, String> img);
	int enrollProductOption(Map<String, String> option);
	
	List<Brand> selectBrandList();
	String selectSellerNo(String brandNo);
	int memberStateUpdate(String memberNo);
	int memberAuthorityChange(String memberNo);
	int selectBrandStateCount(String memberNo);
	int updateProductState(String brandNo);
	int sellerProfileUpdate(String memberNo);
	Map<String,String> selectProduct(String productNo);
	int updateProduct(Map<String,String> product);
	
	List<SellerRequest> selectRequestStateList(int cPage, int numPerPage, String state);
	int selectRequestStateListCount(String state);
	SellerRequest selectSellerRequest(String sellerReqNo);
	
	int updatePState(String productNo);
	
}
