package com.xiaoxie.library.interceptor;

import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@Component
public class LoginInterceptor implements HandlerInterceptor  {

    @Override
    public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex) throws Exception {
        System.out.println("渲染视图完成之后执行...");
    }

    @Override
    public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler, ModelAndView modelAndView) throws Exception {
        System.out.println("控制器方法执行之后执行...");
    }

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        System.out.println("控制器方法执行之前执行...");
        //已经登录了就放行 否则进行拦截
        HttpSession session=request.getSession();
        if(session.getAttribute("name") != null && session.getAttribute("name") != ""){
            return true;//放行
        }else{
            //没有登录 跳转到登录页面进行登录操作
            response.sendRedirect(request.getContextPath()+"/");
            return false;
        }
    }
}
