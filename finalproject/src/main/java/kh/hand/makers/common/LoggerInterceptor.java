package kh.hand.makers.common;

import javax.servlet.http.HttpServletRequest;

import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

public class LoggerInterceptor extends HandlerInterceptorAdapter {

	//로그를 남겨보자 log4j slf4j를 이용해보자!
	private Logger logger=LoggerFactory.getLogger(LoggerInterceptor.class);
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		
		if(logger.isDebugEnabled())
		{
			logger.debug("============start============");
			logger.debug(request.getRequestURI());
			logger.debug("-----------------------------");
		}		
		if(request.getSession().getAttribute("member")==null)
		{
			request.setAttribute("msg", "로그인이 필요한 페이지입니다.");
			request.setAttribute("loc", "/");
			request.getRequestDispatcher("/WEB-INF/views/common/msg.jsp")
			.forward(request, response);
			/*response.sendRedirect("spring");*/
			return false;
		}		
		else {
			return super.preHandle(request, response, handler);
		}
	}

	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
			ModelAndView modelAndView) throws Exception {
		if(logger.isDebugEnabled())
		{
			logger.debug("==============view============");
			logger.debug("------------------------------");
		}
		super.postHandle(request, response, handler, modelAndView);
	}

	@Override
	public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex)
			throws Exception {
		
		logger.debug("==============end============");
		
		
		
		super.afterCompletion(request, response, handler, ex);
	}

	
	
	
	
	
	
}
