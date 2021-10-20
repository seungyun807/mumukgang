package egovframework.mumukgang.cmmn.web;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;
import org.springframework.ui.ModelMap;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

@Component
public class MyInterceptor extends HandlerInterceptorAdapter{

	private static final String LOGIN = "login";
	private Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
		HttpSession httpSession = request.getSession();
		
		String loginId = (String)request.getSession().getAttribute("user");
		System.out.println("preHandle >>>  Controller 실행 전 실행");
		if(loginId != null) {return true;}
		else {
			String destUri = request.getRequestURI();
            String destQuery = request.getQueryString();
            String dest = (destQuery == null) ? destUri : destUri+"?"+destQuery;
            request.getSession().setAttribute("dest", dest);
        
            response.sendRedirect("/loginview.do");
            return false;
		}
        
    }
 
    @Override
    public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler, ModelAndView modelAndView) throws Exception {
    	HttpSession httpSession = request.getSession();
    	String loginId = (String)request.getSession().getAttribute("user");
    	
    	//ModelMap modelMap = modelAndView.getModelMap();

    	Object userVO = loginId;
    	System.out.println("userVO = " + userVO);
    	if (userVO != null) {
    		
    		logger.info("new login success");
    		httpSession.setAttribute(LOGIN, userVO);
    	}
    	System.out.println("postHandle >>>  Controller 실행 후 실행");
    }
 
    @Override
    public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex){
        System.out.println("afterCompletion >>>  preHandle 메소드 return값이 true일 때 실행");
    }
    

	
}
