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
            "<div class=\"alert alert-danger \">"+
                "["+problem_id+"]"+" "+problem+
            "</div>"+

        "</div>"

    html=html+
        "<div class=\"form-group\">"+
            "<div class=\"alert alert-info  \">"+
                 answer+
            "</div>"+
        "</div>"
};
function returnBack(){
    window.history.back();
}

getRecord();
