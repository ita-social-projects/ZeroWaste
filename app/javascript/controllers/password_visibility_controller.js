import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ['password', 'icon']

  toggle() {
    const TEXT_INPUT_TYPE = 'text';
    const PASSWORD_INPUT_TYPE = 'password';

    if (this.passwordTarget && this.passwordTarget.type === PASSWORD_INPUT_TYPE) {
      this.passwordTarget.type = TEXT_INPUT_TYPE;
      this.iconTarget.classList.replace('fa-eye-slash', 'fa-eye');
    } else if (this.passwordTarget) {
      this.passwordTarget.type = PASSWORD_INPUT_TYPE;
      this.iconTarget.classList.replace('fa-eye', 'fa-eye-slash');
    }
  }
}
