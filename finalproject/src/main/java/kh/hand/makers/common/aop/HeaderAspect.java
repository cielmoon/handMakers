package kh.hand.makers.common.aop;

import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.Signature;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Before;
import org.aspectj.lang.annotation.Pointcut;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;


@Aspect		//얘도 추가됨 aop객체라는걸 알려줌, 위아래 두개가 필요함/
@Component	//bean객체로 등록해줌 2번 @으로 AOP하기에서 추가됨 이전엔 없었음/
public class HeaderAspect {
	
	private Logger logger = LoggerFactory.getLogger(HeaderAspect.class);

	@Pointcut("execution(* kh.hand.makers.*.*(..))")
	public void myBefore() {
		logger.debug("-myBefore -집에가고싶츄- O ____ O;;");
		
	}
	
	@Before("myBefore()")//before Test
	public void beforeAd(JoinPoint joinPoint) {
		Signature sig = joinPoint.getSignature();
		logger.debug("[단독]before !\n"+sig.getDeclaringTypeName()+" : "+sig.getName());
		logger.debug("-집에가고싶츄- O ____ O;;");
	}

}



