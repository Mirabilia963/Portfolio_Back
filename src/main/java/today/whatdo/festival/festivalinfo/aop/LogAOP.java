package today.whatdo.festival.festivalinfo.aop;

import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.After;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Before;
import org.springframework.stereotype.Component;

import lombok.extern.slf4j.Slf4j;

@Component
@Aspect
@Slf4j
public class LogAOP {
	
	//AOP를 사용해서 간단하게 컨트롤러 또는 서비스의 실행 시간을 구할 수 있다.
	
	@Around("execution( * today.whatdopersonal.festival.controller..*Controller.*(..))")
	//Around라서 컨트롤러가 실행하기 전에 실행
	//execution할 건데
	//( * ) => 접근 제어자 상관 없고, 리턴 타입 상관 없다는 뜻
	//패키지는 today.whatdopersonal.festival.controller여야 하고,
	//.. 때문에 앞의 패키지 안에 다른 패키지가 있어도 상관 없다.
	//*Controller => 파일이 Controller로 끝나야하며,
	//*(..) => 메소드명 상관 없고, 매개변수 상관 없다.
	public Object aroundController(ProceedingJoinPoint pjp) throws Throwable {
		//아래 getSignatureInfo 활용
		String signatureInfo = getSignatureInfo(pjp);
		log.debug("start=>{}",signatureInfo);
		//원래 System.currentTimeMillis() 안쓴다. / 보통 스탑워치를 사용
		long sTime = System.currentTimeMillis();
		Object obj = pjp.proceed();
		long eTime = System.currentTimeMillis();
		log.debug("end=>{}",signatureInfo);
		log.debug("execute time=>{}",(eTime-sTime)/1000.00);
		return obj;
	}
	
	@Before("within(@org.springframework.web.bind.annotation.RestController *)")
	//@restController가 있는 애들은 전부
	//pjp.proceed() 전에 실행된다.
	public void beforeController(JoinPoint joinPoint) {
		log.debug("beforeController");
	}
	
	@After("within(@org.springframework.web.bind.annotation.RestController *)")
	//@restController가 있는 애들은 전부
	//pjp.proceed() 후에 실행된다.
	public void afterController(JoinPoint joinPoint) {
		log.debug("afterController");
	}
	
	//선생님이 직접 만드신 코드
	//어떤 컨트롤러에, 어떤 메소드에서 시작됐는지 정보 찍는 코드
	private String getSignatureInfo(JoinPoint joinPoint) {
		String signatureName = joinPoint.getSignature().getName();
		String className = joinPoint.getTarget().getClass().getSimpleName();
		StringBuilder sb = new StringBuilder();
		sb.append(className).append('.').append(signatureName).append('(');
		Object[] args = joinPoint.getArgs();
		if (args != null && args.length > 0) {
			for (int i = 0; i < args.length; i++) {
				if (args[i] instanceof String)
					sb.append('\"');
				sb.append(args[i]);
				if (args[i] instanceof String)
					sb.append('\"');
				if (i < args.length - 1) {
					sb.append(',');
				}
			}
		}
		sb.append(')');
		return sb.toString();
	}

}
