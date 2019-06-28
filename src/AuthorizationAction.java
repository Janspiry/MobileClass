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
import util.QueryBuilder;

import java.io.*;
import java.net.URLEncoder;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Objects;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
@WebServlet("/AuthorizationAction")
public class AuthorizationAction extends HttpServlet
{
    private static QueryBuilder queryBuilder = new QueryBuilder("userinfo");
    private static JSONArray result = new JSONArray();

    @Override
    public void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
    {
        request.setCharacterEncoding("UTF-8");
        String action = request.getParameter("action");
        System.out.println("AuthorizationAction action="+action);
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
                    throw new Exception("AuthorizationAction: 未知的请求类型");
            }
        }
        catch(Exception ex)
        {
            ex.printStackTrace();
        }
    }

    private void getResult(HttpServletRequest request, HttpServletResponse response) throws JSONException, SQLException, IOException {
        System.out.println("enter AuthorizationAction.getResult");
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
        System.out.println("enter AuthorizationAction.doQuery");
        response.setContentType("application/json; charset=UTF-8");
        PrintWriter out = response.getWriter();
        queryBuilder.clear();
        queryBuilder.setGuid(request.getParameter("guid"));
        queryBuilder.setUsername(request.getParameter("username"));
        queryBuilder.setEmail(request.getParameter("email"));
        queryBuilder.setAuthorization(request.getParameter("authorization"));
        queryBuilder.setCreate_time_from(request.getParameter("create_time_from"));
        queryBuilder.setCreate_time_to(request.getParameter("create_time_to"));
        queryBuilder.setModify_time_from(request.getParameter("modify_time_from"));
        queryBuilder.setModify_time_to(request.getParameter("modify_time_to"));
//        String sql=queryBuilder.getSelectStmt();
//        DatabaseHelper db=new DatabaseHelper();
//        ResultSet rs=db.executeQuery(sql);
//        processResult(rs);
        JSONObject json = new JSONObject();
        json.put("errno", 0);
        out.print(json);
        out.flush();
        out.close();
    }

    private void Delete(HttpServletRequest request, HttpServletResponse response) throws Exception {
        System.out.println("enter AuthorizationAction.doQuery");
        response.setContentType("application/json; charset=UTF-8");
        PrintWriter out = response.getWriter();
        QueryBuilder q=new QueryBuilder(queryBuilder.getTablename());
        q.setGuid(request.getParameter("guid"));
        if(q.getGuid()==-1){
            throw new Exception("UserInfoAction.Delete: guid为空");
        }
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
        System.out.println("enter AuthorizationAction.Update");
        response.setContentType("application/json; charset=UTF-8");
        PrintWriter out = response.getWriter();
        QueryBuilder q=new QueryBuilder(queryBuilder.getTablename());
        q.setGuid(request.getParameter("guid"));
        JSONObject json = new JSONObject();
        if(!q.setUsername(request.getParameter("username"))){
            json.put("errno", 1);
            json.put("msg", "用户名格式错误");
        }
        if(!q.setEmail(request.getParameter("email"))){
            json.put("errno", 2);
            json.put("msg", "邮箱格式错误");
        }
        if(!q.setAuthorization(request.getParameter("authorization"))){
            json.put("errno", 3);
            json.put("msg", "权限设置错误");
        }
        if(!json.has("errno")) {
            String sql = q.getUpdateStmt();
            DatabaseHelper db = new DatabaseHelper();
            db.execute(sql);
            json.put("errno", 0);
        }
        out.print(json);
        out.flush();
        out.close();
    }

    private void Sort(HttpServletRequest request, HttpServletResponse response) throws JSONException, SQLException, IOException {
        System.out.println("enter AuthorizationAction.Sort");
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
        System.out.println("enter AuthorizationAction.Statistics");
        String sql = String.format("select " +
                        " authorization as auth, " +
                        " count(*) as cnt " +
                        " from (%s) as tmp " +
                        " group by authorization ",
                queryBuilder.getSelectStmt());
        System.out.println("AuthorizationAction.Statistics: sql = "+sql);
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
        System.out.println("enter AuthorizationAction.ClearQuery");
        queryBuilder.clear();
    }

    private void ClearSort(){
        System.out.println("enter AuthorizationAction.ClearSort");
        queryBuilder.setSortBy(null);
    }

    private void processResult(ResultSet rs) throws JSONException, SQLException {
        result = new JSONArray("[]");
        rs.beforeFirst();
        while(rs.next())
        {
            JSONObject item = new JSONObject();
            item.put("guid", rs.getInt("guid"));
            item.put("create_time", rs.getTimestamp("create_time"));
            item.put("modify_time", rs.getTimestamp("modify_time"));
            item.put("authorization", rs.getInt("authorization"));
            item.put("username", rs.getString("username"));
//            item.put("fullname", rs.getString("fullname"));
//            item.put("gender", rs.getInt("gender"));
//            item.put("schoolnum", rs.getString("schoolnum"));
//            item.put("nativeplace", rs.getString("nativeplace"));
            item.put("email", rs.getString("email"));
//            item.put("phone", rs.getString("phone"));
            result.put(item);
        }
    }
}