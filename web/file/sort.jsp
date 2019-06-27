<%--
  Created by IntelliJ IDEA.
  User: silenus
  Date: 2019/6/26
  Time: 16:29
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<div class="row">

    <div class="col-lg-12">
        <label class="control-label">第一字段规则</label>
        <select id="rule1" data-placeholder="asc" tabindex="1">
            <option value="asc" selected="selected">升序</option>
            <option value="desc">降序</option>
        </select>
        <label class="control-label">第二字段规则</label>
        <select id="rule2"data-placeholder="asc" tabindex="2">
            <option value="asc" selected="selected">升序</option>
            <option value="desc">降序</option>
        </select>
        <label class="control-label">第三字段规则</label>
        <select id="rule3" data-placeholder="asc" tabindex="3">
            <option value="asc" selected="selected">升序</option>
            <option value="desc">降序</option>
        </select>

        <div class="form-group">
            <label>字段选择</label>
            <select id="key1" class="form-control">
                <option value="create_time" selected="selected">上传时间</option>
                <option value="change_time" >最近修改时间</option>
                <option value="download_num" >下载数</option>
            </select>
        </div>
        <div class="form-group">
            <select id="key2" class="form-control">
                <option value="" selected="selected">请选择</option>
                <option value="change_time" >最近修改时间</option>
                <option value="create_time">上传时间</option>
                <option value="download_num" >下载数</option>
            </select>
        </div>
        <div class="form-group">
            <select id="key3" class="form-control">
                <option value="" selected="selected">请选择</option>
                <option value="download_num" >下载数</option>
                <option value="change_time" >最近修改时间</option>
                <option value="create_time">上传时间</option>
            </select>
        </div>
    </div>
</div>
<button type="button" onclick="sortRecord()" class="btn btn-default btn-flat m-b-10">确认</button>