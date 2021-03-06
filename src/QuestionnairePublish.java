/**
 * Created by Janspiry on 2019/6/15.
 */

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;
import util.DatabaseHelper;
import Questionnaire.QueryBuilder;

import java.io.*;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.Objects;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/QuestionnairePublish")
public class QuestionnairePublish extends HttpServlet {

    private static JSONArray queryResult = null;
    private static QueryBuilder queryBuilder = null;
    static {
        try {
            queryResult = new JSONArray("[]");
        } catch (JSONException e) {
            e.printStackTrace();
        }
        queryBuilder = new QueryBuilder("questionnaire");
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
        String questionList=(String)request.getParameter("question_list");
        String limitTime=request.getParameter("limit_time");

        JSONArray jsonArray =new JSONArray(questionList);
        ArrayList<String> list = new ArrayList<String>();
        for (int i1=0;i1<jsonArray.length();i1++){
            String string = jsonArray.getString(i1);
            System.out.println("具体:"+string);
            list.add(string);
        }
        String userId=session.getAttribute("guid")==null?null:(String)session.getAttribute("guid");
        String creator=(String)session.getAttribute("username");
        String createTime=(new SimpleDateFormat("yyyy-MM-dd")).format(new Date());

        queryBuilder.clear();
        queryBuilder.setUserId(userId);
        queryBuilder.setTitle(title);
        queryBuilder.setLimitTime(limitTime);
        queryBuilder.setCreator(creator);
        queryBuilder.setUserName(creator);
        queryBuilder.setCreateTime(createTime);
        queryBuilder.setChangeTime(createTime);

        DatabaseHelper db = new DatabaseHelper();
        String sql="SELECT MAX(questionnaire_id)+1 FROM questionnaire";
        ResultSet rs = db.executeQuery(sql);
        rs.next();
        String a=rs.getString(1);
        if(a==null||a=="null"||a.equals("null")){
            a="0";
        }
        queryBuilder.setQuestionnaireId(a);//
        queryBuilder.setUrl(a);
        queryBuilder.setProblemId("-1");

        SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
        if(format.parse(limitTime).compareTo(format.parse(createTime))>0){
            queryBuilder.setStatus("processing");
        }else{
            queryBuilder.setStatus("ended");
        }
        sql=queryBuilder.getInsertStmt();
        db.execute(sql);

        for(int i1=0;i1<list.size();i1++){
            queryBuilder.setProblem(list.get(i1).toString());
            queryBuilder.setProblemId(Integer.toString(i1+1));
            sql=queryBuilder.getInsertStmt();
            db.execute(sql);
        }

    }
    private void getRecord(HttpServletRequest request, HttpServletResponse response) throws IOException, JSONException, SQLException {
        response.setContentType("application/json; charset=UTF-8");
        PrintWriter out = response.getWriter();
        HttpSession session = request.getSession();
        String title=request.getParameter("title");
        String author_name=(String)request.getParameter("author_name");
        String orderby=(String)request.getParameter("orderby");
        if(session.getAttribute("exist_result")==null || !(boolean)session.getAttribute("exist_result"))
        {
            System.out.println("getResultexist_result=false or null");
            queryBuilder.clear();
            queryBuilder.setTitle(title);
            queryBuilder.setCreator(author_name);
            queryBuilder.setOrderBy(orderby);
            String sql=queryBuilder.getSelectStmt();
            DatabaseHelper db=new DatabaseHelper();
            ResultSet rs=db.executeQuery(sql);
            processResult(request,rs);
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
        queryBuilder.clear();
        DatabaseHelper db=new DatabaseHelper();

        String tableName="questionnaire";
        String sql="select * from "+tableName+" where guid="+guid;
        ResultSet rs = db.executeQuery(sql);
        String questionId="";
        String userId="";
        while (rs.next()) {
            questionId=rs.getString("questionnaire_id");
            userId=rs.getString("user_id");
        }
        System.out.println("问卷序号:"+questionId);
        sql="delete from "+tableName+" where questionnaire_id="+questionId;
        db.executeUpdate(sql);

    }
    private void modifyRecord(HttpServletRequest request, HttpServletResponse response) throws JSONException, SQLException, IOException, ParseException {
        System.out.println("enter modifyRecord");
        String guid = request.getParameter("guid");
        String limit_time = request.getParameter("limit_time");
        String title = request.getParameter("title");
        String createTime=(new SimpleDateFormat("yyyy-MM-dd")).format(new Date());
        String status="processing";

        SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
        if(format.parse(limit_time).compareTo(format.parse(createTime))<0){
            status="ended";
        }

        String tableName="questionnaire";
        String sql="select * from "+tableName+" where guid="+guid;
        DatabaseHelper db=new DatabaseHelper();
        ResultSet rs = db.executeQuery(sql);
        String questionId="";
        while (rs.next()) {
            questionId=rs.getString("questionnaire_id");
        }
        sql="update "+tableName+" set";
        if(title!=null&&title!=""){
            sql=sql+" title='"+title+"'";
        }
        if(limit_time!=null&&limit_time!=""){
            sql=sql+" ,limit_time='"+limit_time+"'";
        }
        sql=sql+" ,status='"+status+"'";
        sql=sql+" where questionnaire_id="+Integer.parseInt(questionId);
        System.out.println("modify sql = "+sql);
        db.execute(sql);

        //返回状态
        response.setContentType("application/json; charset=UTF-8");
        queryBuilder.clear();
        sql=queryBuilder.getSelectStmt();
        db=new DatabaseHelper();
        rs=db.executeQuery(sql);
        processResult(request,rs);
        PrintWriter out = response.getWriter();
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

    private void processResult(HttpServletRequest request,ResultSet rs) throws JSONException, SQLException {
        HttpSession session = request.getSession();
        int user_id=Integer.parseInt(session.getAttribute("guid").toString());
        int authorization=Integer.parseInt(session.getAttribute("authorization").toString());

        queryResult = new JSONArray("[]");
        rs.beforeFirst();
        while(rs.next())
        {
            JSONObject item = new JSONObject();
            item.put("guid", rs.getInt("guid"));
            item.put("user_id", rs.getInt("user_id"));
            item.put("author_name", rs.getString("author_name"));
            item.put("title", rs.getString("title"));
            item.put("create_time", rs.getString("create_time"));
            item.put("change_time", rs.getString("change_time"));
            item.put("limit_time", rs.getString("limit_time"));
            item.put("user_name", rs.getString("user_name"));
            item.put("answer_num", rs.getInt("answer_num"));
            item.put("questionnaire_id", rs.getInt("questionnaire_id"));
            item.put("status", rs.getString("status"));
            item.put("answer", rs.getString("answer"));
            item.put("problem", rs.getString("problem"));

            if(authorization>1||rs.getInt("user_id")==user_id){
                item.put("authorization", 1);
            }else{
                item.put("authorization", 0);
            }
            queryResult.put(item);
        }
    }
}
