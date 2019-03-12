package kh.hand.makers.admin.model.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kh.hand.makers.admin.model.dao.AdminDao;
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
	
}
