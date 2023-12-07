import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ['password', 'icon']

  toggle() {
    const icon = this.iconTarget
    const passwordField = this.passwordTarget

    const TEXT_INPUT = 'text';
    const PASSWORD_INPUT = 'password';

    if (passwordField && passwordField.type === PASSWORD_INPUT) {
      passwordField.type = TEXT_INPUT;
      icon.classList.replace('fa-eye-slash', 'fa-eye');
    } else if (passwordField) {
      passwordField.type = PASSWORD_INPUT;
      icon.classList.replace('fa-eye', 'fa-eye-slash');
    }
  }
}
