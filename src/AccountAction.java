
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;
import util.DatabaseHelper;
import util.MD5Util;
import util.QueryBuilder;
import java.io.*;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.management.Query;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.util.regex.*;

/**
 * Created by silenus on 2019/4/29.
 */
@WebServlet("/AccountAction")
public class AccountAction extends HttpServlet
{
    private static QueryBuilder queryBuilder = new QueryBuilder("userinfo");

    @Override
    public void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
    {
        request.setCharacterEncoding("UTF-8");
        String action = request.getParameter("action");
        System.out.println("AccountAction action="+action);
        try
        {
            switch(action)
            {
                case "login":
                    login(request, response);
                    break;
                case "logout":
                    logout(request, response);
                    break;
                case "register":
                    register(request, response);
                    break;
                case "getmenu":
                    getMenu(request, response);
                    break;
            }
        }
        catch(Exception ex)
        {
            ex.printStackTrace();
        }
    }

    private void login(HttpServletRequest request, HttpServletResponse response) throws SQLException, IOException, ServletException {
        System.out.println("enter AccountAction.login");

        HttpSession session = request.getSession();
        session.removeAttribute("guid");
        session.removeAttribute("username");
        session.removeAttribute("login_time");
        session.removeAttribute("authorization");
        session.removeAttribute("check");

        request.setCharacterEncoding("UTF-8");
        String email = request.getParameter("email");
        session.setAttribute("email", email);
        String password = request.getParameter("password");

        if(email==null || password==null || email.length()==0 || password.length()==0)
        {
            session.setAttribute("login_errno", 1);
            session.setAttribute("login_msg", "邮箱或密码不能为空");
            response.sendRedirect("login.jsp");
            return;
        }
        if(!Pattern.matches("[_0-9A-Za-z]+@[_0-9A-Za-z]+(\\.com)?", email))
        {
            session.setAttribute("login_errno", 2);
            session.setAttribute("login_msg", "邮箱格式不正确");
            response.sendRedirect("login.jsp");
            return;
        }

        ResultSet rs=null;
        password = MD5Util.MD5(password);
        queryBuilder.clear();
        queryBuilder.setEmail(email);
        queryBuilder.setPassword(password);
        DatabaseHelper db = new DatabaseHelper();
        String sql=queryBuilder.getSelectStmt();
        rs = db.executeQuery(sql);
        if(!rs.next()) {
            session.setAttribute("login_errno", 3);
            session.setAttribute("login_msg", "邮箱或密码错误");
            response.sendRedirect("login.jsp");
            return;
        }

        session.setAttribute("guid", Integer.toString(rs.getInt("guid")));
        session.setAttribute("username", rs.getString("username"));
        session.setAttribute("authorization", rs.getInt("authorization"));
        session.setAttribute("login_time", System.currentTimeMillis());
        session.setAttribute("check", (long)1); // reserved
        session.setAttribute("login_errno", 0);
        response.sendRedirect("index.jsp");
    }

    private void logout(HttpServletRequest request, HttpServletResponse response) throws SQLException, IOException, ServletException {
        System.out.println("enter AccountAction.logout");
        HttpSession session = request.getSession();

        session.removeAttribute("guid");
        session.removeAttribute("username");
        session.removeAttribute("login_time");
        session.removeAttribute("authorization");
        session.removeAttribute("check");
        response.sendRedirect("login.jsp");
    }

    private void register(HttpServletRequest request, HttpServletResponse response) throws IOException, JSONException, ServletException, SQLException {
        System.out.println("enter AccountAction.register");

        request.setCharacterEncoding("UTF-8");
        QueryBuilder q = new QueryBuilder("userinfo");
        q.setUsername(request.getParameter("username"));
        q.setEmail(request.getParameter("email"));
        q.setPhone(request.getParameter("phone"));
        q.setFullname(request.getParameter("fullname"));
        q.setGender(request.getParameter("gender"));
        q.setSchoolnum(request.getParameter("schoolnum"));
        q.setNativeplace(request.getParameter("nativeplace"));
        String password = request.getParameter("password");

        JSONObject res = new JSONObject();
        if (password == null || password.length() == 0)
        {
            res.put("register_errno", 1);
            res.put("register_msg", "密码不能为空");
        }
        else {
            DatabaseHelper db = new DatabaseHelper();
            String sql = String.format("select guid from userinfo where `email`='%s'", q.getEmail());
            ResultSet rs=db.executeQuery(sql);
            if(rs.next())
            {
                res.put("register_errno", 2);
                res.put("register_msg", String.format("邮箱\"%s\"已经注册", q.getEmail()));
            }
            else {
                password = MD5Util.MD5(password);
                q.setPassword(password);
                sql = q.getInsertStmt();
                System.out.println(sql);
                db.execute(sql);
                res.put("register_errno", 0);
            }
        }
        response.setContentType("application/json; charset=UTF-8");
        PrintWriter out = response.getWriter();
        out.print(res);
        out.flush();
        out.close();
    }

    private void getMenu(HttpServletRequest request, HttpServletResponse response) throws SQLException, JSONException, IOException {
        System.out.println("enter AccountAction.getMenu");

        HttpSession session = request.getSession();
        DatabaseHelper db=new DatabaseHelper();

//        if(session.getAttribute("guid")==null)
//        {
//            System.out.println("Authorization.getMenu: error: not login");
//            return;
//        }
//        int auth=(int)session.getAttribute("authorization");
        int auth=15;
        System.out.printf("auth = %d\n", auth);

        String sql=String.format("select * from `menu_tree` where authorization&%d>0", auth);
        System.out.println(sql);
        ResultSet rs2 =db.executeQuery(sql);
        JSONArray menu=new JSONArray();
        while(rs2.next())
        {
            if(rs2.getString("parent")==null)
            {
                JSONObject header=new JSONObject();
                header.put("title", rs2.getString("title"));
                header.put("sub", new JSONArray());
                menu.put(rs2.getInt("id"), header);
            }
        }
        rs2.beforeFirst();
        while(rs2.next())
        {
            if(rs2.getString("parent")!=null)
            {
                JSONObject item=new JSONObject();
                int parent = rs2.getInt("parent");
                item.put("title", rs2.getString("title"));
                item.put("href", rs2.getString("href").length()>0 ? rs2.getString("href") : "#");
                ((JSONArray)(((JSONObject)(menu.get(parent))).get("sub"))).put(item);
            }
        }

        response.setContentType("application/json; charset=UTF-8");
        PrintWriter out = response.getWriter();
        out.print(menu);
        out.flush();
        out.close();

        System.out.println("exit AccountAction.getMenu");
    }

}
