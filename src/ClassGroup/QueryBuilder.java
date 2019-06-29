package ClassGroup;

import java.util.regex.Pattern;

/**
 * Created by silenus on 2019/5/11.
 */
public class QueryBuilder {

    private int group_id;
    public int getGroupId()
    {
        return group_id;
    }
    public void setGroupId(String value)
    {
        group_id = filterInt(value);
    }

    String group_name;
    public String getGroupName()
    {
        if(group_name == null || group_name.length() == 0)return null;
        else return group_name;
    }
    public boolean setGroupName(String value)
    {
        if(value==null){
            group_name=null;
            return true;
        }
        String pat = "^[^/\\\\'\"%&\\$\\<\\>]+$";
        if(Pattern.matches(pat, value))
        {
            group_name=value;
            return true;
        }
        else {
            group_name=null;
            return false;
        }
    }

    private int owner_id;
    public int getOwnerId()
    {
        return owner_id;
    }
    public void setOwnerId(String value)
    {
        owner_id = filterInt(value);
    }

    private String username;
    public String getUsername()
    {
        if(username == null || username.length() == 0)return null;
        else return username;
    }
    public boolean setUsername(String value)
    {
        if(value==null){
            username=null;
            return true;
        }
        String pat = "^[_0-9A-Za-z]+$";
        if(Pattern.matches(pat, value))
        {
            username=value;
            return true;
        }
        else {
            username=null;
            return false;
        }
    }

    private String email;
    public String getEmail()
    {
        if(email == null || email.length() == 0)return null;
        else return email;
    }
    public boolean setEmail(String value){
        if(value==null){
            email=null;
            return true;
        }
        String pat = "^[_a-zA-Z0-9]+@[_a-zA-Z0-9]+(\\.com)?$";
        if(Pattern.matches(pat, value)){
            email=value;
            return true;
        }else{
            email=null;
            return false;
        }
    }

    private String sortBy;
    public String getSortByClause(){
        return (sortBy == null || sortBy.length() == 0) ? "" : "order by " + sortBy;
    }
    public boolean setSortBy(String value){
        sortBy = value;
        return true;
    }

    private int filterInt(String value) {
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

    private String filter(String value) {
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
//                case '_':
//                    esc.append("\\_");
//                    break;
                default:
                    esc.append(ch);
                    break;
            }
        }
        return esc.toString();
    }

    public QueryBuilder(){
        clear();
    }

    public void clear(){
        group_id=-1;
        group_name=null;
        owner_id=-1;
        username=null;
        email=null;
        sortBy = null;
    }

    private String getWhereClause(){
        String sql="where 1=1";
        if(getGroupId()!=-1)
            sql += String.format(" and classgroup.group_id=%d", getGroupId());
        if(getGroupName()!=null)
            sql += String.format(" and classgroup.group_name='%s'", getGroupName());
        if(getOwnerId()!=-1)
            sql += String.format(" and classgroup.owner_id=%d", getOwnerId());
        if(getUsername()!=null)
            sql += String.format(" and userinfo.username='%s'", getUsername());
        if(getEmail()!=null)
            sql += String.format(" and userinfo.email='%s'", getEmail());
        return sql;
    }

    public String getSelectStmt(){
        System.out.println("QueryBuilder.getSelectStmt");
        String sql = String.format(
                "select classgroup.*, userinfo.username, userinfo.email "+
                "from classgroup "+
                "left join userinfo "+
                "on classgroup.owner_id=userinfo.guid "+
                "%s %s", // where ... order by ...
                getWhereClause(), getSortByClause()
        );
        System.out.println(sql);
        return sql;
    }

    public String getInsertStmt(){
        StringBuffer keyList = new StringBuffer(), valList = new StringBuffer();
        if(getGroupName()!=null)
        {
            keyList.append(keyList.length()==0 ? '(' : ',');
            keyList.append("group_name");
            valList.append(valList.length()==0 ? "values(" : ",");
            valList.append(String.format("'%s'", getGroupName()));
        }
        if(getOwnerId()!=-1)
        {
            keyList.append(keyList.length()==0 ? '(' : ',');
            keyList.append("owner_id");
            valList.append(valList.length()==0 ? "values(" : ",");
            valList.append(getOwnerId());
        }
        keyList.append(')');
        valList.append(')');
        String sql = String.format("insert into `classgroup` %s %s",
                keyList.toString(), valList.toString());
        System.out.println("insert statement is "+sql);
        return sql;
    }

    public String getDeleteStmt() throws Exception {
        System.out.println("QueryBuilder.getDeleteStmt");
        if(getWhereClause().equals("where 1=1")){
            throw new Exception("警告，未设置条件，将删除所以记录");
        }
        String sql = String.format("delete from `classgroup` %s", getWhereClause());
        System.out.println(sql);
        return sql;
    }

    public String getUpdateStmt(){
        System.out.println("QueryBuilder.getUpdateStmt");
        if(getGroupId()==-1){
            throw new IllegalArgumentException("getUpdateStmt: 没有设置guid");
        }
        String sql = String.format("update `classgroup` set group_id=%d", getGroupId());
        if(getGroupName()!=null)
        {
            sql += String.format(", `group_name`='%s'", getGroupName());
        }
        if(getOwnerId()!=-1)
        {
            sql += String.format(", `owner_id`=%d", getOwnerId());
        }
        sql += String.format(" where `group_id`=%d", getGroupId());
        System.out.println(sql);
        return sql;
    }
}
