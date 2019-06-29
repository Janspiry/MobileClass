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
import ClassGroup.QueryBuilder;

import java.io.*;
import java.net.URLEncoder;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Objects;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/ClassGroupAction")
public class ClassGroupAction extends HttpServlet
{
    private static QueryBuilder queryBuilder = new QueryBuilder();
    private static JSONArray result = new JSONArray();

    @Override
    public void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
    {
        request.setCharacterEncoding("UTF-8");
        String action = request.getParameter("action");
        System.out.println("ClassGroupAction action="+action);
        try
        {
            switch(action)
            {
                case "getResult":
                    getResult(request, response);
                    break;
                case "query":
                    doQuery(request, response);
                    break;
                case "add":
                    Add(request, response);
                    break;
                case "delete":
                    Delete(request, response);
                    break;
                case "update":
                    Update(request, response);
                    break;
                case "sort":
                    Sort(request, response);
                    break;
                case "statistics":
                    Statistics(request, response);
                    break;
                case "clearQuery":
                    ClearQuery();
                    break;
                case "clearSort":
                    ClearSort();
                    break;
                default:
                    throw new Exception("ClassGroupAction: 未知的请求类型");
            }
        }
        catch(Exception ex)
        {
            ex.printStackTrace();
        }
    }

    private void getResult(HttpServletRequest request, HttpServletResponse response) throws JSONException, SQLException, IOException {
        System.out.println("enter ClassGroupAction.getResult");
        response.setContentType("application/json; charset=UTF-8");
        PrintWriter out = response.getWriter();
        String sql=queryBuilder.getSelectStmt();
        DatabaseHelper db=new DatabaseHelper();
        ResultSet rs=db.executeQuery(sql);
        processResult(rs);
        out.print(result);
        out.flush();
        out.close();
    }

    private void doQuery(HttpServletRequest request, HttpServletResponse response) throws JSONException, SQLException, IOException{
        System.out.println("enter ClassGroupAction.doQuery");
        response.setContentType("application/json; charset=UTF-8");
        PrintWriter out = response.getWriter();
        queryBuilder.clear();

        queryBuilder.setGroupId(request.getParameter("group_id"));
        queryBuilder.setGroupName(request.getParameter("group_name"));
        queryBuilder.setOwnerId(request.getParameter("owner_id"));
        queryBuilder.setUsername(request.getParameter("username"));
        queryBuilder.setEmail(request.getParameter("email"));

        JSONObject json = new JSONObject();
        json.put("errno", 0);
        out.print(json);
        out.flush();
        out.close();
    }

    private void Add(HttpServletRequest request, HttpServletResponse response) throws Exception {
        System.out.println("enter ClassGroupAction.Add");
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
            throw new Exception("ClassGroupAction.Add: id_or_email设置不正确");
        }
        if(!json.has("errno")){
            json.put("errno", 0);
            QueryBuilder q = new QueryBuilder();
            q.setGroupName(request.getParameter("group_name"));
            q.setOwnerId(guid);
            String sql = q.getInsertStmt();
            db.execute(sql);
        }
        out.print(json);
        out.flush();
        out.close();
    }

    private void Delete(HttpServletRequest request, HttpServletResponse response) throws Exception {
        System.out.println("enter ClassGroupAction.doQuery");
        response.setContentType("application/json; charset=UTF-8");
        PrintWriter out = response.getWriter();
        QueryBuilder q=new QueryBuilder();
        q.setGroupId(request.getParameter("group_id"));
        String sql=q.getDeleteStmt();
        DatabaseHelper db=new DatabaseHelper();
        db.execute(sql);
        JSONObject json = new JSONObject();
        json.put("errno", 0);
        out.print(json);
        out.flush();
        out.close();
    }

    private void Update(HttpServletRequest request, HttpServletResponse response) throws Exception {
        System.out.println("enter ClassGroupAction.Update");
        response.setContentType("application/json; charset=UTF-8");
        PrintWriter out = response.getWriter();
        QueryBuilder q=new QueryBuilder();
        JSONObject json = new JSONObject();
        DatabaseHelper db = new DatabaseHelper();
        String guid = null;
        if(!q.setGroupName(request.getParameter("group_name"))){
            json.put("errno", 1);
            json.put("msg", "分组名称不合法");
        }
        else if(!q.setEmail(request.getParameter("email"))){
            json.put("errno", 2);
            json.put("msg", "邮箱格式错误");
        }
        String email = request.getParameter("email");
        String sql = "select guid,username from `userinfo` where `email`='"+email+"'";
        ResultSet rs = db.executeQuery(sql);
        if(!rs.next()){
            json.put("errno", 3);
            json.put("msg", "邮箱为\""+email+"\"的用户不存在");
        }else{
            guid = rs.getString("guid");
            json.put("owner_id", rs.getInt("guid"));
            json.put("username", rs.getString("username"));
        }
        if(!json.has("errno")){
            q.setEmail(null);
            q.setGroupId(request.getParameter("group_id"));
            q.setOwnerId(guid);
            String sql1 = q.getUpdateStmt();
            db.execute(sql1);
            json.put("errno", 0);
        }
        out.print(json);
        out.flush();
        out.close();
    }

    private void Sort(HttpServletRequest request, HttpServletResponse response) throws JSONException, SQLException, IOException {
        System.out.println("enter ClassGroupAction.Sort");
        response.setContentType("application/json; charset=UTF-8");
        String sortBy = request.getParameter("sortBy");
        System.out.println(sortBy);
        queryBuilder.setSortBy(sortBy);
        PrintWriter out = response.getWriter();
        JSONObject json = new JSONObject();
        json.put("errno", 0);
        out.print(json);
        out.flush();
        out.close();
    }

    private void Statistics(HttpServletRequest request, HttpServletResponse response) throws JSONException, SQLException, IOException {
        System.out.println("enter ClassGroupAction.Statistics");
        String sql = String.format("select " +
                        " authorization as auth, " +
                        " count(*) as cnt " +
                        " from (%s) as tmp " +
                        " group by authorization ",
                queryBuilder.getSelectStmt());
        System.out.println("ClassGroupAction.Statistics: sql = "+sql);
        DatabaseHelper db=new DatabaseHelper();
        ResultSet rs=db.executeQuery(sql);
        JSONArray list = new JSONArray();
        String[] cla = new String[]{"学生", "教师", "管理员", "开发者"};
        while(rs.next())
        {
            JSONObject item = new JSONObject();
            int auth = rs.getInt("auth");
            int i=0;
            while(auth > 0){ i++; auth>>=1;}
            item.put("class", cla[i-1]);
            item.put("count", rs.getString("cnt"));
            list.put(item);
        }
        response.setContentType("application/json; charset=UTF-8");
        PrintWriter out = response.getWriter();
        out.print(list);
        out.flush();
        out.close();
    }

    private void ClearQuery(){
        System.out.println("enter ClassGroupAction.ClearQuery");
        queryBuilder.clear();
    }

    private void ClearSort(){
        System.out.println("enter ClassGroupAction.ClearSort");
        queryBuilder.setSortBy(null);
    }

    private void processResult(ResultSet rs) throws JSONException, SQLException {
        result = new JSONArray("[]");
        rs.beforeFirst();
        while(rs.next())
        {
            JSONObject item = new JSONObject();
            item.put("group_id", rs.getInt("group_id"));
            item.put("group_name", rs.getString("group_name"));
            item.put("owner_id", rs.getInt("owner_id"));
            item.put("username", rs.getString("username"));
            item.put("email", rs.getString("email"));
            result.put(item);
        }
    }
}