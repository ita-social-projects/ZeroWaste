import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["iconLines", "iconCross"];

  toggle() {
    document.getElementById('navbarNav').classList.toggle('hidden');
    this.iconLinesTarget.classList.toggle('hidden');
    this.iconCrossTarget.classList.toggle('hidden');
  }
}
