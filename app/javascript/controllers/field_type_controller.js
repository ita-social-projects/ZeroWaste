import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["fieldTypeSelect", "categoryFields", "hiddenFields"];

  connect() {
    this.setupFieldTypeSelect();
  }

  setupFieldTypeSelect() {
    if (this.hasFieldTypeSelectTarget && this.hasCategoryFieldsTarget) {
      this.toggleCategoryFields();
      this.toggleHiddenFields();
      this.fieldTypeSelectTarget.addEventListener("change", () => {
        this.toggleCategoryFields();
        this.toggleHiddenFields();
      });
    }
  }

  toggleCategoryFields() {
    if (this.fieldTypeSelectTarget.value === "category") {
      this.categoryFieldsTarget.style.display = "block";
    } else {
      this.categoryFieldsTarget.style.display = "none";
    }
  }

  toggleHiddenFields() {
    if (this.hasHiddenFieldsTarget) {
      if (this.fieldTypeSelectTarget.value === "hidden") {
        this.hiddenFieldsTarget.style.display = "block";
      } else {
        this.hiddenFieldsTarget.style.display = "none";
      }
    }
  }
}
