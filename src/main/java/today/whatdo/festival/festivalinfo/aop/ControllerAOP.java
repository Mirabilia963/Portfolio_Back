package today.whatdo.festival.festivalinfo.aop;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Component;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import lombok.extern.slf4j.Slf4j;

@Component
@Aspect
@Slf4j
public class ControllerAOP {
	//session값이 없으면 로그인 페이지로 보내기
	
	//리턴타입으로 aop 선택 가능[ * or String 등]
	@Around("@annotation(today.whatdo.festival.festivalinfo.anno.CheckAuth)")
	public Object aroundController(ProceedingJoinPoint pjp) throws Throwable {
		ServletRequestAttributes reqAttr = (ServletRequestAttributes) RequestContextHolder.getRequestAttributes();
		HttpServletRequest req = reqAttr.getRequest();
		HttpSession session = req.getSession();
		if(session.getAttribute("userInfo")==null) {
			return new ResponseEntity<>("로그인 해주세요!!!", HttpStatus.UNAUTHORIZED);
		}
		return pjp.proceed();
	}
	
	//지금은 ViewsController에서 goPage를 찝어서 하는 것
	//이렇게 하나만 할 거라면 goPage에서 하면 된다.
	//이렇게 하는 건 AOP 개념이 아니기 때문
	@Around("execution( * today.whatdo.festival.festivalinfo.controller.ViewsController.goPage(..))")
	public Object viewAuthCheck(ProceedingJoinPoint pjp) throws Throwable {
		//@Around 때문에 ProceedingJoinPoint 값만 받을 수 있다.
		//session scope를 가져올 수 없음
		ServletRequestAttributes reqAttr = (ServletRequestAttributes) RequestContextHolder.getRequestAttributes();
		HttpServletRequest req = reqAttr.getRequest();
		HttpSession session = req.getSession();
		String uri = req.getRequestURI();
		//session scope에 정보가 없을 경우 로그인 페이지로 이동
		//사용자한테 알려주려면 alert.jsp로 가거나 ${msg}로 알려주기
		//폴더 직접 체크 대신 리스트로 체크해도 된다.
		//현재는 마이 리스트만
		if(uri.startsWith("/views/my-list/") && session.getAttribute("userInfo")==null) {
			req.setAttribute("msg", "로그인을 해야만 접근 가능합니다.");
			return "views/user-info/login";
		}
		return pjp.proceed();
	}
}
