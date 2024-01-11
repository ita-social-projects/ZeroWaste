import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  change() {
    const selectedPriceId = this.element.value;
    const url = new URL(window.location);
    url.searchParams.set('price_id', selectedPriceId);
    window.location = url.href;
  }
}