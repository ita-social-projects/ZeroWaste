jQuery(document).ready(function($){
  $(".calculate-btn").on('click', function(){
    if($("#checkbox_submit").prop('checked')){
      $.ajax({
        type: "POST",
        url: "/receive_recomendations"
      })
    }
  })
});
