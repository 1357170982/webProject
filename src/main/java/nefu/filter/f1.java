package nefu.filter;

import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

/**
 * Servlet Filter implementation class f1
 */
//@WebFilter("/*")
public class f1 extends HttpFilter implements Filter {


    /**
     * @see HttpFilter#HttpFilter()
     */
    public f1() {
        super();
        // TODO Auto-generated constructor stub
    }

    /**
     * @see Filter#destroy()
     */
    public void destroy() {
        // TODO Auto-generated method stub
    }

    /**
     * @see Filter#doFilter(ServletRequest, ServletResponse, FilterChain)
     */
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
        // TODO Auto-generated method stub
        // place your code here

        // pass the request along the filter chain

        String url = "loginservlet";
        String url1 = "register";
        HttpServletRequest r1 = (HttpServletRequest) request;
        HttpServletResponse r2 = (HttpServletResponse) response;
        r1.setCharacterEncoding("utf-8");
        r2.setCharacterEncoding("utf-8");
        r2.setContentType("text/html;charset=utf-8");
        HttpSession s1 = r1.getSession();
        if (s1.getAttribute("key") != null) {
            if (s1.getAttribute("key").equals("1") || s1.getAttribute("key").equals("3")) {
                chain.doFilter(request, response);
            }
            if (s1.getAttribute("key").equals("2")) {
                r2.getWriter().append("您输入的用户名密码错误，请您重新输入<a href='/bookStore/login/loginservlet'>重新登陆</a>");
            }
        } else if (r1.getRequestURI().contains(url) || r1.getRequestURI().contains(url1)) {
            chain.doFilter(request, response);
        } else {
            r2.sendRedirect("/bookStore/login/loginservlet");
        }
    }

    /**
     * @see Filter#init(FilterConfig)
     */
    public void init(FilterConfig fConfig) throws ServletException {
        // TODO Auto-generated method stub
    }
}
