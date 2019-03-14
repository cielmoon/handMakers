package kh.hand.makers.admin.model.dao;

import java.util.List;
import java.util.Map;

import kh.hand.makers.shop.model.vo.Brand;

public interface AdminDao {

	List<Map<String,String>> selectProductList(int cPage, int numPerPage);
	List<Brand> selectBrandList(int cPage, int numPerPage);
	int selectProductCount();
	int selectBrandCount();
	int brandStateUpdate(Map<String,String> bs);
}
