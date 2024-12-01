import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="constructors-form-indexing"
export default class extends Controller {
  static targets = ["index"];

  afterInsert(event) {
    const fieldsets = this.element.querySelectorAll(":scope > .nested-fields");
    const span = fieldsets[fieldsets.length - 1].querySelector("[data-constructors-form-indexing-target='index']")

    if (span) {
      span.textContent = `${fieldsets.length}`;
    }
  }

  afterRemove(event) {
    const fieldsets = this.element.querySelectorAll(":scope > .nested-fields");

    fieldsets.forEach((fieldset, index) => {
      const span = fieldset.querySelector("[data-constructors-form-indexing-target='index']");
      if (span) {
        span.textContent = `${index + 1}`;
      }
    });
  }
}
