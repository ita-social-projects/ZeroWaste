import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["navbarNav", "iconLines", "iconCross"];

  toggle() {
    this.navbarNavTarget.classList.toggle('hidden');
    this.iconLinesTarget.classList.toggle('hidden');
    this.iconCrossTarget.classList.toggle('hidden');
  }
}
