import { Controller } from '@hotwired/stimulus'

export default class extends Controller {
  connect() {
    this.input = this.element.querySelector("input#site_setting_title")
    this.title = this.element.querySelector(".tab-text")
    this.icon = this.element.querySelector('.tab-icon')

    this.input.addEventListener('input', (event) => {
      this.setTitle(event);
    });

    const fileInput = this.element.querySelector("input#site_setting_favicon")
    fileInput.addEventListener('change', this.readURL.bind(this))
  }

  setTitle(event) {
    this.title.textContent = event.target.value
  }

  readURL(event) {
    if (event.target.files && event.target.files[0]) {
      const reader = new FileReader();
      const icon = this.element.querySelector('.tab-icon');

      reader.onload = function (e) {
      icon.setAttribute('src', e.target.result);
    };

    reader.readAsDataURL(event.target.files[0]);
    }
  }
}
