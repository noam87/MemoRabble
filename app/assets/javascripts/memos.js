$(document).ajaxSuccess(function(e, content){
    console.log(content);
    
    $("#parent-memo").html(content.responseText).hide().fadeIn(1000);
});
