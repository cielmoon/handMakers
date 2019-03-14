package kh.hand.makers.admin.model.service;

import java.util.List;
import java.util.Map;

import kh.hand.makers.admin.model.vo.managePreProduct;
import kh.hand.makers.product.model.vo.Product;
import kh.hand.makers.shop.model.vo.Brand;
import kh.hand.makers.shop.model.vo.PreProduct;

public interface AdminService {	
	
	int selectProductCount();
	List<Brand> selectBrandList(int cPage,int numPerPage);
	int selectBrandCount();
	int brandStateUpdate(Map<String,String> bs);
	List<managePreProduct> selectPreProductList(int cPage,int numPerPage);
	PreProduct selectPreProduct(String preProductNo);
	int selectPreProductCount();
	int preProductStateUpdate(Map<String,String> ps);
	List<Product> selectProductList(int cPage,int numPerPage);
}
