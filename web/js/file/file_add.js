var question_list=[];
var module="/FileManagement";
var existResultset="0";
var ContextPath=$("#ContextPath").val();
var initurl=ContextPath+module;

Dropzone.autoDiscover = false;// 禁止对所有元素的自动查找，由于Dropzone会自动查找class为dropzone的元素，自动查找后再在这里进行初始化，有时候（并不是都这样）会导致重复初始化的错误，所以在此加上这段代码避免这样的错误。
$("#myDropzone").dropzone({
    //项目使用.net，所以此处的action就这样了。该参数必须指定。
    url: initurl+"?action=add_record",
    method: 'post',
    parallelUploads: 1,//有多少文件将上载到并行处理,默认2(一次最多上传不能超过6个，小于等于6个的传完后，再上传  //第二批的文件)
    maxFiles:1,
    maxFilesize: 30,//以MB为单位[上传文件的大小限制]
    autoProcessQueue: false,//关闭自动上传功能，默认会true会自动上传,也就是添加一张图片向服务器发送一次请求
    addRemoveLinks: true,//在每个预览文件下面添加一个remove[删除]或者cancel[取消](如果文件已经上传)上传文件的链  接
    uploadMultiple: false,//允许上传多文件
    dictCancelUpload: '取消',
    dictRemoveFile: '删除',
    init: function () {
        var submitButton = $("#submit_button")
        var title = $("#title")
        var context = $("#context")
        var addr=initurl+"?action=add_record";
        myDropzone = this; // closure
        //为上传按钮添加点击事件
        submitButton.on("click", function () {
            myDropzone.options.url = addr;
            if (myDropzone.getAcceptedFiles().length != 0) {
                //手动指定
                console.log(addr);
                myDropzone.processQueue();
            }
        });

        this.on("success", function (file, res) {
            alert("上传成功");
            window.location.href=ContextPath+"/file/file_list.jsp";
        });
    }
})
function returnBack(){
    window.location.href=ContextPath+"/file/file_list.jsp";
};