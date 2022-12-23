document.addEventListener('turbolinks:load', () => {
  const input = document.querySelector('input#site_setting_title');
  const title = document.querySelector('.tab-text');

  input.addEventListener('input', function (e) {
    title.textContent = e.target.value;
  })
})
