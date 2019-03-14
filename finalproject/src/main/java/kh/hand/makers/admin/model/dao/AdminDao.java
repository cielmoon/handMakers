package kh.hand.makers.admin.model.dao;

import java.util.List;
import java.util.Map;

import kh.hand.makers.admin.model.vo.managePreProduct;
import kh.hand.makers.product.model.vo.Product;
import kh.hand.makers.shop.model.vo.Brand;
import kh.hand.makers.shop.model.vo.PreProduct;

public interface AdminDao {

	List<Product> selectProductList(int cPage,int numPerPage);
	List<Brand> selectBrandList(int cPage, int numPerPage);
	int selectProductCount();
	int selectBrandCount();
	int brandStateUpdate(Map<String,String> bs);
	List<managePreProduct> selectPreProductList(int cPage,int numPerPage);
	PreProduct selectPreProduct(String preProductNo);
	int selectPreProductCount();
	int preProductStateUpdate(Map<String,String> ps);
}
