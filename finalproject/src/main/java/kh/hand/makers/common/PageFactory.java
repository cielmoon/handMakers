package kh.hand.makers.common;

public class PageFactory {

	public static String getPageBar(int totalCon, int cPage, int numPerPage, String url)
	{
		String pageBar="";
		int pageBarSize=5;
		
		int pageNo=((cPage-1)/pageBarSize)*pageBarSize+1;
		int pageEnd=pageNo+pageBarSize-1;
		int totalPage=(int)Math.ceil((double)totalCon/numPerPage);
		
		pageBar="<ul class='pagination "
				+ "justify-content-center "
				+ "pagination-sm'>";
		if(pageNo==1)
		{
			pageBar+="<li class='page-item' disabled>";
			pageBar+="<a class='page-link' href='#' tabindex='-1'>이전</a>";
			pageBar+="</li>";
		}
		else {
			pageBar+="<li class='page-item'>";
			pageBar+="<a class='page-link' "
					+ "href='javascript:fn_paging("+(pageNo-1)+")'>"
							+ "이전</a>";
			pageBar+="</li>";
		}
		
		while(!(pageNo>pageEnd||pageNo>totalPage))
		{
			if(pageNo==cPage)
			{
				pageBar+="<li class='page-item active'>";
				pageBar+="<a class='page-link'>"+pageNo+"</a>";
				pageBar+="</li>";
			}
			else 
			{
				pageBar+="<li class='page-item'>";
				pageBar+="<a class='page-link' "
						+ "href='javascript:fn_paging("+pageNo+")'>"
								+pageNo+"</a>";
				pageBar+="</li>";
			}
			pageNo++;
		}
		
		if(pageNo>totalPage)
		{
			pageBar+="<li class='page-item' disabled>";
			pageBar+="<a class='page-link' href='#'>다음</a>";
			pageBar+="</li>";
		}
		else {
			pageBar+="<li class='page-item'>";
			pageBar+="<a class='page-link' "
					+ "href='javascript:fn_paging("+(pageNo)+")'>"
							+ "다음</a>";
			pageBar+="</li>";
		}
		pageBar+="</ul>";
		
		//paging처리 script작성
		pageBar+="<script>";
		pageBar+="function fn_paging(cPage){";
		pageBar+="location.href='"+url+"?cPage='+cPage";
		pageBar+="}";
		pageBar+="</script>";
				
		return pageBar;		
		
	}
	
	// 다른 조건이 있는 페이지바
	public static String getConditionPageBar(int totalCon, int cPage, int numPerPage, String url)
	{
		String pageBar="";
		int pageBarSize=5;
		
		int pageNo=((cPage-1)/pageBarSize)*pageBarSize+1;
		int pageEnd=pageNo+pageBarSize-1;
		int totalPage=(int)Math.ceil((double)totalCon/numPerPage);
		
		pageBar="<ul class='pagination "
				+ "justify-content-center "
				+ "pagination-sm'>";
		if(pageNo==1)
		{
			pageBar+="<li class='page-item' disabled>";
			pageBar+="<a class='page-link' href='#' tabindex='-1'>이전</a>";
			pageBar+="</li>";
		}
		else {
			pageBar+="<li class='page-item'>";
			pageBar+="<a class='page-link' "
					+ "href='javascript:fn_paging("+(pageNo-1)+")'>"
							+ "이전</a>";
			pageBar+="</li>";
		}
		
		while(!(pageNo>pageEnd||pageNo>totalPage))
		{
			if(pageNo==cPage)
			{
				pageBar+="<li class='page-item active'>";
				pageBar+="<a class='page-link'>"+pageNo+"</a>";
				pageBar+="</li>";
			}
			else 
			{
				pageBar+="<li class='page-item'>";
				pageBar+="<a class='page-link' "
						+ "href='javascript:fn_paging("+pageNo+")'>"
								+pageNo+"</a>";
				pageBar+="</li>";
			}
			pageNo++;
		}
		
		if(pageNo>totalPage)
		{
			pageBar+="<li class='page-item' disabled>";
			pageBar+="<a class='page-link' href='#'>다음</a>";
			pageBar+="</li>";
		}
		else {
			pageBar+="<li class='page-item'>";
			pageBar+="<a class='page-link' "
					+ "href='javascript:fn_paging("+(pageNo)+")'>"
							+ "다음</a>";
			pageBar+="</li>";
		}
		pageBar+="</ul>";
		
		//paging처리 script작성
		pageBar+="<script>";
		pageBar+="function fn_paging(cPage){";
		pageBar+="location.href='"+url+"&cPage='+cPage";
		pageBar+="}";
		pageBar+="</script>";
				
		return pageBar;		
		
	}
	
	// 상품 상세 페이지 페이지바
		public static String getConditionProductPageBar(int totalCon, int cPage, int numPerPage, String url, String type)
		{
			String pageBar="";
			int pageBarSize=5;
			
			int pageNo=((cPage-1)/pageBarSize)*pageBarSize+1;
			int pageEnd=pageNo+pageBarSize-1;
			int totalPage=(int)Math.ceil((double)totalCon/numPerPage);
			
			pageBar="<ul class='pagination "
					+ "justify-content-center "
					+ "pagination-sm'>";
			if(pageNo==1)
			{
				pageBar+="<li class='page-item' disabled>";
				pageBar+="<a class='page-link' href='#' tabindex='-1'>이전</a>";
				pageBar+="</li>";
			}
			else {
				pageBar+="<li class='page-item'>";
				pageBar+="<a class='page-link' "
						+ "href='javascript:fn_paging("+(pageNo-1)+")'>"
								+ "이전</a>";
				pageBar+="</li>";
			}
			
			while(!(pageNo>pageEnd||pageNo>totalPage))
			{
				if(pageNo==cPage)
				{
					pageBar+="<li class='page-item active'>";
					pageBar+="<a class='page-link'>"+pageNo+"</a>";
					pageBar+="</li>";
				}
				else 
				{
					pageBar+="<li class='page-item'>";
					pageBar+="<a class='page-link' "
							+ "href='javascript:fn_paging("+pageNo+")'>"
									+pageNo+"</a>";
					pageBar+="</li>";
				}
				pageNo++;
			}
			
			if(pageNo>totalPage)
			{
				pageBar+="<li class='page-item' disabled>";
				pageBar+="<a class='page-link' href='#'>다음</a>";
				pageBar+="</li>";
			}
			else {
				pageBar+="<li class='page-item'>";
				pageBar+="<a class='page-link' "
						+ "href='javascript:fn_paging("+(pageNo)+")'>"
								+ "다음</a>";
				pageBar+="</li>";
			}
			pageBar+="</ul>";
			
			//paging처리 script작성
			pageBar+="<script>";
			pageBar+="function fn_paging(cPage){";
			
			if(type.equals("R")) pageBar+="location.href='"+url+"&rcPage='+cPage";
			else pageBar+="location.href='"+url+"&qcPage='+cPage";
			
			pageBar+="}";
			pageBar+="</script>";
					
			return pageBar;		
			
		}
		
		public static String getManageProductPageBar(int totalCon, int cPage, int numPerPage, String brandNo, String bcNo, String scNo,String url)
		{
			String pageBar="";
			int pageBarSize=5;
			
			int pageNo=((cPage-1)/pageBarSize)*pageBarSize+1;
			int pageEnd=pageNo+pageBarSize-1;
			int totalPage=(int)Math.ceil((double)totalCon/numPerPage);
			
			pageBar="<ul class='pagination "
					+ "justify-content-center "
					+ "pagination-sm'>";
			if(pageNo==1)
			{
				pageBar+="<li class='page-item' disabled>";
				pageBar+="<a class='page-link' href='#' tabindex='-1'>이전</a>";
				pageBar+="</li>";
			}
			else {
				pageBar+="<li class='page-item'>";
				pageBar+="<a class='page-link' "
						+ "href='javascript:fn_paging("+(pageNo-1)+")'>"
								+ "이전</a>";
				pageBar+="</li>";
			}
			
			while(!(pageNo>pageEnd||pageNo>totalPage))
			{
				if(pageNo==cPage)
				{
					pageBar+="<li class='page-item active'>";
					pageBar+="<a class='page-link'>"+pageNo+"</a>";
					pageBar+="</li>";
				}
				else 
				{
					pageBar+="<li class='page-item'>";
					pageBar+="<a class='page-link' "
							+ "href='javascript:fn_paging("+pageNo+")'>"
									+pageNo+"</a>";
					pageBar+="</li>";
				}
				pageNo++;
			}
			
			if(pageNo>totalPage)
			{
				pageBar+="<li class='page-item' disabled>";
				pageBar+="<a class='page-link' href='#'>다음</a>";
				pageBar+="</li>";
			}
			else {
				pageBar+="<li class='page-item'>";
				pageBar+="<a class='page-link' "
						+ "href='javascript:fn_paging("+(pageNo)+")'>"
								+ "다음</a>";
				pageBar+="</li>";
			}
			pageBar+="</ul>";
			
			//paging처리 script작성				
			pageBar+="<script>";
			pageBar+="function fn_paging(cPage){";
			pageBar+=" manageProductAjax(cPage);";
			pageBar+="}";
			pageBar+="</script>";
			
			return pageBar;		
		
		}
		public static String getManageRequestBrandPageBar(int totalCon, int cPage, int numPerPage, String state, String url)
		{
			String pageBar="";
			int pageBarSize=5;
			
			int pageNo=((cPage-1)/pageBarSize)*pageBarSize+1;
			int pageEnd=pageNo+pageBarSize-1;
			int totalPage=(int)Math.ceil((double)totalCon/numPerPage);
			
			pageBar="<ul class='pagination "
					+ "justify-content-center "
					+ "pagination-sm'>";
			if(pageNo==1)
			{
				pageBar+="<li class='page-item' disabled>";
				pageBar+="<a class='page-link' href='#' tabindex='-1'>이전</a>";
				pageBar+="</li>";
			}
			else {
				pageBar+="<li class='page-item'>";
				pageBar+="<a class='page-link' "
						+ "href='javascript:fn_paging("+(pageNo-1)+")'>"
								+ "이전</a>";
				pageBar+="</li>";
			}
			
			while(!(pageNo>pageEnd||pageNo>totalPage))
			{
				if(pageNo==cPage)
				{
					pageBar+="<li class='page-item active'>";
					pageBar+="<a class='page-link'>"+pageNo+"</a>";
					pageBar+="</li>";
				}
				else 
				{
					pageBar+="<li class='page-item'>";
					pageBar+="<a class='page-link' "
							+ "href='javascript:fn_paging("+pageNo+")'>"
									+pageNo+"</a>";
					pageBar+="</li>";
				}
				pageNo++;
			}
			
			if(pageNo>totalPage)
			{
				pageBar+="<li class='page-item' disabled>";
				pageBar+="<a class='page-link' href='#'>다음</a>";
				pageBar+="</li>";
			}
			else {
				pageBar+="<li class='page-item'>";
				pageBar+="<a class='page-link' "
						+ "href='javascript:fn_paging("+(pageNo)+")'>"
								+ "다음</a>";
				pageBar+="</li>";
			}
			pageBar+="</ul>";
			
			//paging처리 script작성				
			pageBar+="<script>";
			pageBar+="function fn_paging(cPage){";
			pageBar+=" manageRequestAjaxBrand(cPage);";
			pageBar+="}";
			pageBar+="</script>";
			
			return pageBar;		
		
		}
		public static String getManageRequestProductPageBar(int totalCon, int cPage, int numPerPage, String state, String url)
		{
			String pageBar="";
			int pageBarSize=5;
			
			int pageNo=((cPage-1)/pageBarSize)*pageBarSize+1;
			int pageEnd=pageNo+pageBarSize-1;
			int totalPage=(int)Math.ceil((double)totalCon/numPerPage);
			
			pageBar="<ul class='pagination "
					+ "justify-content-center "
					+ "pagination-sm'>";
			if(pageNo==1)
			{
				pageBar+="<li class='page-item' disabled>";
				pageBar+="<a class='page-link' href='#' tabindex='-1'>이전</a>";
				pageBar+="</li>";
			}
			else {
				pageBar+="<li class='page-item'>";
				pageBar+="<a class='page-link' "
						+ "href='javascript:fn_paging("+(pageNo-1)+")'>"
								+ "이전</a>";
				pageBar+="</li>";
			}
			
			while(!(pageNo>pageEnd||pageNo>totalPage))
			{
				if(pageNo==cPage)
				{
					pageBar+="<li class='page-item active'>";
					pageBar+="<a class='page-link'>"+pageNo+"</a>";
					pageBar+="</li>";
				}
				else 
				{
					pageBar+="<li class='page-item'>";
					pageBar+="<a class='page-link' "
							+ "href='javascript:fn_paging("+pageNo+")'>"
									+pageNo+"</a>";
					pageBar+="</li>";
				}
				pageNo++;
			}
			
			if(pageNo>totalPage)
			{
				pageBar+="<li class='page-item' disabled>";
				pageBar+="<a class='page-link' href='#'>다음</a>";
				pageBar+="</li>";
			}
			else {
				pageBar+="<li class='page-item'>";
				pageBar+="<a class='page-link' "
						+ "href='javascript:fn_paging("+(pageNo)+")'>"
								+ "다음</a>";
				pageBar+="</li>";
			}
			pageBar+="</ul>";
			
			//paging처리 script작성				
			pageBar+="<script>";
			pageBar+="function fn_paging(cPage){";
			pageBar+=" manageRequestAjaxProduct(cPage);";
			pageBar+="}";
			pageBar+="</script>";
			
			return pageBar;		
		
		}
}
