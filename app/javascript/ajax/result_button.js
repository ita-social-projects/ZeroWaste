$(document).on('turbolinks:load', function() {
  const form = document.getElementById('form');

  form.addEventListener('submit', function(e) {

    e.preventDefault();
    
    const formData = {
      childs_birthday: $("#birth").val()
    } 
    $.ajax({
      url: "/api/v1/calculators/diapers-calculator/compute",
      type: "POST",
      data: formData,
      dataType: "json"
    })
  });
})