jQuery(document).ready(function($){
  $("#button_submit").on('click', function(){
    if($("#checkbox_submit").prop('checked')){
      $.ajax({
        type: "POST",
        url: "/receive_recomendations"
      })
    }
  })
});
