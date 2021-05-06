$("#result_button").on('click', function() {
  const form = document.getElementById('form');

  form.addEventListener('submit', function(e) {

    e.preventDefault();
    
    const formData = {
      childs_birthday: $("#birth").val(),
      baby_weight: $("#weight").val()
    } 
    Rails.ajax({
      url: "./api/v1/calculators/:id/compute",
      type: "POST",
      data: formData,
      dataType: "json"
    })
  });
})