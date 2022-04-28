$(document).on('turbolinks:load', function() {
  const form = document.getElementById('form');
  if (!form) {
    return
  }

  form.addEventListener('submit', function(e) {

    e.preventDefault();

    const formData = {
      childs_birthday: $("#date").val()
    }
    $.ajax({
      url: "/api/v1/diaper_calculators",
      type: "POST",
      data: formData,
      dataType: "json",
      success: function(data) {
        console.log(data)
        for (var i = data.result.length - 1; i >= 0; i--) {
          const oneItemFromArray = data.result[i]
          $('[data-type="' + oneItemFromArray.name + '"]').text(oneItemFromArray.result);
        }
        $('.date-of-birth').text(data.date);
      }
    })
  });
})
