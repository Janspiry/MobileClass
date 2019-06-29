<%--
  Created by IntelliJ IDEA.
  User: silenus
  Date: 2019/6/26
  Time: 16:29
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<form id="form-query" method="post" action="#" class="form-horizontal">
    <div class="form-body">
        <div class="row">
            <div class="col-md-6">
                <div class="form-group row">
                    <label class="control-label text-right col-md-3">组ID</label>
                    <div class="col-md-9">
                        <input name="group_id" type="text" class="form-control" placeholder="Group ID">
                    </div>
                </div>
            </div>
            <div class="col-md-6">
                <div class="form-group row">
                    <label class="control-label text-right col-md-3">分组名称</label>
                    <div class="col-md-9">
                        <input name="group_name" type="text" class="form-control" placeholder="Group Name">
                    </div>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-md-6">
                <div class="form-group row">
                    <label class="control-label text-right col-md-3">所有者ID</label>
                    <div class="col-md-9">
                        <input name="owner_id" type="text" class="form-control" placeholder="Owner ID">
                    </div>
                </div>
            </div>
            <div class="col-md-6">
                <div class="form-group row">
                    <label class="control-label text-right col-md-3">所有者用户名</label>
                    <div class="col-md-9">
                        <input name="username" type="text" class="form-control" placeholder="Owner Name">
                    </div>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-md-6">
                <div class="form-group row">
                    <label class="control-label text-right col-md-3">所有者邮箱</label>
                    <div class="col-md-9">
                        <input name="email" type="text" class="form-control" placeholder="Owner Email">
                    </div>
                </div>
            </div>
        </div>
    </div>

    <hr>
    <div class="form-actions">
        <div class="row">
            <div class="col-md-4"></div>
            <button type="button" id="form-query-submit" class="col-md-2 btn btn-success">查询</button>
            <button type="button" id="form-query-reset" class="col-md-2 btn btn-inverse" style="margin-left: 20px;">清除查询</button>
        </div>
    </div>
</form>
