package kh.hand.makers.admin.model.service;

import java.util.List;
import java.util.Map;

public interface AdminService {
	List<Map<String,String>> selectProductList(int cPage,int numPerPage);
	int selectProductCount();
}
