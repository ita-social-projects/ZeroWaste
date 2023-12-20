import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ['password', 'icon']

  toggle() {
    const TEXT_INPUT = 'text';
    const PASSWORD_INPUT = 'password';

    if (this.passwordTarget && this.passwordTarget.type === PASSWORD_INPUT) {
      this.passwordTarget.type = TEXT_INPUT;
      this.iconTarget.classList.replace('fa-eye-slash', 'fa-eye');
    } else if (this.passwordTarget) {
      this.passwordTarget.type = PASSWORD_INPUT;
      this.iconTarget.classList.replace('fa-eye', 'fa-eye-slash');
    }
  }
}
