/**
 * Created by silenus on 2019/6/16.
 */

var cnt = 0;
var TabView = function(){
    var renderFoldBtn = function(){
        $('#fold-btn').click(function() {
            if(cnt == 0){
                $('#tab-content').hide(100);
                $('#fold-icon').removeClass('fa fa-angle-up');
                $('#fold-icon').addClass('fa fa-angle-down');
            } else {
                $('#tab-content').show(100);
                $('#fold-icon').removeClass('fa fa-angle-down');
                $('#fold-icon').addClass('fa fa-angle-up');
            }
            cnt = (cnt + 1) % 2;
        });
    };

    return {
        init: function(){
            renderFoldBtn();
        }
    };
}();