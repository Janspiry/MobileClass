
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;
import util.DatabaseHelper;
import util.MD5Util;
import util.QueryBuilder;

import java.io.*;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

/**
 * Created by silenus on 2019/4/29.
 */
@WebServlet("/AccountAction")
public class AccountAction extends HttpServlet
{
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

        request.setCharacterEncoding("UTF-8");
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        HttpSession session = request.getSession();
        session.removeAttribute("guid");
        session.removeAttribute("username");
        session.removeAttribute("login_time");
        session.removeAttribute("check");

        boolean success=true;
        if(username==null || password==null || password.length()<4)
        {
            success=false;
        }
        for(int i=0; i<username.length() && success; i++)
        {
            char ch=username.charAt(i);
            if(!('A'<=ch && ch<='Z' || 'a'<=ch && ch<='z' || '0'<=ch && ch<='9' || ch=='_'))
            {
                success=false;
            }
        }

        ResultSet rs=null;
        if(success)
        {
            password = MD5Util.MD5(password);

            DatabaseHelper db = new DatabaseHelper();
            String sql = String.format("select * from `userinfo` " +
                            "where `username`='%s' and `password`='%s'",
                    username, password);
            rs = db.executeQuery(sql);
            if(!rs.next()) {
                success = false;
            }
        }

        if(success)
        {
            int guid = rs.getInt("guid");
            int auth = rs.getInt("authorization");

            /**
             * WARNING
             */
            // 辛大师的代码混进来了
            session.setAttribute("user_id", String.valueOf(guid));
            session.setAttribute("user_name", username);
            // emmmmmm

            session.setAttribute("guid", guid);
            session.setAttribute("username", username);
            session.setAttribute("authorization", auth);
            session.setAttribute("login_time", System.currentTimeMillis());
            session.setAttribute("check", (long)1); // reserved
            response.sendRedirect("templates/admin/index.jsp");
        }
        else
        {
            session.setAttribute("username", username);
            response.sendRedirect("templates/admin/login.jsp");
        }
    }

    private void logout(HttpServletRequest request, HttpServletResponse response) throws SQLException, IOException, ServletException {
        System.out.println("enter AccountAction.logout");
        HttpSession session = request.getSession();

        /**
         * WARNING
         */
        // 辛大师的代码混进来了
        session.removeAttribute("user_id");
        session.removeAttribute("user_name");
        // emmmmmm

        session.removeAttribute("guid");
        session.removeAttribute("username");
        session.removeAttribute("login_time");
        session.removeAttribute("authorization");
        session.removeAttribute("check");
        response.sendRedirect("templates/admin/login.jsp");
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
            res.put("errno", 1);
            res.put("msg", "密码不能为空");
        }
        else {
            DatabaseHelper db = new DatabaseHelper();
            String sql = String.format("select guid from userinfo where `email`='%s'", q.getEmail());
            ResultSet rs=db.executeQuery(sql);
            if(rs.next())
            {
                res.put("errno", 1);
                res.put("msg", String.format("邮箱'%s'已经注册", q.getEmail()));
            }
            else {
                password = MD5Util.MD5(password);
                q.setPassword(password);
                sql = q.getInsertStmt();
                System.out.println(sql);
                db.execute(sql);
                res.put("errno", 0);
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

        if(session.getAttribute("guid")==null)
        {
            System.out.println("Authorization.getMenu: error: not login");
            return;
        }
        int auth=(int)session.getAttribute("authorization");
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
