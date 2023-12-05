import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["loader_mask"];

  press_button(event) {
    const loaderMask = this.loader_maskTarget;
    loaderMask.style.opacity = 0.7;
    loaderMask.style.zIndex = 100;
  }
}
