package kh.hand.makers.admin.model.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kh.hand.makers.admin.model.dao.AdminDao;
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
@Service
public class AdminServiceImpl implements AdminService {
	@Autowired
	AdminDao dao;


	@Override
	public int selectProductCount(Map<String, String> sortingProductList) {
		return dao.selectProductCount(sortingProductList);
	}

	@Override
	public List<Brand> selectBrandList(int cPage, int numPerPage) {
		// TODO Auto-generated method stub
		return dao.selectBrandList(cPage, numPerPage);
	}

	@Override
	public int selectBrandCount() {
		// TODO Auto-generated method stub
		return dao.selectBrandCount();
	}

	@Override
	public int brandStateUpdate(Map<String,String> bs) {
		// TODO Auto-generated method stub
		return dao.brandStateUpdate(bs);
	}

	@Override
	public int selectPreProductCount(Map<String, String> sortingProductList) {
		// TODO Auto-generated method stub
		return dao.selectPreProductCount(sortingProductList);
	}

	@Override
	public List<managePreProduct> selectPreProductList(int cPage, int numPerPage,Map<String, String> sortingProductList) {
		// TODO Auto-generated method stub
		return dao.selectPreProductList(cPage, numPerPage,sortingProductList);
	}

	@Override
	public int preProductStateUpdate(Map<String, String> ps) {
		// TODO Auto-generated method stub
		return dao.preProductStateUpdate(ps);
	}

	@Override
	public PreProduct selectPreProduct(String preProductNo) {
		// TODO Auto-generated method stub
		return dao.selectPreProduct(preProductNo);
	}

	@Override
	public List<AdminProduct> selectProductList(int cPage, int numPerPage, Map<String, String> sortingProductList) {
		// TODO Auto-generated method stub
		return dao.selectProductList(cPage, numPerPage ,sortingProductList);
	}
	
	/*@Override
	public List<AdminProduct> selectProductList(Map<String, String> sortingProductList) {
		// TODO Auto-generated method stub
		return dao.selectProductList(sortingProductList);
	}*/
	

	@Override
	public int selectMemberCount(List<Member> memberList) {
		// TODO Auto-generated method stub
		return dao.selectMemberCount(memberList);
	}


	@Override
	public List<Member> selectMemberList(int cPage, int numPerPage) {
		// TODO Auto-generated method stub
		return dao.selectMemberList(cPage, numPerPage);
	}

	@Override
	public int selectRequestCount(String reqRefType) {
		// TODO Auto-generated method stub
		return dao.selectRequestCount(reqRefType);
	}

	@Override
	public List<SellerRequest> selectRequestList(String reqRefType, int cPage, int numPerPage) {
		// TODO Auto-generated method stub
		return dao.selectRequestList(reqRefType, cPage, numPerPage);
	}

	@Override
	public String selectBrandName(String reqRef) {
		// TODO Auto-generated method stub
		return dao.selectBrandName(reqRef);
	}

	@Override
	public String selectProductName(String reqRef) {
		// TODO Auto-generated method stub
		return dao.selectProductName(reqRef);
	}

	@Override
	public int reqProcessUpdate(Map<String, String> sr1) {
		// TODO Auto-generated method stub
		return dao.reqProcessUpdate(sr1);
	}

	@Override
	public int reqStateUpdate(Map<String, String> sr2) {
		// TODO Auto-generated method stub
		return dao.reqStateUpdate(sr2);
	}

	@Override
	public int productStateUpdate(Map<String, String> ps) {
		// TODO Auto-generated method stub
		return dao.productStateUpdate(ps);
	}

	@Override
	public int selectReProductCount(Map<String, String> sortingProductList) {
		// TODO Auto-generated method stub
		return dao.selectReProductCount(sortingProductList);
	}

	@Override
	public List<AdminProduct> selectReProductList(int cPage, int numPerPage, Map<String, String> sortingProductList) {
		// TODO Auto-generated method stub
		return dao.selectReProductList(cPage, numPerPage, sortingProductList);
	}

	@Override
	public List<BigCategory> selectBcList() {
		// TODO Auto-generated method stub
		return dao.selectBcList();
	}

	@Override
	public List<SmallCategory> selectScList(String bcNo) {
		// TODO Auto-generated method stub
		return dao.selectScList(bcNo);
	}

	@Override
	public int enrollProduct(Products p) {
		// TODO Auto-generated method stub
		return dao.enrollProduct(p);
	}

	@Override
	public int enrollProductImg(Map<String, String> img) {
		// TODO Auto-generated method stub
		return dao.enrollProductImg(img);
	}

	@Override
	public int enrollProductOption(Map<String, String> option) {
		// TODO Auto-generated method stub
		return dao.enrollProductOption(option);
	}

	@Override
	public int enrollProductDetail(Map<String, String> detail) {
		// TODO Auto-generated method stub
		return dao.enrollProductDetail(detail);
	}

	@Override
	public List<Brand> selectBrandList() {
		// TODO Auto-generated method stub
		return dao.selectBrandList();
	}

	@Override
	public String selectSellerNo(String brandNo) {
		// TODO Auto-generated method stub
		return dao.selectSellerNo(brandNo);
	}

	@Override
	public int memberStateUpdate(String memberNo) {
		// TODO Auto-generated method stub
		return dao.memberStateUpdate(memberNo);
	}

	@Override
	public int memberAuthorityChange(String memberNo) {
		// TODO Auto-generated method stub
		return dao.memberAuthorityChange(memberNo);
	}

	@Override
	public int selectBrandStateCount(String memberNo) {
		// TODO Auto-generated method stub
		return dao.selectBrandStateCount(memberNo);
	}

	@Override
	public int updateProductState(String brandNo) {
		// TODO Auto-generated method stub
		return dao.updateProductState(brandNo);
	}

	@Override
	public int sellerProfileUpdate(String memberNo) {
		// TODO Auto-generated method stub
		return dao.sellerProfileUpdate(memberNo);
	}

	@Override
	public Map<String,String> selectProduct(String productNo) {
		// TODO Auto-generated method stub
		return dao.selectProduct(productNo);
	}

	@Override
	public int updateProduct(Map<String, String> product) {
		// TODO Auto-generated method stub
		return  dao.updateProduct(product);
	}

	@Override
	public List<SellerRequest> selectRequestStateList(int cPage, int numPerPage, String state) {
		// TODO Auto-generated method stub
		return dao.selectRequestStateList(cPage, numPerPage, state);
	}

	@Override
	public int selectRequestStateListCount(String state) {
		// TODO Auto-generated method stub
		return dao.selectRequestStateListCount(state);
	}

	@Override
	public SellerRequest selectSellerRequest(String sellerReqNo) {
		// TODO Auto-generated method stub
		return dao.selectSellerRequest(sellerReqNo);
	}


	@Override
	public int updatePState(String productNo) {
		// TODO Auto-generated method stub
		return dao.updatePState(productNo);
	}
	
	
}
