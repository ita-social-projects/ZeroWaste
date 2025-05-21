import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["fieldTypeSelect", "categoryFields"]

  connect() {
    this.setupFieldTypeSelect();
  }

  setupFieldTypeSelect() {
    if (this.hasFieldTypeSelectTarget && this.hasCategoryFieldsTarget) {
      this.toggleCategoryFields();
      this.fieldTypeSelectTarget.addEventListener("change", () => this.toggleCategoryFields());
    }
  }

  toggleCategoryFields() {
    if (this.fieldTypeSelectTarget.value === "category") {
      this.categoryFieldsTarget.style.display = "block";
    } else {
      this.categoryFieldsTarget.style.display = "none";
    }
  }
}
