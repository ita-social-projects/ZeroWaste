import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["textarea"];

  connect() {
    this.resize(this.element);
  }

  resize(textarea) {
    textarea.style.overflow = "hidden";
    textarea.style.resize = "none";
    textarea.style.height = "auto";
    textarea.style.height = `${textarea.scrollHeight}px`; // Adjust height based on scrollHeight
  }

  input(event) {
    this.resize(event.target);
  }
}
