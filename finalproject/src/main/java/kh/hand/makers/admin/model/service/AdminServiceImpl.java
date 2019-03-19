package kh.hand.makers.admin.model.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kh.hand.makers.admin.model.dao.AdminDao;
import kh.hand.makers.admin.model.vo.AdminProduct;
import kh.hand.makers.admin.model.vo.SellerRequest;
import kh.hand.makers.admin.model.vo.managePreProduct;
import kh.hand.makers.member.model.vo.Member;
import kh.hand.makers.shop.model.vo.BigCategory;
import kh.hand.makers.shop.model.vo.Brand;
import kh.hand.makers.shop.model.vo.PreProduct;
import kh.hand.makers.shop.model.vo.SmallCategory;
@Service
public class AdminServiceImpl implements AdminService {
	@Autowired
	AdminDao dao;
	
	@Override
	public int selectProductCount() {
		return dao.selectProductCount();
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
	public int selectPreProductCount() {
		// TODO Auto-generated method stub
		return dao.selectPreProductCount();
	}

	@Override
	public List<managePreProduct> selectPreProductList(int cPage, int numPerPage) {
		// TODO Auto-generated method stub
		return dao.selectPreProductList(cPage, numPerPage);
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
	public List<AdminProduct> selectProductList(int cPage, int numPerPage) {
		// TODO Auto-generated method stub
		return dao.selectProductList(cPage, numPerPage);
	}

	@Override
	public int selectMemberCount() {
		// TODO Auto-generated method stub
		return dao.selectMemberCount();
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
	public int selectReProductCount() {
		// TODO Auto-generated method stub
		return dao.selectReProductCount();
	}

	@Override
	public List<AdminProduct> selectReProductList(int cPage, int numPerPage) {
		// TODO Auto-generated method stub
		return dao.selectReProductList(cPage, numPerPage);
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

}
