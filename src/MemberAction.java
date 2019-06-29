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
        String sql=queryBuilder.getSelectStmt();
        DatabaseHelper db=new DatabaseHelper();
        ResultSet rs=db.executeQuery(sql);
        processResult(rs);
        out.print(result);
        out.flush();
        out.close();
    }

    private void Delete(HttpServletRequest request, HttpServletResponse response) throws Exception {
        System.out.println("enter MemberAction.doQuery");
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

    private void Statistics(HttpServletRequest request, HttpServletResponse response) throws JSONException, SQLException, IOException {
        System.out.println("enter MemberAction.Statistics");
        String sql = String.format("select " +
                        " authorization as auth, " +
                        " count(*) as cnt " +
                        " from (%s) as tmp " +
                        " group by authorization ",
                queryBuilder.getSelectStmt());
        System.out.println("MemberAction.Statistics: sql = "+sql);
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