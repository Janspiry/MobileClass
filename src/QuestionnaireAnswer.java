/**
 * Created by Janspiry on 2019/6/15.
 */

import Questionnaire.QueryBuilder;
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
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.Objects;

@WebServlet("/QuestionnaireAnswer")
public class QuestionnaireAnswer extends HttpServlet {

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
        System.out.println(action);
        try
        {
            switch(action)
            {
                case "get_record":
                    getRecord(request, response);
                    break;
                case "get_record_by_id":
                    getRecordById(request, response);
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
        String userId=session.getAttribute("guid")==null?null:(String)session.getAttribute("guid");
        String userName=(String)session.getAttribute("username");
        String changeTime=(new SimpleDateFormat("yyyy-MM-dd")).format(new Date());
        int count =Integer.parseInt(request.getParameter("count"));
        String guid = request.getParameter("id");

        String problemName="problem"+1;
        String answerName="answer"+1;
        String problem=request.getParameter(problemName);
        String answer=request.getParameter(answerName);


        DatabaseHelper db = new DatabaseHelper();
        ResultSet rs;

        String tableName="questionnaire";
        String sql="select * from "+tableName+" where guid="+guid;
        rs = db.executeQuery(sql);
        rs.next();
        String questionnaireId=rs.getString("questionnaire_id");

        sql="select * from "+tableName+" where questionnaire_id="+questionnaireId+" and problem_id=-1";
        rs = db.executeQuery(sql);
        rs.next();
        String title=rs.getString("title");
        String creator=rs.getString("author_name");
        String limitTime=rs.getString("limit_time");
        String createTime=rs.getString("create_time");
        String answer_num=rs.getString("answer_num");
        String status=rs.getString("status");

        //更新答案数量
        int num=Integer.parseInt(answer_num);
        num++;
        sql="update "+tableName+" set answer_num="+num+" where questionnaire_id="+questionnaireId+" and problem_id=-1";
        System.out.println("增加回答数:"+sql);
        db.executeUpdate(sql);

        //插入新回答
        queryBuilder.clear();
        queryBuilder.setTitle(title);
        queryBuilder.setUserId(userId);
        queryBuilder.setUserName(userName);
        queryBuilder.setCreator(creator);
        queryBuilder.setCreateTime(changeTime);
        queryBuilder.setChangeTime(changeTime);
        queryBuilder.setLimitTime(limitTime);
        queryBuilder.setQuestionnaireId(questionnaireId);//问卷id
        queryBuilder.setStatus(status);
        queryBuilder.setAnswerNum("1");
        //用户回答此问卷的标识
        queryBuilder.setUserFlag("1");
        queryBuilder.setProblemId("0");
        sql=queryBuilder.getInsertStmt();
        db.execute(sql);

        //用户回答此问卷对应问题的标识
        queryBuilder.setUserFlag("0");
        queryBuilder.setAnsweFlag("1");
        for(int j=1;j<=count;j++){
            problemName="problem"+j;
            answerName="answer"+j;
            request.setCharacterEncoding("utf-8");
            problem=request.getParameter(problemName);
            answer=request.getParameter(answerName);
            String value1 =new String(problem.getBytes("iso-8859-1"),"utf-8");
            String value2 =new String(answer.getBytes("iso-8859-1"),"utf-8");
            System.out.println("问题"+value1);
            System.out.println("答案"+value2);
            queryBuilder.setProblem(value1);
            queryBuilder.setAnswer(value2);
            queryBuilder.setProblemId(Integer.toString(j));
            sql=queryBuilder.getInsertStmt();
            db.execute(sql);
        }
        response.sendRedirect("questionnaire/publish/questionnaire_list.jsp");
    }
    private void getRecord(HttpServletRequest request, HttpServletResponse response) throws IOException, JSONException, SQLException {
        response.setContentType("application/json; charset=UTF-8");
        PrintWriter out = response.getWriter();
        HttpSession session = request.getSession();
        String id=request.getParameter("id");
        String type= request.getParameter("type");
        String title=request.getParameter("title");
        String author_name=(String)request.getParameter("author_name");
        String user_name=(String)request.getParameter("user_name");
        String orderby=(String)request.getParameter("orderby");

        System.out.println("getResultexist_result=false or null");
        queryBuilder.clear();
        //问卷问题所需
        queryBuilder.setGuid(id);
        queryBuilder.setType(type);
        queryBuilder.setUserName(user_name);
        queryBuilder.setOrderBy(orderby);

        String sql=queryBuilder.getAnswerSql();
        DatabaseHelper db=new DatabaseHelper();
        ResultSet rs=db.executeQuery(sql);
        processResult(request,rs);

        for(int i=0;i<queryResult.length();i++)
        {
            System.out.printf("result[%d].guid=%d\n",i, queryResult.getJSONObject(i).getInt("guid"));
        }
        out.print(queryResult);
        session.setAttribute("jsonData",queryResult);
        session.setAttribute("sql",sql);
        out.flush();
        out.close();
        System.out.println("exit getResult");
    }
    private void getRecordById(HttpServletRequest request, HttpServletResponse response) throws IOException, JSONException, SQLException {
        response.setContentType("application/json; charset=UTF-8");
        PrintWriter out = response.getWriter();
        HttpSession session = request.getSession();
        int guid=Integer.parseInt((String)session.getAttribute("guid"));
        String id=request.getParameter("id");
        String type= request.getParameter("type");

        System.out.println("getResultexist_result=false or null");
        queryBuilder.clear();
        //问卷问题所需
        queryBuilder.setGuid(id);
        queryBuilder.setType(type);

        String sql=queryBuilder.getAnswerSql();
        DatabaseHelper db=new DatabaseHelper();
        ResultSet rs=db.executeQuery(sql);
        processResult(request,rs);


        System.out.println("guid:"+guid);
        if(queryResult.length()<1){
            JSONObject item = new JSONObject();
            item.put("guid",guid);
            queryResult.put(item);
        }else{
            for(int i=0;i<queryResult.length();i++)
            {
                if(guid==queryResult.getJSONObject(i).getInt("user_id")){
                    queryResult = new JSONArray("[]");
                    break;
                }
                System.out.printf("result[%d].guid=%d\n",i, queryResult.getJSONObject(i).getInt("guid"));
            }
        }
        out.print(queryResult);
        out.flush();
        out.close();
        System.out.println("exit getResultById");
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
        sql="delete from "+tableName+" where questionnaire_id="+questionId+" and user_id='"+userId+"' and answer_flag=1";
        db.executeUpdate(sql);
        sql="delete from "+tableName+" where questionnaire_id="+questionId+" and user_id='"+userId+"' and user_flag=1";
        db.executeUpdate(sql);

        sql="select * from "+tableName+" where questionnaire_id="+questionId+" and problem_id=-1";
        rs = db.executeQuery(sql);
        rs.next();
        int num=Integer.parseInt( rs.getString("answer_num"));
        num--;
        sql="update "+tableName+" set answer_num='"+num+"' where questionnaire_id='"+questionId+"' and problem_id=-1";
        System.out.println("删除回答数:"+sql);
        db.executeUpdate(sql);
    }
    private void modifyRecord(HttpServletRequest request, HttpServletResponse response) throws JSONException, SQLException, IOException, ParseException {
        System.out.println("enter modifyRecord");
        String guid = request.getParameter("id");
        String changeTime=(new SimpleDateFormat("yyyy-MM-dd")).format(new Date());
        int count =Integer.parseInt(request.getParameter("count"));

        String problemName="problem"+1;
        String answerName="answer"+1;
        String problem="";
        String answer="";

        DatabaseHelper db = new DatabaseHelper();
        ResultSet rs;

        String tableName="questionnaire";
        String sql="select * from "+tableName+" where guid="+guid;
        rs = db.executeQuery(sql);
        rs.next();
        String questionnaireId=rs.getString("questionnaire_id");

        int userid=Integer.parseInt(rs.getString("user_id"));
        String answer_num=rs.getString("answer_num");

        //更新回答数与最后修改时间
        int num=Integer.parseInt(answer_num);
        num++;
        sql="update "+tableName+" set answer_num="+num+
                ",change_time='"+changeTime+"' where guid="+guid;
        System.out.println("增加回答数:"+sql);
        db.executeUpdate(sql);

        //更新问题情况

        for(int j=1;j<=count;j++){
            problemName="problem"+j;
            answerName="answer"+j;
            problem=request.getParameter(problemName);
            answer=request.getParameter(answerName);
            String value1 =new String(problem.getBytes("iso-8859-1"),"utf-8");
            String value2 =new String(answer.getBytes("iso-8859-1"),"utf-8");
            System.out.println("问题"+value1);
            System.out.println("答案"+value2);
            sql="update "+tableName+" set answer='"+value2+"' where questionnaire_id="+
                    questionnaireId+" and answer_flag=1 and problem_id="+j+" and user_id="+userid;
            System.out.println("更新问题情况:"+sql);
            db.executeUpdate(sql);
        }
        //返回状态
        response.sendRedirect("questionnaire/publish/questionnaire_list.jsp");
        System.out.println("exit modifyResult");
    }


    private void getStatistics(HttpServletRequest request, HttpServletResponse response) throws JSONException, SQLException, IOException {
        System.out.println("enter FileManagement.getStatistics");
        HttpSession session = request.getSession();
        String sql = session.getAttribute("sql").toString();
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
            item.put("problem_id", rs.getString("problem_id"));

            if(authorization>1||rs.getInt("user_id")==user_id){
                item.put("authorization", 1);
            }else{
                item.put("authorization", 0);
            }
            queryResult.put(item);
        }
    }
}
