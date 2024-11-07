import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  connect() {
    const url = this.element.dataset.url;
    console.log("Redirecting to:", url);
    Turbo.visit(url);
  }
}
