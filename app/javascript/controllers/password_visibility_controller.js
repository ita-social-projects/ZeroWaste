import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ['password', 'icon']

  toggle() {
    const icon = this.iconTarget
    const passwordField = this.passwordTarget

    if (passwordField && passwordField.type === 'password') {
      passwordField.type = 'text';
      icon.classList.replace('fa-eye-slash', 'fa-eye');
    } else if (passwordField) {
      passwordField.type = 'password';
      icon.classList.replace('fa-eye', 'fa-eye-slash');
    }
  }
}
