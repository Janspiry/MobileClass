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
public class AuthorizationAction extends HttpServlet {

    private static JSONArray queryResult = null;
    private static QueryBuilder queryBuilder = null;
    static {
        try {
            queryResult = new JSONArray("[]");
        } catch (JSONException e) {
            e.printStackTrace();
        }
        queryBuilder = new QueryBuilder("userinfo");
    }

    @Override
    public void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
    {
        String action = request.getParameter("action");
        try
        {
            switch(action)
            {
                case "getResult":
                    getResult(request, response);
                    break;
                case "doQuery":
                    doQuery(request, response);
                    break;
                case "doSort":
                    doSort(request, response);
                    break;
                case "doUpdate":
                    doUpdate(request, response);
                    break;
                case "getStatistics":
                    getStatistics(request, response);
                    break;
                case "print":
                    printSheet(request, response);
                    break;
                case "exportAsPdf":
                    exportAsPdf(request, response);
                    break;
                case "exportAsExcel":
                    exportAsExcel(request, response);
                    break;
                default:
                    System.out.println("AuthorizationAction.service: invalid action: "+action);
                    break;
            }
        }
        catch(Exception ex)
        {
            ex.printStackTrace();
        }
    }

    private void getResult(HttpServletRequest request, HttpServletResponse response) throws IOException, JSONException, SQLException {
        System.out.println("enter AuthorizationAction.getResult");
        response.setContentType("application/json; charset=UTF-8");
        PrintWriter out = response.getWriter();
        HttpSession session = request.getSession();
        if(session.getAttribute("authmng_exist_result")==null || !(boolean)session.getAttribute("authmng_exist_result"))
        {
            System.out.println("getResult: authmng_exist_result=false or null");
            queryBuilder.clear();
            String sql=queryBuilder.getSelectStmt();
            DatabaseHelper db=new DatabaseHelper();
            ResultSet rs=db.executeQuery(sql);
            processResult(rs);
            session.setAttribute("authmng_exist_result", false);
        }
        for(int i=0;i<queryResult.length();i++)
        {
            System.out.printf("result[%d].guid=%d\n",i, queryResult.getJSONObject(i).getInt("guid"));
        }
        out.print(queryResult);
        out.flush();
        out.close();
        System.out.println("exit AuthorizationAction.getResult");
    }

    private void doQuery(HttpServletRequest request, HttpServletResponse response) throws JSONException, SQLException, IOException {
        System.out.println("enter AuthorizationAction.doQuery");
        queryBuilder.clear();
        queryBuilder.setTableName("userinfo");
        queryBuilder.setGuid(request.getParameter("guid"));
        queryBuilder.setCreate_time_from(request.getParameter("time_from"));
        queryBuilder.setCreate_time_to(request.getParameter("time_to"));
        queryBuilder.setUsername(request.getParameter("username"));
        queryBuilder.setFullname(request.getParameter("fullname"));
        int auth=0;
        String auth1=request.getParameter("auth1");
        if(auth1!=null && auth1.equals("on"))auth|=1;
        String auth2=request.getParameter("auth2");
        if(auth2!=null && auth2.equals("on"))auth|=2;
        String auth4=request.getParameter("auth4");
        if(auth4!=null && auth4.equals("on"))auth|=4;
        String auth8=request.getParameter("auth8");
        if(auth8!=null && auth8.equals("on"))auth|=8;
        queryBuilder.setAuthorization(auth==0 ? -1 : auth);
        String sql=queryBuilder.getSelectStmt();
        DatabaseHelper db=new DatabaseHelper();
        ResultSet rs = db.executeQuery(sql);
        processResult(rs);
        HttpSession session = request.getSession();
        session.setAttribute("authmng_exist_result", true);
        System.out.println("exit AuthorizationAction.doQuery");
        response.sendRedirect("templates/admin/authmng.jsp");
    }

    private void doSort(HttpServletRequest request, HttpServletResponse response) throws JSONException, SQLException, IOException {
        System.out.println("enter AuthorizationAction.doSort");
        String sql=queryBuilder.getSelectStmt();
        String key1=request.getParameter("key1");
        String sort1=request.getParameter("sort1");
        String key2=request.getParameter("key2");
        String sort2=request.getParameter("sort2");
        sql+=String.format(" order by %s %s", key1, sort1);
        if(!key1.equals(key2))sql+=String.format(", %s %s", key2, sort2);
        System.out.println("doSort sql = " + sql);
        DatabaseHelper db=new DatabaseHelper();
        ResultSet rs = db.executeQuery(sql);
        processResult(rs);
        HttpSession session = request.getSession();
        session.setAttribute("authmng_exist_result", true);
        System.out.println("exit AuthorizationAction.doSort");
        response.sendRedirect("templates/admin/authmng.jsp");
    }

    private void doUpdate(HttpServletRequest request, HttpServletResponse response) throws JSONException, SQLException, IOException {
        System.out.println("enter AuthorizationAction.doUpdate");
        String guid = request.getParameter("guid");
        String[] guidList = guid.split(",");
        int auth=0;
        String auth1=request.getParameter("auth1");
        if(auth1!=null && auth1.equals("on"))auth|=1;
        String auth2=request.getParameter("auth2");
        if(auth2!=null && auth2.equals("on"))auth|=2;
        String auth4=request.getParameter("auth4");
        if(auth4!=null && auth4.equals("on"))auth|=4;
        String auth8=request.getParameter("auth8");
        if(auth8!=null && auth8.equals("on"))auth|=8;
        String sql = String.format("update `userinfo` set authorization=%d where 0=1", auth);
        for(int i=0; i<guidList.length; i++)
        {
            sql+=String.format(" or guid=%s", guidList[i]);
        }
        System.out.println("doUpdate sql = "+sql);
        DatabaseHelper db=new DatabaseHelper();
        db.execute(sql);
        HttpSession session = request.getSession();
        session.setAttribute("authmng_exist_result", false);
        System.out.println("exit AuthorizationAction.doUpdate");
        response.sendRedirect("templates/admin/authmng.jsp");
    }

    private void getStatistics(HttpServletRequest request, HttpServletResponse response) throws JSONException, SQLException, IOException {
        System.out.println("enter AuthorizationAction.getStatistics");
        String sql = queryBuilder.getSelectStmt();
        String dateFormat = request.getParameter("interval");
        if(dateFormat==null || dateFormat.length()==0)
        {
            System.out.println("getStatistics: miss argument 'interval'");
            return;
        }
        if(Objects.equals(dateFormat, "hour"))dateFormat="%Y-%m-%d %H:00:00";
        else if(Objects.equals(dateFormat, "day"))dateFormat="%Y-%m-%d";
        else if(Objects.equals(dateFormat, "month"))dateFormat="%Y-%m";
        sql = String.format("select " +
                        "DATE_FORMAT(create_time,'%s') as tt, " +
                        " count(*) as cnt " +
                        " from (%s) as tmp " +
                        " group by tt ",
                dateFormat, sql);
        System.out.println("getStatistics sql = "+sql);
        DatabaseHelper db=new DatabaseHelper();
        ResultSet rs=db.executeQuery(sql);
        JSONArray list = new JSONArray();
        while(rs.next())
        {
            JSONObject item = new JSONObject();
            item.put("time", rs.getString("tt"));
            item.put("count", rs.getString("cnt"));
            list.put(item);
        }
        response.setContentType("application/json; charset=UTF-8");
        PrintWriter out = response.getWriter();
        out.print(list);
        out.flush();
        out.close();
        System.out.println("exit AuthorizationAction.getStatistics");
    }

    private void printSheet(HttpServletRequest request, HttpServletResponse response) throws JSONException, SQLException, IOException {
        System.out.println("enter AuthorizationAction.printSheet");

        System.out.println("exit AuthorizationAction.printSheet");
    }

    private void exportAsPdf(HttpServletRequest request, HttpServletResponse response) throws JSONException, SQLException, IOException {
        System.out.println("enter AuthorizationAction.printSheet");

        System.out.println("exit AuthorizationAction.printSheet");
    }

    private void exportAsExcel(HttpServletRequest request, HttpServletResponse response) throws JSONException, SQLException, IOException, WriteException {
        System.out.println("enter AuthorizationAction.printSheet");
        request.setCharacterEncoding("utf-8");
        response.setContentType("application/vnd.ms-excel;charset=utf-8");

        String context = "权限管理-查询结果";
        response.setHeader("Content-Disposition", "attachment; filename=\""
                + URLEncoder.encode(context, "utf-8") + ".xls\"");

        File downloadFile = new File(request.getSession().getServletContext()
                .getRealPath("/"), URLEncoder.encode(context, "utf-8") + ".xls");
        if (downloadFile.exists()) {
            downloadFile.delete();
        }
        downloadFile.createNewFile();
        OutputStream os = new FileOutputStream(downloadFile);
        WritableWorkbook book = Workbook.createWorkbook(os);
        // 生成名为"第一页"的工作表，参数0表示这是第一
        WritableSheet sheet = book.createSheet(context,0);
        /**
         * 设置表格表头样式
         */
        WritableFont font1 = new WritableFont(
                WritableFont.createFont("宋体"), 10, WritableFont.BOLD);
        font1.setColour(Colour.BLACK);// 表格字体颜色
        WritableCellFormat format1 = new WritableCellFormat(font1);
        format1.setBackground(Colour.GREEN);// 表格背景颜色
        format1.setBorder(jxl.format.Border.ALL, jxl.format.BorderLineStyle.THIN);// 表格线条加黑
        format1.setAlignment(jxl.format.Alignment.CENTRE);// 左右居中
        format1.setVerticalAlignment(jxl.format.VerticalAlignment.CENTRE);// 上下居中
        format1.setWrap(true);// 单元格的文字按照单元格的列宽来自动换行显示
        /**
         * 设置表格内容样式
         */
        // 设置字体为宋体,16号字,加粗,颜色为黑色
        WritableFont font2 = new WritableFont(
                WritableFont.createFont("宋体"), 10, WritableFont.BOLD);
        font2.setColour(Colour.BLACK);// 表格字体颜色
        WritableCellFormat format2 = new WritableCellFormat(font2);
        format2.setBackground(Colour.GRAY_25);// 表格背景颜色
        format2.setBorder(jxl.format.Border.ALL, jxl.format.BorderLineStyle.THIN);// 表格线条加黑
        format2.setAlignment(jxl.format.Alignment.CENTRE);// 左右居中
        format2.setVerticalAlignment(jxl.format.VerticalAlignment.CENTRE);// 上下居中
        format2.setWrap(true);// 单元格的文字按照单元格的列宽来自动换行显示
        // 添加表头
        sheet.addCell(new Label(0,0,"GUID",format1));
        sheet.addCell(new Label(1,0,"创建时间",format1));
        sheet.addCell(new Label(2,0,"用户名",format1));
        sheet.addCell(new Label(3,0,"姓名",format1));
        sheet.addCell(new Label(4,0,"权限",format1));
        // 添加内容
        for(int i=0;i<queryResult.length();i++)
        {
            int line=i+1;
            JSONObject item = queryResult.getJSONObject(i);
            sheet.addCell(new Label(0,line,item.getString("guid"),format2));
            sheet.addCell(new Label(1,line,item.getString("create_time"),format2));
            sheet.addCell(new Label(2,line,item.getString("username"),format2));
            sheet.addCell(new Label(3,line,item.getString("fullname"),format2));
            sheet.addCell(new Label(4,line,item.getString("authorization"),format2));
        }
        book.write();
        book.close();
        os.close();

        //下载
        InputStream is = null;
        is = new FileInputStream(downloadFile);
        byte[] buf = new byte[4096];
        ServletOutputStream servletOS = response.getOutputStream();
        int readLength;
        while (((readLength = is.read(buf)) != -1)) {
            servletOS.write(buf, 0, readLength);
        }
        is.close();
        servletOS.flush();
        servletOS.close();

        System.out.println("exit AuthorizationAction.printSheet");
    }

    private void processResult(ResultSet rs) throws JSONException, SQLException {
        queryResult = new JSONArray("[]");
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
            queryResult.put(item);
        }
    }
}
