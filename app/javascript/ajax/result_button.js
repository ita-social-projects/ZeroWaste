$(document).on('turbolinks:load', function() {
  const form = document.getElementById('form');
  if (!form) {
    return
  }

  form.addEventListener('submit', function(e) {

    e.preventDefault();

    const formData = {
      childs_birthday: $("#birth").val()
    }
    $.ajax({
      url: "/api/v1/calculators/diapers-calculator/compute",
      type: "POST",
      data: formData,
      dataType: "json",
      success: function(data) {
                  

                  const boughtDiapers = data.result.find(function(post, index) {
                    if(post.name == 'bought_diapers')
                      return true;
                  });
                  const moneySpent = data.result.find(function(post, index) {
                    if(post.name == 'money_spent')
                      return true;
                  });  
                  const garbageCreated = data.result.find(function(post, index) {
                    if(post.name == 'garbage_created')
                      return true;
                  });  

        $('[data-type="bought_diapers"]').text(boughtDiapers.result);
        $('[data-type="money_spent"]').text(moneySpent.result);
        $('[data-type="garbage_created"]').text(garbageCreated.result);
      }
    })
  });
})
