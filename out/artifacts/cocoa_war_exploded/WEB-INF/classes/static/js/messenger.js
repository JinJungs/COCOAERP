$(document).ready(function(){
    $('#action_menu_btn').click(function(e){
        e.stopPropagation();
        $('.action_menu').toggle();
    });
        });

$(document).click(function(){
    $('.action_menu').hide();
});

