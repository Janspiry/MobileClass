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
                    <label class="control-label text-right col-md-3">用户名</label>
                    <div class="col-md-9">
                        <input name="username" type="text" class="form-control" placeholder="User Name">
                    </div>
                </div>
            </div>
            <div class="col-md-6">
                <div class="form-group row">
                    <label class="control-label text-right col-md-3">籍贯</label>
                    <div class="col-md-9">
                        <input name="nativeplace" type="text" class="form-control" placeholder="Native Place">
                    </div>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-md-6">
                <div class="form-group row">
                    <label class="control-label text-right col-md-3">姓名</label>
                    <div class="col-md-9">
                        <input name="fullname" type="text" class="form-control" placeholder="Full Name">
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
                    <label class="control-label text-right col-md-3">性别</label>
                    <div class="col-md-9">
                        <select name="gender" class="form-control">
                            <option value="0">-- Gender --</option>
                            <option value="1">男</option>
                            <option value="2">女</option>
                        </select>
                    </div>
                </div>
            </div>
            <div class="col-md-6">
                <div class="form-group row">
                    <label class="control-label text-right col-md-3">电话</label>
                    <div class="col-md-9">
                        <input name="phone" type="text" class="form-control" placeholder="Phone">
                    </div>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-md-6">
                <div class="form-group row">
                    <label class="control-label text-right col-md-3">学号</label>
                    <div class="col-md-9">
                        <input name="schoolnum" type="text" class="form-control" placeholder="School Number">
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
