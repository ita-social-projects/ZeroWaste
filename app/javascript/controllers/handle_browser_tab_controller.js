import { Controller } from 'stimulus'

export default class extends Controller {
  connect() {
    this.input = this.element.querySelector("input#site_setting_title")
    this.title = this.element.querySelector(".tab-text")
    this.icon = this.element.querySelector('.tab-icon')

    this.input.addEventListener('input', this.setTitle.bind(this))

    const fileInput = this.element.querySelector("input#site_setting_favicon")
    fileInput.addEventListener('change', this.readURL.bind(this))
  }

    setTitle(event) {
      this.title.textContent = event.target.value
    }

    readURL(event) {
      if (event.target.files && event.target.files[0]) {
        const reader = new FileReader();

        reader.onload = function (e) {
          $('.tab-icon').attr('src', e.target.result)
        };

        reader.readAsDataURL(event.target.files[0]);
      }
    }
  }
