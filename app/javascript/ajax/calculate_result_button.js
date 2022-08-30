$(document).on('turbolinks:load', function() {
  const form = document.getElementById('form');
  const childs_years = document.getElementById('childs_years');
  const childs_months = document.getElementById('childs_months');
  const two_years_childs_months = document.getElementById('two_years_childs_months');

  if (!form) {
    return
  }

  two_years_childs_months.classList.add('hidden')
  two_years_childs_months.required = false

  childs_years.addEventListener('input', () => {
    if (childs_years.value == 2) {
      childs_months.classList.add('hidden')
      childs_months.required = false

      two_years_childs_months.classList.remove('hidden')
      two_years_childs_months.required = true
    } else {
      two_years_childs_months.classList.add('hidden')
      two_years_childs_months.required = false

      childs_months.classList.remove('hidden')
      childs_months.required = true
    }
  });

  form.addEventListener('submit', function(e) {

    e.preventDefault();

    let months = 0;

    if (childs_years.value == 2) {
      months = (+$("#two_years_childs_months").val());
    } else {
      months = (+$("#childs_months").val())
    }

    const formData = {
      childs_age: $("#childs_years").val() * 12 + months
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
        $("#localized_parent").each(function (){$(this).children().last().text("")});
        $("#localized_uk_to_be_used_diapers_amount").text(data.word_form_to_be_used + " ви ще використаєте")
        $("#localized_uk_used_diapers_amount").text(data.word_form_used + " ви вже використали")
      }
    })
  });
})
