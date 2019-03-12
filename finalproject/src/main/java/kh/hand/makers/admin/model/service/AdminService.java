package kh.hand.makers.admin.model.service;

import java.util.List;
import java.util.Map;

import kh.hand.makers.shop.model.vo.Brand;

public interface AdminService {
	
	List<Map<String,String>> selectProductList(int cPage,int numPerPage);
	int selectProductCount();
	List<Brand> selectBrandList(int cPage,int numPerPage);
	int selectBrandCount();
}
