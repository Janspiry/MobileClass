<%--
  Created by IntelliJ IDEA.
  User: silenus
  Date: 2019/6/26
  Time: 16:28
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<form id="form-add" method="post" action="#" class="form-horizontal">
    <div class="form-body">
        <div class="row">
            <div class="col-md-6">
                <div class="form-group row">
                    <label class="control-label text-right col-md-3">分组名称</label>
                    <div class="col-md-9">
                        <input name="group_name" type="text" class="form-control" placeholder="填写分组名称">
                    </div>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-md-6">
                <div class="form-group row">
                    <label class="control-label text-right col-md-3">所有者</label>
                    <div class="col-md-9">
                        <select id="id_or_email" name="id_or_email" class="form-control">
                            <option value='email'>邮箱</option>
                            <option value='owner_id'>ID</option>
                        </select>
                    </div>
                </div>
            </div>
            <div class="col-md-6">
                <div class="form-group row">
                    <label class="control-label text-right col-md-3"></label>
                    <div class="col-md-9">
                        <input name="owner" type="text" class="form-control" placeholder="所有者ID或邮箱">
                    </div>
                </div>
            </div>
        </div>
    </div>

    <hr>
    <div class="form-actions">
        <div class="row">
            <div class="col-md-4"></div>
            <button type="button" id="form-add-submit" class="col-md-2 btn btn-success">添加</button>
            <button type="button" id="form-add-reset" class="col-md-2 btn btn-inverse" style="margin-left: 20px;">清空</button>
        </div>
    </div>
</form>