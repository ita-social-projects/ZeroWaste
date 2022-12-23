function readURL(input) {
  if (input.target.files && input.target.files[0]) {
    var reader = new FileReader();

    reader.onload = function (e) {
      $('.tab-icon').attr('src', e.target.result)
    };

    reader.readAsDataURL(input.target.files[0]);
  }
}

$(document).on('turbolinks:load', () => {
  $("#site_setting_favicon").on('change', readURL)
})
