package FileManagement;

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
    private int userId;
    private int changNum;
    private int downloadNum;

    private String title;
    private String content;
    private String fileUrl;
    private String userName;
    private String createTime;
    private String changeTime;

    //传递条件查询用
    private String action;
    private String timeFrom;
    private String timeTo;
    private String timeInterval;

    private String sortIndex;
    private String orderBy;


    public int getGuid() {
        return guid;
    }

    public void setGuid(String guid) {
        this.guid = filterInt(guid);
    }

    public int getChangNum() {
        return changNum;
    }

    public void setChangNum(String changNum) {
        this.changNum = filterInt(changNum);
    }

    public int getDownloadNum() {
        return downloadNum;
    }

    public void setDownloadNum(String downloadNum) {
        this.downloadNum = filterInt(downloadNum);
    }

    public String getfileUrl() {
        return fileUrl;
    }

    public void setfileUrl(String fileUrl) {
        this.fileUrl = fileUrl;
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
        userId=-1;
        changNum=-1;
        downloadNum=-1;

        title=null;
        content=null;
        userName=null;
        createTime=null;
        changeTime=null;
        fileUrl=null;


        //传递条件查询用
        action=null;
        timeFrom=null;
        timeTo=null;
        timeInterval=null;

        sortIndex=null;
        orderBy=null;
    }
    //问卷

    public String getSelectStmt(){
        String sql="";
        String where="";
        System.out.println("where:"+where);
        if(getTitle()!=null && !getTitle().equals("null") && !getTitle().isEmpty()){
            if(!where.isEmpty()){
                where=where+" and title like '%"+getTitle()+"%'";
            }else{
                where=" where title like '%"+getTitle()+"%'";
            }
        }
        if(getUserName()!=null && !getUserName().equals("null") && !getUserName().isEmpty()){
            if(!where.isEmpty()){
                where=where+" and user_name like '%"+getUserName()+"%'";
            }else{
                where=" where user_name like '%"+getUserName()+"%'";
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

        if(getUserId()!=-1)
        {
            keyList.append(keyList.length()==0 ? '(' : ',');
            keyList.append("user_id");
            valList.append(valList.length()==0 ? "values(" : ",");
            valList.append(getUserId());
        }
        if(getDownloadNum()!=-1)
        {
            keyList.append(keyList.length()==0 ? '(' : ',');
            keyList.append("download_num");
            valList.append(valList.length()==0 ? "values(" : ",");
            valList.append(getDownloadNum());
        }
        if(getChangNum()!=-1)
        {
            keyList.append(keyList.length()==0 ? '(' : ',');
            keyList.append("change_num");
            valList.append(valList.length()==0 ? "values(" : ",");
            valList.append(getChangNum());
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
        if(getContent()!=null)
        {
            keyList.append(keyList.length()==0 ? '(' : ',');
            keyList.append("context");
            valList.append(valList.length()==0 ? "values(" : ",");
            valList.append(String.format("'%s'", getContent()));
        }

        if(getCreateTime()!=null)
        {
            keyList.append(keyList.length()==0 ? '(' : ',');
            keyList.append("create_time");
            valList.append(valList.length()==0 ? "values(" : ",");
            valList.append(String.format("'%s'", getCreateTime()));
        }
        if(getfileUrl()!=null)
        {
            keyList.append(keyList.length()==0 ? '(' : ',');
            keyList.append("file_url");
            valList.append(valList.length()==0 ? "values(" : ",");
            valList.append(String.format("'%s'", getfileUrl()));
        }
        if(getChangeTime()!=null)
        {
            keyList.append(keyList.length()==0 ? '(' : ',');
            keyList.append("change_time");
            valList.append(valList.length()==0 ? "values(" : ",");
            valList.append(String.format("'%s'", getChangeTime()));
        }

        keyList.append(')');
        valList.append(')');
        String sql = String.format("insert into `%s` %s %s",
                getTablename(), keyList.toString(), valList.toString());
        System.out.println("insert statement is "+sql);
        return sql;
    }

}
