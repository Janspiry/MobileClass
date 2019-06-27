<%--
  Created by IntelliJ IDEA.
  User: silenus
  Date: 2019/6/26
  Time: 16:29
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<div class="row">
    <div class="col-lg-6">
        <div class="card">
            <div class="form-group">
                <p class="text-muted m-b-15 f-s-12">文件名</p>
                <input type="text" id="title" name="title" class="form-control input-focus" placeholder="输入问卷名">
            </div>
        </div>
    </div>
    <div class="col-lg-6">
        <div class="card">
            <div class="form-group">
                <p class="text-muted m-b-15 f-s-12">上传者</p>
                <input type="text" id="user_name" name="user_name" class="form-control input-focus" placeholder="输入上传者">
            </div>
        </div>
    </div>

</div>
<button type="button" onclick="searchRecord()" class="btn btn-default btn-flat m-b-10">查询</button>
