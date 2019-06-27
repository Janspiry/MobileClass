<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!-- Start Page Content -->
<button type="button" id="submit_button" class="btn btn-primary m-b-10 m-l-5">确认上传</button>
<%--<form  role="form" id="page_form" name="page_form" action="add_record">--%>
    <div class="row">
        <div class="col-12">
            <div class="card">
                <div class="card-body">
                    <h4 class="card-title">上传文件</h4>
                    <h6 class="card-subtitle">选择或<code>拖动</code>要上传的文件到此区域</h6>
                    <form id="myDropzone" action="/FileManagement?action=add_record" class="dropzone">
                        <div class="row">
                            <div class="col-md-12 ">
                                <div class="form-group">
                                    <label>问卷名</label>
                                    <input type="text" id="title" name="title" class="form-control" required>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12 ">
                                <div class="form-group">
                                    <label class="control-label">文件介绍</label>
                                    <input type="text" id="context" name="context" class="form-control">
                                </div>
                            </div>
                        </div>
                        <div class="fallback">
                            <input name="file" type="file"/>
                        </div>
                    </form>
                    <%--<div id="myDropzone"  class="dropzone">--%>

                    <%--</div>--%>
                </div>
            </div>
        </div>
    </div>
<%--</form>--%>