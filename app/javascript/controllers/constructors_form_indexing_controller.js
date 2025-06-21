import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="constructors-form-indexing"
export default class extends Controller {
  static targets = ["index"];

  connect() {
    this.updateIndexes();
  }

  afterInsert(event) {
    this.updateIndexes();
  }

  afterRemove(event) {
    this.updateIndexes();
  }

  updateIndexes() {
    const fieldsets = this.element.querySelectorAll(":scope > .nested-fields");

    fieldsets.forEach((fieldset, index) => {
      const span = fieldset.querySelector("[data-constructors-form-indexing-target='index']");
      if (span) {
        span.textContent = `${index + 1}`;
      }
    });
  }
}
