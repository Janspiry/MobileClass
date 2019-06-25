package util;

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
    public int getGuid()
    {
        return guid;
    }
    public void setGuid(String value)
    {
        guid = filterInt(value);
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

    private int authorization;
    public int getAuthorization()
    {
        return authorization;
    }
    public void setAuthorization(String value)
    {
        setAuthorization(filterInt(value));
    }
    public void setAuthorization(int value)
    {
        if(0 <= value && value <= 15)authorization = value;
        else authorization = -1;
    }

    private String username;
    public String getUsername()
    {
        if(username == null || username.length() == 0)return null;
        else return username;
    }
    public void setUsername(String value){ username = filter(value); }

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
    public void setFullname(String value){ fullname = filter(value); }

    private int gender;
    public int getGender()
    {
        return gender;
    }
    public void setGender(String value)
    {
        gender = filterInt(value);
        if(gender == 0)gender = -1;
    }

    private String schoolnum;
    public String getSchoolnum()
    {
        if(schoolnum == null || schoolnum.length() == 0)return null;
        else return schoolnum;
    }
    public void setSchoolnum(String value){ schoolnum = filter(value); }

    private String nativeplace;
    public String getNativeplace()
    {
        if(nativeplace == null || nativeplace.length() == 0)return null;
        else return nativeplace;
    }
    public void setNativeplace(String value){ nativeplace = filter(value); }

    private String email;
    public String getEmail()
    {
        if(email == null || email.length() == 0)return null;
        else return email;
    }
    public void setEmail(String value){ email = filter(value); }

    private String phone;
    public String getPhone()
    {
        if(phone == null || phone.length() == 0)return null;
        else return phone;
    }
    public void setPhone(String value){ phone = filter(value); }

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

    public QueryBuilder(String _tableName){
        clear();
        setTableName(_tableName);
    }

    public void clear(){
        guid=-1;
        create_time_from=null;
        create_time_to=null;
        authorization=-1;
        username=null;
        password=null;
        fullname=null;
        gender=-1;
        schoolnum=null;
        nativeplace=null;
        email=null;
        phone=null;
    }

    private String getWhereClause(){
        String sql="where 1=1";
        if(getGuid()!=-1)
            sql += String.format(" and `guid`=%d", getGuid());
        if(getCreate_time_from()!=null && getCreate_time_to()!=null)
            sql += String.format(" and `create_time` between '%s' and '%s'",
                    getCreate_time_from(), getCreate_time_to());
        if(getAuthorization()!=-1)
            sql += String.format(" and `authorization` & %d > 0", getAuthorization());
        if(getUsername()!=null)
            sql += String.format(" and `username`='%s'", getUsername());
        if(getFullname()!=null)
            sql += String.format(" and `fullname`='%s'", getFullname());
        if(getGender()!=-1)
            sql += String.format(" and `gender`=%d", getGender());
        if(getSchoolnum()!=null)
            sql += String.format(" and `schoolnum`='%s'", getSchoolnum());
        if(getNativeplace()!=null)
            sql += String.format(" and `nativeplace`='%s'", getNativeplace());
        if(getEmail()!=null)
            sql += String.format(" and `email`='%s'", getEmail());
        if(getPhone()!=null)
            sql += String.format(" and `phone`='%s'", getPhone());
        return sql;
    }

    public String getSelectStmt(){
        System.out.println("QueryBuilder.getSelectStmt");
        if(getTablename() == null)
        {
            throw new IllegalArgumentException("tableName missed");
        }
        String sql = String.format("select * from `%s` %s", getTablename(), getWhereClause());
        System.out.println(sql);
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
        if(getAuthorization()!=-1)
        {
            keyList.append(keyList.length()==0 ? '(' : ',');
            keyList.append("authorization");
            valList.append(valList.length()==0 ? "values(" : ",");
            valList.append(getAuthorization());
        }
        if(getUsername()!=null)
        {
            keyList.append(keyList.length()==0 ? '(' : ',');
            keyList.append("username");
            valList.append(valList.length()==0 ? "values(" : ",");
            valList.append(String.format("'%s'", getUsername()));
        }
        if(getPassword()!=null)
        {
            keyList.append(keyList.length()==0 ? '(' : ',');
            keyList.append("password");
            valList.append(valList.length()==0 ? "values(" : ",");
            valList.append(String.format("'%s'", getPassword()));
        }
        if(getFullname()!=null)
        {
            keyList.append(keyList.length()==0 ? '(' : ',');
            keyList.append("fullname");
            valList.append(valList.length()==0 ? "values(" : ",");
            valList.append(String.format("'%s'", getFullname()));
        }
        if(getGender()!=-1)
        {
            keyList.append(keyList.length()==0 ? '(' : ',');
            keyList.append("gender");
            valList.append(valList.length()==0 ? "values(" : ",");
            valList.append(getGender());
        }
        if(getSchoolnum()!=null)
        {
            keyList.append(keyList.length()==0 ? '(' : ',');
            keyList.append("schoolnum");
            valList.append(valList.length()==0 ? "values(" : ",");
            valList.append(String.format("'%s'", getSchoolnum()));
        }
        if(getNativeplace()!=null)
        {
            keyList.append(keyList.length()==0 ? '(' : ',');
            keyList.append("nativeplace");
            valList.append(valList.length()==0 ? "values(" : ",");
            valList.append(String.format("'%s'", getNativeplace()));
        }
        if(getEmail()!=null)
        {
            keyList.append(keyList.length()==0 ? '(' : ',');
            keyList.append("email");
            valList.append(valList.length()==0 ? "values(" : ",");
            valList.append(String.format("'%s'", getEmail()));
        }
        if(getPhone()!=null)
        {
            keyList.append(keyList.length()==0 ? '(' : ',');
            keyList.append("phone");
            valList.append(valList.length()==0 ? "values(" : ",");
            valList.append(String.format("'%s'", getPhone()));
        }
        keyList.append(')');
        valList.append(')');
        String sql = String.format("insert into `%s` %s %s",
                getTablename(), keyList.toString(), valList.toString());
        System.out.println("insert statement is "+sql);
        return sql;
    }

    public String getDeleteStmt(){
        System.out.println("QueryBuilder.getDeleteStmt");
        if(getTablename() == null)
        {
            throw new IllegalArgumentException("tableName missed");
        }
        String sql = String.format("delete from `%s` %s", getTablename(), getWhereClause());
        System.out.println(sql);
        return sql;
    }
}
