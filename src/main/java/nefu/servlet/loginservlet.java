package nefu.servlet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.*;
import java.util.Objects;

/**
 * Servlet implementation class loginservlet
 */
@WebServlet("/login/loginservlet")
public class loginservlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    /**
     * @see HttpServlet#HttpServlet()
     */
    public loginservlet() {
        super();
        // TODO Auto-generated constructor stub
    }

    /**
     * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
     */
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // TODO Auto-generated method stub
        HttpSession s = request.getSession();
        if(request.getParameter("exit")!=null){
            s.invalidate();
            System.out.println("logout");
        }
        request.getRequestDispatcher("/login/index.jsp").forward(request, response);

    }

    /**
     * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
     */
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // TODO Auto-generated method stub
        HttpSession s1 = request.getSession();
        String user = "";
        String ps = "";
        String psg = "";
        if (request.getParameter("user") != null && request.getParameter("ps") != null) {
            user = request.getParameter("user");
            ps = request.getParameter("ps");
        }
        System.out.println("user:"+user);
        System.out.println("ps:"+ps);
        int time = 0;
//---------------------------------------------------//
        Connection conn;
        Statement stmt;
        ResultSet rs;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
        try {
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306?allowPublicKeyRetrieval=true&serverTimezone=UTC", "root", "root");
            stmt = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
            rs = stmt.executeQuery("SELECT password FROM web.user where user='" + user + "'");
            rs.next();
            psg = rs.getString(1);
            conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
//---------------------------------------------------//
        if(user.equals("admin") && ps.equals("admin")){
            s1.setAttribute("key","3");

            s1.setAttribute("username",user);

            System.out.println("AdministratorLoginsucess");
            response.sendRedirect("/bookStore/admin1/index.jsp");

        }
        else if (psg.equals(ps) && !ps.isEmpty()) {
            Cookie cuser = new Cookie("user", user);
            Cookie cpwd = new Cookie("pwd", ps);
            cuser.setPath("/");
            cpwd.setPath("/");

            if (request.getParameter("remember-me") != null){
                time = 60*60*24;
            }

            System.out.println(time);
            cuser.setMaxAge(time);
            cpwd.setMaxAge(time);

            response.addCookie(cuser);
            response.addCookie(cpwd);

            System.out.println("loginsucess");
            s1.setAttribute("key", "1");

            s1.setAttribute("username",user);

            response.sendRedirect("/bookStore/bookmall/bookmall.jsp");
        } else {
            System.out.println("wrongps");
            s1.setAttribute("key", "2");

            response.sendRedirect("/bookStore/login/loginservlet");
        }

    }

}
