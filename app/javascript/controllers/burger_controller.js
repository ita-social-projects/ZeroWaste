import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["icon"];

  burgerPath = "M0 3h20v2H0V3zm0 6h20v2H0V9zm0 6h20v2H0v-2z";
  crossPath = "M3 3L21 21M3 21L21 3";

  connect() {
    this.iconTarget.setAttribute('d', this.burgerPath);
  }

  toggle() {
    const currentPath = this.iconTarget.getAttribute('d');

    this.iconTarget.setAttribute('d', currentPath === this.burgerPath ? this.crossPath : this.burgerPath);
    document.getElementById('navbarNav').classList.toggle('hidden');
  }
  
}
