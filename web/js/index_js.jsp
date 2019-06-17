<%--
  Created by IntelliJ IDEA.
  User: silenus
  Date: 2019/6/16
  Time: 20:24
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<script type="text/javascript">
    var Page = function(){

        var renderCard = function(){
            $('.card a:first-child').css('display', 'none');
            $('.card').css('cursor', 'pointer');
            $('.card').hover(
                    function(){
                        $(this).css('background-color', '#F6F6FF');
                    },
                    function () {
                        $(this).css('background-color', '#FFFFFF');
                    }
            );
            $('.card').has('a').click(
                    function() {
                        var href=$(this).find('a').first().attr('href');
                        window.location.href=href;
                    }
            );
        };

        return {
            init: function(){
                renderCard();
            }
        };

    }();
</script>