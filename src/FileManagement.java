/**
 * Created by Janspiry on 2019/6/15.
 */

import FileManagement.QueryBuilder;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;
import util.DatabaseHelper;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.*;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Objects;

@WebServlet("/FileManagement")
public class FileManagement extends HttpServlet {

    private static JSONArray queryResult = null;
    private static QueryBuilder queryBuilder = null;
    static {
        try {
            queryResult = new JSONArray("[]");
        } catch (JSONException e) {
            e.printStackTrace();
        }
        queryBuilder = new QueryBuilder("file");
    }

    @Override
    public void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
    {
        String action = request.getParameter("action");
        try
        {
            switch(action)
            {
                case "get_record":
                    getRecord(request, response);
                    break;
                case "add_record":
                    addRecord(request, response);
                    break;
                case "delete_record":
                    deleteRecord(request, response);
                    break;
                case "modify_record":
                    modifyRecord(request, response);
                    break;
                case "getStatistics":
                    getStatistics(request, response);
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
    public void addRecord(HttpServletRequest request, HttpServletResponse response) throws Exception {
        HttpSession session = request.getSession();

        String title=request.getParameter("title");
        String context=request.getParameter("context");
        String fileUrl="";
        request.setCharacterEncoding("utf-8");	//设置编码
        System.out.print("执行增加文件\n");
        DiskFileItemFactory factory = new DiskFileItemFactory();
        String path="C:/upload";
        factory.setRepository(new File(System.getProperty("java.io.tmpdir")));
        //设置 缓存的大小，当上传文件的容量超过该缓存时，直接放到 暂时存储室
        factory.setSizeThreshold(1024*1024) ;
        //高水平的API文件上传处理
        ServletFileUpload upload = new ServletFileUpload(factory);
        try {
            //可以上传多个文件
            List<FileItem> list = (List<FileItem>)upload.parseRequest(request);
            for(FileItem item : list)
            {
                //获取表单的属性名字,依次为title,context,grades等表单头
                String name = item.getFieldName();
                System.out.println("name:"+name);
                //如果获取的 表单信息是普通的 文本 信息
                if(item.isFormField())
                {
                    String value = item.getString() ;//这里是表单context,grades等的值
                    value =new String(item.getString().getBytes("iso-8859-1"),"utf-8");
                    if(name=="title"||name.equals("title")){
                        title=value;
                    } else if(name=="context"||name.equals("context")){
                        context=value;
                    }
                }
                else
                {
                    //获取路径名
                    String value = item.getName() ;
                    System.out.println(value);
                    int start = value.lastIndexOf("\\");
                    //截取 上传文件的 字符串名字，加1是 去掉反斜杠，
                    String filename = value.substring(start+1);
                    fileUrl="/upload/"+filename;
                    if(filename.isEmpty()){
                        continue;
                    }
                    request.setAttribute(name, filename);
                    OutputStream out = new FileOutputStream(new File(path,filename));
                    InputStream in = item.getInputStream() ;
                    int length = 0 ;
                    byte [] buf = new byte[1024] ;
                    System.out.println("获取上传文件的总共的容量："+item.getSize());
                    while( (length = in.read(buf) ) != -1){
                        //在   buf 数组中 取出数据 写到 （输出流）磁盘上
                        out.write(buf, 0, length);
                    }
                    in.close();
                    out.close();
                }
            }
        } catch (FileUploadException e) {
            e.printStackTrace();
        }
        catch (Exception e) {
            e.printStackTrace();
        }
        System.out.println("title:"+title);
        System.out.println("context:"+context);
        String userId=session.getAttribute("guid")==null?null:(String)session.getAttribute("guid");
        String creator=(String)session.getAttribute("username");
        String createTime=(new SimpleDateFormat("yyyy-MM-dd")).format(new Date());
        queryBuilder.clear();
        queryBuilder.setUserId(userId);
        queryBuilder.setUserName(creator);
        queryBuilder.setTitle(title);
        queryBuilder.setContent(context);
        queryBuilder.setCreateTime(createTime);
        queryBuilder.setChangeTime(createTime);
        queryBuilder.setfileUrl(fileUrl);
        queryBuilder.setDownloadNum("0");
        queryBuilder.setChangNum("1");

        DatabaseHelper db = new DatabaseHelper();
        String sql=queryBuilder.getInsertStmt();
        db.execute(sql);
    }
    private void getRecord(HttpServletRequest request, HttpServletResponse response) throws IOException, JSONException, SQLException {
        response.setContentType("application/json; charset=UTF-8");
        PrintWriter out = response.getWriter();
        HttpSession session = request.getSession();
        String title=request.getParameter("title");
        String user_name=(String)request.getParameter("user_name");
        String orderby=(String)request.getParameter("orderby");
        if(session.getAttribute("exist_result")==null || !(boolean)session.getAttribute("exist_result"))
        {
            System.out.println("getResultexist_result=false or null");
            queryBuilder.clear();
            queryBuilder.setTitle(title);
            queryBuilder.setUserName(user_name);
            queryBuilder.setOrderBy(orderby);
            String sql=queryBuilder.getSelectStmt();
            DatabaseHelper db=new DatabaseHelper();
            ResultSet rs=db.executeQuery(sql);
            processResult(rs);
            session.setAttribute("exist_result", false);
        }
        for(int i=0;i<queryResult.length();i++)
        {
            System.out.printf("result[%d].guid=%d\n",i, queryResult.getJSONObject(i).getInt("guid"));
        }
        out.print(queryResult);
        session.setAttribute("jsonData",queryResult);
        out.flush();
        out.close();
        System.out.println("exit getResult");
    }
    private void deleteRecord(HttpServletRequest request, HttpServletResponse response) throws IOException, JSONException, SQLException {
        response.setContentType("application/json; charset=UTF-8");
        HttpSession session = request.getSession();
        String guid=request.getParameter("guid");
        DatabaseHelper db=new DatabaseHelper();
        String tableName="file";
        String sql="delete from "+tableName+" where guid="+guid;
        db.executeUpdate(sql);

    }
    private void modifyRecord(HttpServletRequest request, HttpServletResponse response) throws JSONException, SQLException, IOException, ParseException {
        response.setContentType("application/json; charset=UTF-8");
        PrintWriter out = response.getWriter();

        System.out.println("enter modifyRecord");
        String guid = request.getParameter("guid");
        String context = request.getParameter("context");
        String title = request.getParameter("title");
        String changeTime=(new SimpleDateFormat("yyyy-MM-dd")).format(new Date());
        //修改内容

        String downloadNum = request.getParameter("downloadNum");
        //修改下载数

        String tableName="file";
        String sql="select * from "+tableName+" where guid="+guid;
        DatabaseHelper db=new DatabaseHelper();
        ResultSet rs=db.executeQuery(sql);

        rs.next();
        int chang_num=rs.getInt("change_num");
        chang_num++;

        sql="update "+tableName+" set";
        if(downloadNum!=null&&downloadNum!=""){
            sql=sql+" download_num='"+downloadNum+"'";
        }else{
            if(title!=null&&title!=""){
                sql=sql+" title='"+title+"'";
            }
            if(context!=null&&context!=""){
                sql=sql+" ,context='"+context+"'";
            }
            sql=sql+" ,change_time='"+changeTime+"'";
            sql=sql+" ,change_num='"+chang_num+"'";
        }
        sql=sql+" where guid="+guid;
        System.out.println("modify sql = "+sql);
        db.execute(sql);

        //返回状态
        queryBuilder.clear();
        sql=queryBuilder.getSelectStmt();
        rs=db.executeQuery(sql);
        processResult(rs);
        for(int i=0;i<queryResult.length();i++)
        {
            System.out.printf("result[%d].guid=%d\n",i, queryResult.getJSONObject(i).getInt("guid"));
        }
        out.print(queryResult);
        out.flush();
        out.close();
        System.out.println("exit modifyResult");
    }
    private void getStatistics(HttpServletRequest request, HttpServletResponse response) throws JSONException, SQLException, IOException {
        System.out.println("enter FileManagement.getStatistics");
        String sql = queryBuilder.getSelectStmt();
        String dateFormat = request.getParameter("interval");
        if(dateFormat==null || dateFormat.length()==0)
        {
            System.out.println("getStatistics: miss argument 'interval'");
            return;
        }
        if(Objects.equals(dateFormat, "year"))dateFormat="%Y";
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
        System.out.println("exit FileManagement.getStatistics");
    }


    private void processResult(ResultSet rs) throws JSONException, SQLException {
        queryResult = new JSONArray("[]");
        rs.beforeFirst();
        while(rs.next())
        {
            JSONObject item = new JSONObject();
            item.put("guid", rs.getInt("guid"));
            item.put("user_id", rs.getInt("user_id"));
            item.put("user_name", rs.getString("user_name"));
            item.put("title", rs.getString("title"));
            item.put("context", rs.getString("context"));
            item.put("create_time", rs.getString("create_time"));
            item.put("change_time", rs.getString("change_time"));
            item.put("change_num", rs.getInt("change_num"));
            item.put("download_num", rs.getInt("download_num"));
            item.put("file_url", rs.getString("file_url"));
            queryResult.put(item);
        }
    }
}
