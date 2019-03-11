package kh.hand.makers.product.model.dao;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kh.hand.makers.product.model.vo.Product2;

@Repository
public class ProductDaoImpl implements ProductDao {
	
	@Autowired
	SqlSession session;

	@Override
	public List<Map<String, Object>> selectCategoryTemp(String category) {
		// TODO Auto-generated method stub
		
		List<Map<String, Object>> list = new ArrayList();
		Product2 product = new Product2("01", "testTitle", new Date(), new Date(), new Date(), "detail", "comment", "nomal", "step", 12345, 369, 1212, "bigCategory", "smallCategory", "brandNo", "adminNo", "memberNo", 2, 9, 4.5);
		Map<String, Object> map = new HashMap();
		map.put("product", product);
		System.out.println(map);
		list.add(map);
		
		return list;
	}
	
	

}
