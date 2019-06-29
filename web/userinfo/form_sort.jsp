<%--
  Created by IntelliJ IDEA.
  User: silenus
  Date: 2019/6/27
  Time: 15:49
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<div class="row">

    <div class="col-md-1"></div>

    <div class="col-md-5">
        <div class="card" style="background-color: rgb(250,255,255);">
            <div class="card-body">
                <h4 class="card-title">排序规则</h4>
                <div class="card-content">
                    <div class="nestable">
                        <div class="dd" id="form-sort-rule">
                            <ol class="dd-list">

                            </ol>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="col-md-5">
        <div class="card" style="background-color: rgb(250,255,255);">
            <div class="card-body">
                <h4 class="card-title">候选规则</h4>
                <div class="card-content">
                    <div class="nestable">
                        <div class="dd" id="form-sort-choice">
                            <ol class="dd-list">

                            </ol>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="col-md-1"></div>

</div>

<div class="row">
    <div class="col-md-4"></div>
    <button id="form-sort-submit" class="col-md-2 btn btn-success">排序</button>
    <button id="form-sort-reset" class="col-md-2 btn btn-inverse" style="margin-left: 20px;">清除排序</button>
</div>

<%--<form id="form-sort" action="#" class="form-horizontal">--%>
    <%--<div class="form-body">--%>
        <%--<div class="row">--%>
            <%--<div class="col-md-6">--%>
                <%--<div class="form-group row">--%>
                    <%--<label class="control-label text-right col-md-3">关键字1</label>--%>
                    <%--<div class="col-md-9">--%>
                        <%--<select name="keyword1" class="form-control">--%>
                            <%--<option value="username">用户名</option>--%>
                            <%--<option value="fullname">姓名</option>--%>
                            <%--<option value="schoolnum">学号</option>--%>
                            <%--<option value="nativeplace">籍贯</option>--%>
                            <%--<option value="email">邮箱</option>--%>
                            <%--<option value="phone">电话</option>--%>
                        <%--</select>--%>
                    <%--</div>--%>
                <%--</div>--%>
            <%--</div>--%>
            <%--<div class="col-md-6">--%>
                <%--<div class="form-group row">--%>
                    <%--<label class="control-label text-right col-md-3">排序方式1</label>--%>
                    <%--<div class="col-md-9">--%>
                        <%--<select name="order1" class="form-control">--%>
                            <%--<option value="asc">升序</option>--%>
                            <%--<option value="desc">降序</option>--%>
                        <%--</select>--%>
                    <%--</div>--%>
                <%--</div>--%>
            <%--</div>--%>
        <%--</div>--%>
        <%--<div class="row">--%>
            <%--<div class="col-md-6">--%>
                <%--<div class="form-group row">--%>
                    <%--<label class="control-label text-right col-md-3">关键字2</label>--%>
                    <%--<div class="col-md-9">--%>
                        <%--<select name="keyword2" class="form-control">--%>
                            <%--<option value="username">用户名</option>--%>
                            <%--<option value="fullname">姓名</option>--%>
                            <%--<option value="schoolnum">学号</option>--%>
                            <%--<option value="nativeplace">籍贯</option>--%>
                            <%--<option value="email">邮箱</option>--%>
                            <%--<option value="phone">电话</option>--%>
                        <%--</select>--%>
                    <%--</div>--%>
                <%--</div>--%>
            <%--</div>--%>
            <%--<div class="col-md-6">--%>
                <%--<div class="form-group row">--%>
                    <%--<label class="control-label text-right col-md-3">排序方式2</label>--%>
                    <%--<div class="col-md-9">--%>
                        <%--<select name="gender" class="form-control">--%>
                            <%--<option value="asc">升序</option>--%>
                            <%--<option value="desc">降序</option>--%>
                        <%--</select>--%>
                    <%--</div>--%>
                <%--</div>--%>
            <%--</div>--%>
        <%--</div>--%>
        <%--<div class="row">--%>
            <%--<div class="col-md-6">--%>
                <%--<div class="form-group row">--%>
                    <%--<label class="control-label text-right col-md-3">关键字3</label>--%>
                    <%--<div class="col-md-9">--%>
                        <%--<select name="keyword1" class="form-control">--%>
                            <%--<option value="username">用户名</option>--%>
                            <%--<option value="fullname">姓名</option>--%>
                            <%--<option value="schoolnum">学号</option>--%>
                            <%--<option value="nativeplace">籍贯</option>--%>
                            <%--<option value="email">邮箱</option>--%>
                            <%--<option value="phone">电话</option>--%>
                        <%--</select>--%>
                    <%--</div>--%>
                <%--</div>--%>
            <%--</div>--%>
            <%--<div class="col-md-6">--%>
                <%--<div class="form-group row">--%>
                    <%--<label class="control-label text-right col-md-3">排序方式3</label>--%>
                    <%--<div class="col-md-9">--%>
                        <%--<select name="gender" class="form-control">--%>
                            <%--<option value="asc">升序</option>--%>
                            <%--<option value="desc">降序</option>--%>
                        <%--</select>--%>
                    <%--</div>--%>
                <%--</div>--%>
            <%--</div>--%>
        <%--</div>--%>
    <%--</div>--%>
    <%--<hr>--%>
    <%--<div class="form-actions">--%>
        <%--<div class="row">--%>
            <%--<div class="col-md-6">--%>
                <%--<div class="row">--%>
                    <%--<div class="col-md-offset-3 col-md-9">--%>
                        <%--<button type="submit" class="btn btn-success">查询</button>--%>
                        <%--<button type="button" class="btn btn-inverse">清空</button>--%>
                    <%--</div>--%>
                <%--</div>--%>
            <%--</div>--%>
            <%--<div class="col-md-6"> </div>--%>
        <%--</div>--%>
    <%--</div>--%>
<%--</form>--%>