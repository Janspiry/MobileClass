package Member;

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

    private int user_id;
    public int getUserId()
    {
        return user_id;
    }
    public void setUserId(String value)
    {
        user_id = filterInt(value);
    }

    private String create_time_from;
    public String getCreate_time_from()
    {
        if(create_time_from == null || create_time_from.length() == 0)return null;
        else return create_time_from;
    }
    public void setCreate_time_from(String value){ create_time_from = filter(value); }

    private String create_time_to;
    public String getCreate_time_to()
    {
        if(create_time_to == null || create_time_to.length() == 0)return null;
        else return create_time_to;
    }
    public void setCreate_time_to(String value){ create_time_to = filter(value); }

    private String modify_time_from;
    public String getModify_time_from()
    {
        if(modify_time_from == null || modify_time_from.length() == 0)return null;
        else return modify_time_from;
    }
    public void setModify_time_from(String value){ modify_time_from = filter(value); }

    private String modify_time_to;
    public String getModify_time_to()
    {
        if(modify_time_to == null || modify_time_to.length() == 0)return null;
        else return modify_time_to;
    }
    public void setModify_time_to(String value){ modify_time_to = filter(value); }

    private int authorization;
    public int getAuthorization()
    {
        return authorization;
    }
    public boolean setAuthorization(String value)
    {
        return setAuthorization(filterInt(value));
    }
    public boolean setAuthorization(int value)
    {
        if(1 <= value && value <= 15){
            authorization = value;
            return true;
        }
        else {
            authorization = -1;
            return false;
        }
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

    private String password;
    public String getPassword()
    {
        if(password == null || password.length() == 0)return null;
        else return password;
    }
    public void setPassword(String value) { password = filter(value); }

    private String fullname;
    public String getFullname()
    {
        if(fullname == null || fullname.length() == 0)return null;
        else return fullname;
    }
    public boolean setFullname(String value){
        if(value==null){
            fullname=null;
            return true;
        }
        String pat = "^[\\u4e00-\\u9fa5_a-zA-Z0-9]+$";
        if(Pattern.matches(pat, value)){
            fullname=value;
            return true;
        }else{
            fullname=null;
            return false;
        }
    }

    private int gender;
    public int getGender()
    {
        return gender;
    }
    public boolean setGender(String value)
    {
        gender = filterInt(value);
        if(gender == 0)gender = -1;
        return true;
    }

    private String schoolnum;
    public String getSchoolnum()
    {
        if(schoolnum == null || schoolnum.length() == 0)return null;
        else return schoolnum;
    }
    public boolean setSchoolnum(String value){
        if(value==null){
            schoolnum=null;
            return true;
        }
        String pat = "^[_0-9A-Za-z]+$";
        if(Pattern.matches(pat, value))
        {
            schoolnum=value;
            return true;
        }
        else {
            schoolnum=null;
            return false;
        }
    }

    private String nativeplace;
    public String getNativeplace()
    {
        if(nativeplace == null || nativeplace.length() == 0)return null;
        else return nativeplace;
    }
    public boolean setNativeplace(String value){
        if(value==null){
            nativeplace=null;
            return true;
        }
        String pat = "^[\\u4e00-\\u9fa5_a-zA-Z0-9]+$";
        if(Pattern.matches(pat, value)){
            nativeplace=value;
            return true;
        }else{
            nativeplace=null;
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

    private String phone;
    public String getPhone()
    {
        if(phone == null || phone.length() == 0)return null;
        else return phone;
    }
    public boolean setPhone(String value){
        if(value==null){
            phone=null;
            return true;
        }
        String pat = "^[0-9]{3,15}$";
        if(Pattern.matches(pat, value)){
            phone=value;
            return true;
        }else{
            phone=null;
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
        user_id=-1;
        create_time_from=null;
        create_time_to=null;
        modify_time_from=null;
        modify_time_to=null;
        authorization=-1;
        username=null;
        password=null;
        fullname=null;
        gender=-1;
        schoolnum=null;
        nativeplace=null;
        email=null;
        phone=null;
        sortBy = null;
    }

    private String getWhereClause(){
        String sql="where 1=1";
        if(getGroupId()!=-1)
            sql += String.format(" and groupmember.group_id=%d", getGroupId());
        if(getUserId()!=-1)
            sql += String.format(" and groupmember.user_id=%d", getUserId());
        if(getCreate_time_from()!=null && getCreate_time_to()!=null)
            sql += String.format(" and userinfo.create_time between '%s' and '%s'",
                    getCreate_time_from(), getCreate_time_to());
        if(getModify_time_from()!=null && getModify_time_to()!=null)
            sql += String.format(" and userinfo.modify_time between '%s' and '%s'",
                    getModify_time_from(), getModify_time_to());
        if(getAuthorization()!=-1)
            sql += String.format(" and userinfo.authorization & %d > 0", getAuthorization());
        if(getUsername()!=null)
            sql += String.format(" and userinfo.username='%s'", getUsername());
        if(getFullname()!=null)
            sql += String.format(" and userinfo.fullname='%s'", getFullname());
        if(getGender()!=-1)
            sql += String.format(" and userinfo.gender=%d", getGender());
        if(getSchoolnum()!=null)
            sql += String.format(" and userinfo.schoolnum='%s'", getSchoolnum());
        if(getNativeplace()!=null)
            sql += String.format(" and userinfo.nativeplace='%s'", getNativeplace());
        if(getEmail()!=null)
            sql += String.format(" and userinfo.email='%s'", getEmail());
        if(getPhone()!=null)
            sql += String.format(" and userinfo.phone='%s'", getPhone());
        return sql;
    }

    public String getSelectStmt(){
        System.out.println("QueryBuilder.getSelectStmt");
        String sql = String.format(
                "select userinfo.* " +
                "from groupmember " +
                "left join userinfo " +
                "on groupmember.user_id = userinfo.guid " +
                "%s %s",
                getWhereClause(), getSortByClause()
        );
        System.out.println(sql);
        return sql;
    }

    public String getInsertStmt(){
        String sql = String.format("insert into `groupmember` (`group_id`, `user_id`) values('%s', '%s')", getGroupId(), getUserId());
        System.out.println("insert statement is "+sql);
        return sql;
    }

    public String getDeleteStmt() throws Exception {
        System.out.println("QueryBuilder.getDeleteStmt");
        if(getUserId()==-1 || getGroupId()==-1){
            throw new Exception("没有设置user_id或group_id");
        }
        String sql = String.format("delete from `groupmember` where `group_id`=%d and `user_id`=%d", getGroupId(), getUserId());
        System.out.println(sql);
        return sql;
    }

//    public String getUpdateStmt(){
//        System.out.println("QueryBuilder.getUpdateStmt");
//        String sql="";
//        if(getGuid()==-1){
//            throw new IllegalArgumentException("getUpdateStmt: 没有设置guid");
//        }
//        String sql = String.format("update `%s` set guid=%d", getTablename(), getGuid());
//        if(getAuthorization()!=-1)
//        {
//            sql += String.format(", `authorization`=%d", getAuthorization());
//        }
//        if(getUsername()!=null)
//        {
//            sql += String.format(", `username`='%s'", getUsername());
//        }
//        if(getPassword()!=null)
//        {
//            sql += String.format(", `password`='%s'", getPassword());
//        }
//        if(getFullname()!=null)
//        {
//            sql += String.format(", `fullname`='%s'", getFullname());
//        }
//        if(getGender()!=-1)
//        {
//            sql += String.format(", `gender`=%d", getGender());
//        }
//        if(getSchoolnum()!=null)
//        {
//            sql += String.format(", `schoolnum`='%s'", getSchoolnum());
//        }
//        if(getNativeplace()!=null)
//        {
//            sql += String.format(", `nativeplace`='%s'", getNativeplace());
//        }
//        if(getEmail()!=null)
//        {
//            sql += String.format(", `email`='%s'", getEmail());
//        }
//        if(getPhone()!=null)
//        {
//            sql += String.format(", `phone`='%s'", getPhone());
//        }
//        sql += String.format(" where `guid`=%d", getGuid());
//        System.out.println(sql);
//        return sql;
//    }
}