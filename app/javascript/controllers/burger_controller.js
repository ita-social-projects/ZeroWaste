import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["icon"];

  toggle() {
    document.getElementById('navbarNav').classList.toggle('hidden');
  }
}
