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
                    <label class="control-label text-right col-md-3">用户名</label>
                    <div class="col-md-9">
                        <input name="username" type="text" class="form-control" placeholder="User Name">
                    </div>
                </div>
            </div>
            <div class="col-md-6">
                <div class="form-group row">
                    <label class="control-label text-right col-md-3">邮箱</label>
                    <div class="col-md-9">
                        <input name="email" type="text" class="form-control" placeholder="Email">
                    </div>
                </div>
            </div>
        </div>
        <div class="row">

            <div class="col-md-6">
                <div class="form-group row">
                    <label class="control-label text-right col-md-3">权限</label>
                    <div class="col-md-9">
                        <select name="authorization" class="form-control">
                            <option value='0'>-- 选择权限 --</option>
                            <option value='1'>学生</option>
                            <option value='2'>教师</option>
                            <option value='4'>管理员</option>
                            <option value='8'>开发者</option>
                        </select>
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

</form>