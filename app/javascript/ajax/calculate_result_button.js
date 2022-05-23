$(document).on('turbolinks:load', function() {
  const form = document.getElementById('form');
  const childs_years = document.getElementById('childs_years');
  const childs_months = document.getElementById('childs_months');
  if (!form) {
    return
  }
  childs_years.addEventListener('click',() => {
    if(childs_years.value < 2) {
      childs_months.classList.remove('last-year');
    } else {
      childs_months.selectedIndex = 0;
      childs_months.classList.add('last-year');
    }
  });
  form.addEventListener('submit', function(e) {

    e.preventDefault();

    const formData = {
      childs_age: $("#childs_years").val() * 12 + (+$("#childs_months").val())
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
      }
    })
  });
})
