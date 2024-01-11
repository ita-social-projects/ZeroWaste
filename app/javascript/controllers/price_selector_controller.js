import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  connect() {
    console.log("PriceSelectorController is ready");
  }

  change() {
    console.log("Selected value: ", this.element.value);
  }
}