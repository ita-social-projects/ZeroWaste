$(document).on('turbolinks:load', () => {
  const input = $("input#site_setting_title")
  const title = $(".tab-text")

  input.on('input', function (e) {
    title.text($(e.target).val())
  })
})
