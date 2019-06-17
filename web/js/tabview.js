/**
 * Created by silenus on 2019/6/16.
 */

var isVisible = false;
var TabView = function(){

    var showTabView = function(){
        $('#tab-content').show(100);
        $('#fold-icon').removeClass('fa fa-angle-down');
        $('#fold-icon').addClass('fa fa-angle-up');
        isVisible=true;
    }

    var hideTabView = function(){
        $('#tab-content').hide(100);
        $('#fold-icon').removeClass('fa fa-angle-up');
        $('#fold-icon').addClass('fa fa-angle-down');
        //$('.nav-link').removeClass('active');
        isVisible=false;
    }

    var renderFoldBtn = function(){
        $('#fold-btn').click(function() {
            if(isVisible){
                hideTabView();
            } else {
                showTabView();
            }
        });
        $('.nav-item').not('.dropdown').click(function(){
            if(!isVisible){
                showTabView();
            }
        });
    };

    return {
        init: function(){
            renderFoldBtn();
        }
    };
}();