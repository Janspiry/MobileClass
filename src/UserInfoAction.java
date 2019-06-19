
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
import javax.xml.crypto.Data;
import java.util.regex.*;

/**
 * Created by silenus on 2019/6/18.
 */
@WebServlet("/UserInfoAction")
public class UserInfoAction extends HttpServlet
{
    private static QueryBuilder queryBuilder = new QueryBuilder("userinfo");
    private static JSONArray result = new JSONArray();
    private static boolean hasResult = false;

    @Override
    public void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
    {
        request.setCharacterEncoding("UTF-8");
        String action = request.getParameter("action");
        System.out.println("UserInfoAction action="+action);
        try
        {
            switch(action)
            {
                case "getResult":
                    getResult(request, response);
                    break;
            }
        }
        catch(Exception ex)
        {
            ex.printStackTrace();
        }
    }

    private void getResult(HttpServletRequest request, HttpServletResponse response) throws JSONException, SQLException, IOException {
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

    private void processResult(ResultSet rs) throws JSONException, SQLException {
        result = new JSONArray("[]");
        rs.beforeFirst();
        while(rs.next())
        {
            JSONObject item = new JSONObject();
            item.put("guid", rs.getInt("guid"));
            item.put("create_time", rs.getString("create_time"));
            item.put("modify_time", rs.getString("modify_time"));
            item.put("authorization", rs.getInt("authorization"));
            item.put("username", rs.getString("username"));
            item.put("fullname", rs.getString("fullname"));
            item.put("gender", rs.getInt("gender"));
            item.put("schoolnum", rs.getString("schoolnum"));
            item.put("nativeplace", rs.getString("nativeplace"));
            item.put("email", rs.getString("email"));
            item.put("phone", rs.getString("phone"));
            result.put(item);
        }
        hasResult=true;
    }

}