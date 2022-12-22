function readURL(input) {
  if (input.target.files && input.target.files[0]) {
    var reader = new FileReader();

    reader.onload = function (e) {
      $('#img_prev')
        .attr('src', e.target.result)
        .width(200)
        .height(200)
        .removeClass('d-none');
    };

    reader.readAsDataURL(input.target.files[0]);
  }
}

$(document).on('turbolinks:load', () => {
  $("#site_setting_favicon").on('change', readURL)
})
