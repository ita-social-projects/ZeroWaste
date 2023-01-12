$(document).on('turbolinks:load', () => {
  function readURL(input) {
    if (input.target.files && input.target.files[0]) {
      var reader = new FileReader();

      reader.onload = function (e) {
        $('.tab-icon').attr('src', e.target.result)
      };

      reader.readAsDataURL(input.target.files[0]);
    }
  }

  const input = $("input#site_setting_title")
  const title = $(".tab-text")

  input.on('input', function (e) {
    title.text($(e.target).val())
  })

  input.on('change', readURL)
})
