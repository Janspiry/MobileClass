var ContextPath=$("#ContextPath").val();
var module="/QuestionnaireAnswer";
var url=ContextPath+module;
var count=0;//问题数量
var html="";
function getRecord(){
    var id=$("#id").val();
    var addr=url+"?action=get_record&id="+id+"&type=answer";
    $.post(addr,function(json){
        console.log(json)
        showRecordList(json);
    })
};
function showRecordList(list){
    if(list.length>0){
        var tip="本问卷共 "+list.length+" 个问题";
        count=list.length;
        $("#tip_div").html(tip);
    }
    html="";
    for(var i=0;i<list.length;i++){
        showRecord(list[i]);
    }
    $("#record_list_div").html(html);
};
function showRecord(json){
    var id=json["id"];
    var title=json["title"];
    var problem=json["problem"];
    var answer=json["answer"];
    var problem_id=json["problem_id"];
    var problemurl="problem"+problem_id;
    var answerurl="answer"+problem_id;
    html=html+
        "<div class=\"form-group\">"+
            "<p class=\"text-muted m-b-15 f-s-12\">"+
                "<code>问题"+problem_id+"</code>"+
            "</p>"+
            "<input name="+problemurl+" value='"+problem+"'"+
            " class=\"form-control input-rounded\" readonly=\"true\">"+
        "</div>"

    html=html+
        "<div class=\"form-group\">"+
            "<p class=\"text-muted m-b-15 f-s-12\">"+
                "回答"+
            "</p>"+
            "<input name="+answerurl+" value='"+answer+"'"+
            " class=\"form-control input-focus\" placeholder=\"输入答案\">"+
        "</div>"
};

function submitRecord(){
    var id=$("#id").val();
    var addr=url+"?action=modify_record&id="+id+"&count="+count;
    page_form.action=addr;
    page_form.submit();
};

function returnBack(){
    window.history.back();
}

getRecord();
