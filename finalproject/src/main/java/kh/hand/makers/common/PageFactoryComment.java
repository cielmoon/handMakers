package kh.hand.makers.common;

public class PageFactoryComment {

	public static String getPageBar(int totalCon, int cPage, int numPerPage, String url, String productNo, String commentType)
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
					+ "href='javascript:fn_review("+pageNo+")'>"
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
						+ "href='javascript:fn_review("+pageNo+")'>"
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
					+ "href='javascript:fn_review("+pageNo+")'>"
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
		
		/*pageBar+="<script>";
		pageBar+="function fn_paging(cPage){";
		pageBar+="$.ajax({";
		pageBar+="url:'${path}/product/selectComment.do',";
		pageBar+="data:{'productNo':productNo, 'commentType':commentType},";
		pageBar+="success:function(data){";
		pageBar+="console.log(data);";
		pageBar+="var pageBar = data.pageBar";
		pageBar+="var commentList = data.commentList";
		pageBar+="var table = $('<table id=>')"
		pageBar+="$.ajax({";
		pageBar+="url:'${path}/product/selectComment.do',";
		pageBar+="data:{'productNo':productNo, 'commentType':commentType},";
		pageBar+="success:function(data){";
		pageBar+="console.log(data);";
		pageBar+="});}";
		pageBar+="location.href='"+url+"&cPage='+cPage";
		pageBar+="}";
		pageBar+="</script>";
		*/
		return pageBar;		
			

	}
}
