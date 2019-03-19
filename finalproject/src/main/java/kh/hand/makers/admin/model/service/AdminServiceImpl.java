package kh.hand.makers.admin.model.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kh.hand.makers.admin.model.dao.AdminDao;
import kh.hand.makers.admin.model.vo.AdminProduct;
import kh.hand.makers.admin.model.vo.managePreProduct;
import kh.hand.makers.member.model.vo.Member;
import kh.hand.makers.shop.model.vo.Brand;
import kh.hand.makers.shop.model.vo.PreProduct;
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
}
