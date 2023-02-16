package today.whatdo.festival.festivalinfo.config;

import java.util.Collections;
import java.util.HashMap;
import java.util.Map;

import org.aspectj.lang.annotation.Aspect;
import org.springframework.aop.Advisor;
import org.springframework.aop.aspectj.AspectJExpressionPointcut;
import org.springframework.aop.support.DefaultPointcutAdvisor;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.transaction.PlatformTransactionManager;
import org.springframework.transaction.TransactionDefinition;
import org.springframework.transaction.interceptor.NameMatchTransactionAttributeSource;
import org.springframework.transaction.interceptor.RollbackRuleAttribute;
import org.springframework.transaction.interceptor.RuleBasedTransactionAttribute;
import org.springframework.transaction.interceptor.TransactionAttribute;
import org.springframework.transaction.interceptor.TransactionInterceptor;

import lombok.AllArgsConstructor;

@Configuration
@AllArgsConstructor
@Aspect
//AOP or Config
public class TransactionConfig {
	
	//롬복을 쓰면 아래처럼 안해줘도 된다.
//	private final PlatformTransactionManager platformTransactionManager;
	
//	public TransactionConfig(@Autowired PlatformTransactionManager platformTransactionManager) {
//		this.platformTransactionManager = platformTransactionManager;s
//	}
	
	//@Autowired 대신 @AllArgsConstructor 사용
	private final PlatformTransactionManager platformTransactionManager;
	
	@Bean
	Advisor advisor() {
		AspectJExpressionPointcut pointcut = new AspectJExpressionPointcut();
		pointcut.setExpression("execution(* today.whatdopersonal.festival..*Service.*(..))");
		return new DefaultPointcutAdvisor(pointcut, interceptor());
	}
	
	@Bean
	TransactionInterceptor interceptor() {
		TransactionInterceptor interceptor = new TransactionInterceptor();
		NameMatchTransactionAttributeSource nmtab = new NameMatchTransactionAttributeSource();
		RuleBasedTransactionAttribute rbta = new RuleBasedTransactionAttribute();
		RollbackRuleAttribute rra = new RollbackRuleAttribute(Exception.class);
		
		rbta.setRollbackRules(Collections.singletonList(rra));
		rbta.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRED);
		
		Map<String,TransactionAttribute> tranMap = new HashMap<>();
		tranMap.put("*", rbta);
		nmtab.setNameMap(tranMap);
		interceptor.setTransactionAttributeSource(nmtab);
		interceptor.setTransactionManager(platformTransactionManager);
		return interceptor;
	}
}
