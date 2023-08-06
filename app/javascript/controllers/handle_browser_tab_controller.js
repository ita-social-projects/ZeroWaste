import { Controller } from '@hotwired/stimulus'

export default class extends Controller {
  static targets = ["title", "icon", "faviconFile"]


  setTitle(event) {
    this.titleTarget.textContent = event.target.value
  }

  setIcon(event) {
    if (event.target.files && event.target.files[0]) {
      const reader = new FileReader();

      reader.onload = (e) => {
        this.iconTarget.setAttribute('src', e.target.result);
      };

      this.faviconFileTarget.textContent = event.target.files[0].name;
      reader.readAsDataURL(event.target.files[0]);
    }
  }
}
