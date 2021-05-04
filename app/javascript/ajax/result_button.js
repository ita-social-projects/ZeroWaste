$("#result_button").on('click', function() {
  Rails.ajax({
    url: "./api/v1/compute",
    type: "POST",
    data: "",
    dataType: "json"
  })
})