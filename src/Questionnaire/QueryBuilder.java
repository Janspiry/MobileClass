package Questionnaire;

import util.DatabaseHelper;

import java.sql.ResultSet;
import java.sql.SQLException;

/**
 * Created by silenus on 2019/5/11.
 */
public class QueryBuilder {
    private String tableName;
    public String getTablename()
    {
        if(tableName == null || tableName.length() == 0)return null;
        else return tableName;
    }
    public void setTableName(String value){ tableName = filter(value); }

    private int guid;
    private int questionnaireId;
    private int url;
    private int userId;
    private int problemId;
    private int answeFlag;
    private int userFlag;
    private int answerNum;

    private String title;
    private String content;
    private String limitTime;

    private String userName;
    private String creator;
    private String createTime;
    private String changeTime;
    private String problem;
    private String answer;

    //传递条件查询用
    private String action;
    private String type;
    private String timeFrom;
    private String timeTo;
    private String timeInterval;
    private String status;

    private String sortIndex;
    private String orderBy;


    public int getGuid() {
        return guid;
    }

    public void setGuid(String guid) {
        this.guid = filterInt(guid);
    }
    public int getQuestionnaireId() {
        return questionnaireId;
    }

    public void setQuestionnaireId(String questionnaireId) {
        this.questionnaireId = filterInt(questionnaireId);
    }

    public int getproblemId() {
        return problemId;
    }

    public void setProblemId(String problemId) {
        this.problemId = filterInt(problemId);
    }


    public int getAnswerNum() {
        return answerNum;
    }

    public void setAnswerNum(String answerNum) {
        this.answerNum = filterInt(answerNum);
    }
    public int getAnsweFlag() {
        return answeFlag;
    }

    public void setAnsweFlag(String answeFlag) {
        this.answeFlag = filterInt(answeFlag);
    }

    public int getUserFlag() {
        return userFlag;
    }

    public void setUserFlag(String userFlag) {
        this.userFlag = filterInt(userFlag);
    }



    public String getProblem() {
        return problem;
    }

    public void setProblem(String problem) {
        this.problem = filter(problem);
    }
    public String getAnswer() {
        return answer;
    }

    public void setAnswer(String answer) {
        this.answer = filter(answer);
    }

    public int getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = filterInt(url);
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = filter(title);
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = filter(content);
    }
    public int getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = filterInt(userId);
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }
    public String getCreator() {
        return creator;
    }

    public void setCreator(String creator) {
        this.creator = creator;
    }

    public String getCreateTime() {
        return createTime;
    }

    public void setCreateTime(String createTime) {
        this.createTime = createTime;
    }

    public String getChangeTime() {
        return changeTime;
    }

    public void setChangeTime(String changeTime) {
        this.changeTime = changeTime;
    }

    public String getAction() {
        return action;
    }

    public void setAction(String action) {
        this.action = action;
    }

    public String getLimitTime() {
        return limitTime;
    }

    public void setLimitTime(String limitTime) {
        this.limitTime = limitTime;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public String getTimeFrom() {
        return timeFrom;
    }

    public void setTimeFrom(String timeFrom) {
        this.timeFrom = timeFrom;
    }

    public String getTimeTo() {
        return timeTo;
    }

    public void setTimeTo(String timeTo) {
        this.timeTo = timeTo;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getTimeInterval() {
        return timeInterval;
    }

    public void setTimeInterval(String timeInterval) {
        this.timeInterval = timeInterval;
    }

    public void setSortIndex(String sortIndex) {
        this.sortIndex=sortIndex;
    }
    public String getSortIndex() {
        return sortIndex;
    }

    public void setOrderBy(String orderBy) {
        this.orderBy=orderBy;
    }
    public String getOrderBy() {
        return orderBy;
    }

    private int filterInt(String value)
    {
        if(value == null || value.length() == 0)return -1;
        int esc = -1;
        try
        {
            esc = Integer.parseInt(value);
        }
        catch (NumberFormatException ex)
        {
            esc = -1;
        }
        return esc;
    }

    private String filter(String value)
    {
        if(value == null || value.length() == 0)return null;
        StringBuffer esc = new StringBuffer();
        for(int i=0;i<value.length();i++)
        {
            char ch=value.charAt(i);
            switch (ch)
            {
                case '\0':
                    esc.append("\\0");
                    break;
                case '\n':
                    esc.append("\\n");
                    break;
                case '\r':
                    esc.append("\\r");
                    break;
                case '\'':
                    esc.append("\\'");
                    break;
                case '"':
                    esc.append("\\\"");
                    break;
                case '\\':
                    esc.append("\\\\");
                    break;
                case '%':
                    esc.append("\\%");
                    break;
                case '_':
                    esc.append("\\_");
                    break;
                default:
                    esc.append(ch);
                    break;
            }
        }
        return esc.toString();
    }

    public QueryBuilder(String _tableName){
        clear();
        setTableName(_tableName);
    }

    public void clear(){
        guid=-1;
        questionnaireId=-1;
        userId=-1;
        problemId=-1;
        answeFlag=0;
        userFlag=0;
        url=-1;

        title=null;
        content=null;
        limitTime=null;

        userName=null;
        creator=null;
        createTime=null;
        changeTime=null;
        problem=null;
        answer=null;

        //传递条件查询用
        action=null;
        type=null;
        timeFrom=null;
        timeTo=null;
        timeInterval=null;
        status=null;

        sortIndex=null;
        orderBy=null;
    }
    //问卷

    public String getSelectStmt(){
        String sql="";
        String where=" where problem_id=-1";
        System.out.println("where:"+where);
        if(getTitle()!=null && !getTitle().equals("null") && !getTitle().isEmpty()){
            if(!where.isEmpty()){
                where=where+" and title like '%"+getTitle()+"%'";
            }else{
                where="where title like '%"+getTitle()+"%'";
            }
        }
        if(getCreator()!=null && !getCreator().equals("null") && !getCreator().isEmpty()){
            if(!where.isEmpty()){
                where=where+" and author_name like '%"+getCreator()+"%'";
            }else{
                where="where author_name like '%"+getCreator()+"%'";
            }
        }
        if(getTimeFrom()!=null && getTimeTo()!=null && !getTimeFrom().isEmpty()){
            if(!where.isEmpty()){
                where=where+" and create_time between '"+getTimeFrom()+"' and '"+getTimeTo()+"'";
            }else{
                where="where create_time between '"+getTimeFrom()+"' and '"+getTimeTo()+"'";
            }
        }
        String orderBy="";
        if(getOrderBy()!=null&&getOrderBy()!=""){
            orderBy=" order by "+getOrderBy();
        }
        if(orderBy==""||orderBy.equals("")){
            orderBy=" order by create_time desc";
        }
        System.out.println("where+order:"+where);
        sql="select * from "+getTablename()+where+orderBy;
        System.out.println("sql"+sql);
        return sql;
    }

    public String getInsertStmt(){
        if(getTablename() == null)
        {
            throw new IllegalArgumentException("tableName missed");
        }
        StringBuffer keyList = new StringBuffer(), valList = new StringBuffer();
        if(getGuid()!=-1)
        {
            keyList.append(keyList.length()==0 ? '(' : ',');
            keyList.append("guid");
            valList.append(valList.length()==0 ? "values(" : ",");
            valList.append(getGuid());
        }
        keyList.append(keyList.length()==0 ? '(' : ',');
        keyList.append("questionnaire_id");
        valList.append(valList.length()==0 ? "values(" : ",");
        valList.append(getQuestionnaireId());

        if(getUrl()!=-1)
        {
            keyList.append(keyList.length()==0 ? '(' : ',');
            keyList.append("url");
            valList.append(valList.length()==0 ? "values(" : ",");
            valList.append(getUrl());
        }
        if(getUserId()!=-1)
        {
            keyList.append(keyList.length()==0 ? '(' : ',');
            keyList.append("user_id");
            valList.append(valList.length()==0 ? "values(" : ",");
            valList.append(getUserId());
        }
        if(getAnsweFlag()!=-1)
        {
            keyList.append(keyList.length()==0 ? '(' : ',');
            keyList.append("answer_flag");
            valList.append(valList.length()==0 ? "values(" : ",");
            valList.append(getAnsweFlag());
        }
        if(getUserFlag()!=-1)
        {
            keyList.append(keyList.length()==0 ? '(' : ',');
            keyList.append("user_flag");
            valList.append(valList.length()==0 ? "values(" : ",");
            valList.append(getUserFlag());
        }

        if(getUserName()!=null)
        {
            keyList.append(keyList.length()==0 ? '(' : ',');
            keyList.append("user_name");
            valList.append(valList.length()==0 ? "values(" : ",");
            valList.append(String.format("'%s'", getUserName()));
        }
        if(getTitle()!=null)
        {
            keyList.append(keyList.length()==0 ? '(' : ',');
            keyList.append("title");
            valList.append(valList.length()==0 ? "values(" : ",");
            valList.append(String.format("'%s'", getTitle()));
        }
        keyList.append(keyList.length()==0 ? '(' : ',');
        keyList.append("problem_id");
        valList.append(valList.length()==0 ? "values(" : ",");
        valList.append(getproblemId());
        if(getProblem()!=null)
        {
            keyList.append(keyList.length()==0 ? '(' : ',');
            keyList.append("problem");
            valList.append(valList.length()==0 ? "values(" : ",");
            valList.append(String.format("'%s'", getProblem()));
        }
        if(getAnswer()!=null)
        {
            keyList.append(keyList.length()==0 ? '(' : ',');
            keyList.append("answer");
            valList.append(valList.length()==0 ? "values(" : ",");
            valList.append(String.format("'%s'", getAnswer()));
        }
        if(getCreator()!=null)
        {
            keyList.append(keyList.length()==0 ? '(' : ',');
            keyList.append("author_name");
            valList.append(valList.length()==0 ? "values(" : ",");
            valList.append(String.format("'%s'", getCreator()));
        }
        if(getCreateTime()!=null)
        {
            keyList.append(keyList.length()==0 ? '(' : ',');
            keyList.append("create_time");
            valList.append(valList.length()==0 ? "values(" : ",");
            valList.append(String.format("'%s'", getCreateTime()));
        }
        if(getLimitTime()!=null)
        {
            keyList.append(keyList.length()==0 ? '(' : ',');
            keyList.append("limit_time");
            valList.append(valList.length()==0 ? "values(" : ",");
            valList.append(String.format("'%s'", getLimitTime()));
        }
        if(getChangeTime()!=null)
        {
            keyList.append(keyList.length()==0 ? '(' : ',');
            keyList.append("change_time");
            valList.append(valList.length()==0 ? "values(" : ",");
            valList.append(String.format("'%s'", getChangeTime()));
        }
        if(getStatus()!=null)
        {
            keyList.append(keyList.length()==0 ? '(' : ',');
            keyList.append("status");
            valList.append(valList.length()==0 ? "values(" : ",");
            valList.append(String.format("'%s'", getStatus()));
        }

        keyList.append(')');
        valList.append(')');
        String sql = String.format("insert into `%s` %s %s",
                getTablename(), keyList.toString(), valList.toString());
        System.out.println("insert statement is "+sql);
        return sql;
    }

    //回答
    public String getAnswerSql() throws SQLException {
        String sql="";
        String where="";
        System.out.print("构造sql语句: ");
        System.out.println("id:"+getGuid()+" type:"+getType());
        String type=getType();

        DatabaseHelper db = new DatabaseHelper();
        ResultSet rs;
        if(type!=null&&(type.equals("user")||type=="user")){
            //构造sql语句，根据传递过来的查询条件参数
            sql="select * from "+getTablename()+" where guid="+getGuid();
            rs=db.executeQuery(sql);
            String questionId="";
            rs.next();
            questionId=rs.getString("questionnaire_id");

            where=" where questionnaire_id="+questionId+" and user_flag=1";
            System.out.println("where:"+where);

            if(getUserName()!=null&&getUserName()!=""){
                where=where+" and user_name like '%"+getUserName()+"%'";
            }
            String orderBy="";
            if(getOrderBy()!=null&&getOrderBy()!=""){
                orderBy=" order by "+getOrderBy();
            }
            if(orderBy==""||orderBy.equals("")){
                orderBy=" order by create_time desc";
            }
            System.out.println("where+order:"+where);
            sql="select * from "+getTablename()+where+orderBy;
        }else if(type!=null&&(type.equals("question")||type=="question")){
            sql="select * from "+getTablename()+" where guid="+getGuid();
            rs = db.executeQuery(sql);
            String questionId="";
            while (rs.next()) {
                questionId=rs.getString("questionnaire_id");
            }
            sql="select * from "+getTablename()+" where problem_id!=-1 and questionnaire_id="
                    +questionId+" and user_flag=0 and answer_flag=0 order by problem_id asc";
        }else if(type!=null&&(type.equals("answer")||type=="answer")){
            sql="select * from "+getTablename()+" where guid="+getGuid();
            rs = db.executeQuery(sql);
            String questionId="";
            String userId="";
            while (rs.next()) {
                questionId=rs.getString("questionnaire_id");
                userId=rs.getString("user_id");
            }
            sql="select * from "+getTablename()+" where questionnaire_id="+
                    questionId+" and problem_id!=-1 and user_id="+userId+
                    " and answer_flag=1 order by problem_id asc";
        }
        System.out.println("get sql:"+sql);
        return sql;
    }

}
