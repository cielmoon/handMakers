package kh.hand.makers.admin.model.dao;

import java.util.List;
import java.util.Map;

public interface AdminDao {

	List<Map<String,String>> selectProductList(int cPage, int numPerPage);
	int selectProductCount();
}
