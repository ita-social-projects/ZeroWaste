import { Controller } from "@hotwired/stimulus";
export default class extends Controller {
  connect() {
    const url = this.element.dataset.url;
    window.location.assign(url);
  }
}
