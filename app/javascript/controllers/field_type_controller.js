import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["fieldTypeSelect", "categoryFields", "selectOptions"];

  connect() {
    this.setupFieldTypeSelect();
  }

  setupFieldTypeSelect() {
    if (this.hasFieldTypeSelectTarget) {
      this.toggleCategoryFields();
      this.toggleSelectOptions();
      this.fieldTypeSelectTarget.addEventListener("change", () => {
        this.toggleCategoryFields();
        this.toggleSelectOptions();
      });
    }
  }

  toggleCategoryFields() {
    if (this.hasCategoryFieldsTarget) {
      this.categoryFieldsTarget.style.display =
        this.fieldTypeSelectTarget.value === "category" ? "block" : "none";
    }
  }

  toggleSelectOptions() {
    if (this.hasSelectOptionsTarget) {
      this.selectOptionsTarget.style.display =
        this.fieldTypeSelectTarget.value === "select_option" ? "block" : "none";
    }
  }
}
