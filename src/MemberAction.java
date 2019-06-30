/**
 * Created by silenus on 2019/4/29.
 */
import jxl.Workbook;
import jxl.format.Colour;
import jxl.write.*;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;
import util.DatabaseHelper;
import Member.QueryBuilder;

import java.io.*;
import java.net.URLEncoder;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Objects;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/MemberAction")
public class MemberAction extends HttpServlet
{
    private static QueryBuilder queryBuilder = new QueryBuilder();
    private static JSONArray result = new JSONArray();

    @Override
    public void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
    {
        request.setCharacterEncoding("UTF-8");
        String action = request.getParameter("action");
        System.out.println("MemberAction action="+action);
        try
        {
            switch(action)
            {
                case "getResult":
                    getResult(request, response);
                    break;
                case "add":
                    Add(request, response);
                    break;
                case "delete":
                    Delete(request, response);
                    break;
                case "statistics":
                    Statistics(request, response);
                    break;
                default:
                    throw new Exception("MemberAction: 未知的请求类型");
            }
        }
        catch(Exception ex)
        {
            ex.printStackTrace();
        }
    }

    private void getResult(HttpServletRequest request, HttpServletResponse response) throws JSONException, SQLException, IOException {
        System.out.println("enter MemberAction.getResult");
        response.setContentType("application/json; charset=UTF-8");
        PrintWriter out = response.getWriter();
        queryBuilder.setGroupId(request.getParameter("group_id"));
        String sql=queryBuilder.getSelectStmt();
        DatabaseHelper db=new DatabaseHelper();
        ResultSet rs=db.executeQuery(sql);
        processResult(rs);
        out.print(result);
        out.flush();
        out.close();
    }

    private void Add(HttpServletRequest request, HttpServletResponse response) throws Exception {
        System.out.println("enter MemberAction.Add");
        response.setContentType("application/json; charset=UTF-8");
        PrintWriter out = response.getWriter();
        JSONObject json = new JSONObject();
        DatabaseHelper db=new DatabaseHelper();
        String guid = request.getParameter("owner");
        if(request.getParameter("id_or_email").equals("owner_id")){
            String sql = "select guid from `userinfo` where `guid`="+guid;
            ResultSet rs = db.executeQuery(sql);
            if(!rs.next()){
                json.put("errno", 1);
                json.put("msg", "GUID为\""+guid+"\"的用户不存在");
            }
        }else if(request.getParameter("id_or_email").equals("email")){
            String email = request.getParameter("owner");
            String sql = "select guid from `userinfo` where `email`='"+guid+"'";
            ResultSet rs = db.executeQuery(sql);
            if(!rs.next()){
                json.put("errno", 2);
                json.put("msg", "邮箱为\""+guid+"\"的用户不存在");
            }else{
                guid = rs.getString("guid");
            }
        }else{
            throw new Exception("MemberAction.Add: id_or_email设置不正确");
        }
        if(!json.has("errno")){
            ResultSet rs = db.executeQuery("select * from `groupmember` where `group_id`="+request.getParameter("group_id")+" and `user_id`="+guid);
            if(rs.next()){
                json.put("errno",3);
                json.put("msg","用户已是该组成员");
            }
        }
        if(!json.has("errno")){
            json.put("errno", 0);
            QueryBuilder q = new QueryBuilder();
            q.setGroupId(request.getParameter("group_id"));
            q.setUserId(guid);
            String sql = q.getInsertStmt();
            db.execute(sql);
        }
        out.print(json);
        out.flush();
        out.close();
    }

    private void Delete(HttpServletRequest request, HttpServletResponse response) throws Exception {
        System.out.println("enter MemberAction.doQuery");
        response.setContentType("application/json; charset=UTF-8");
        PrintWriter out = response.getWriter();
        QueryBuilder q=new QueryBuilder();
        q.setGroupId(request.getParameter("group_id"));
        q.setUserId(request.getParameter("user_id"));
        String sql=q.getDeleteStmt();
        DatabaseHelper db=new DatabaseHelper();
        db.execute(sql);
        JSONObject json = new JSONObject();
        json.put("errno", 0);
        out.print(json);
        out.flush();
        out.close();
    }

    private void Statistics(HttpServletRequest request, HttpServletResponse response) throws JSONException, SQLException, IOException {
        System.out.println("enter MemberAction.Statistics");
        String sql = String.format("select " +
                        " gender, " +
                        " count(*) as cnt " +
                        " from (%s) as tmp " +
                        " group by gender ",
                queryBuilder.getSelectStmt());
        System.out.println("MemberAction.Statistics: sql = "+sql);
        DatabaseHelper db=new DatabaseHelper();
        ResultSet rs=db.executeQuery(sql);
        JSONArray list = new JSONArray();
        String[] cla = new String[]{"男", "女"};
        while(rs.next())
        {
            JSONObject item = new JSONObject();
            int gender = rs.getInt("gender");
            item.put("class", cla[gender-1]);
            item.put("count", rs.getString("cnt"));
            list.put(item);
        }
        response.setContentType("application/json; charset=UTF-8");
        PrintWriter out = response.getWriter();
        out.print(list);
        out.flush();
        out.close();
    }

    private void processResult(ResultSet rs) throws JSONException, SQLException {
        result = new JSONArray("[]");
        rs.beforeFirst();
        while(rs.next())
        {
            JSONObject item = new JSONObject();
            item.put("user_id", rs.getString("guid"));
            item.put("username", rs.getString("username"));
            item.put("fullname", rs.getString("fullname"));
            item.put("gender", rs.getInt("gender"));
            item.put("schoolnum", rs.getString("schoolnum"));
            item.put("email", rs.getString("email"));
            item.put("phone", rs.getString("phone"));
            result.put(item);
        }
    }
}