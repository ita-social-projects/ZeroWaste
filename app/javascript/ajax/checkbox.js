jQuery(document).ready(function($){
  $("#checkbox_submit").bind('click',function(){
  $.ajax({
            type: "POST",
            url: "/receive_recomendations"
        });
  });
});
