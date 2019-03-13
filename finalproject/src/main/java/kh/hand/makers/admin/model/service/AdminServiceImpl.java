package kh.hand.makers.admin.model.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kh.hand.makers.admin.model.dao.AdminDao;
import kh.hand.makers.shop.model.vo.Brand;
@Service
public class AdminServiceImpl implements AdminService {
	@Autowired
	AdminDao dao;
	
	@Override
	public List<Map<String, String>> selectProductList(int cPage, int numPerPage) {
		return dao.selectProductList(cPage, numPerPage);
	}
	
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
	
}
