import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["fieldTypeSelect", "categoryFields", "selectOptions", "hiddenFields"];

  connect() {
    this.setupFieldTypeSelect();
  }

  setupFieldTypeSelect() {
    if (this.hasFieldTypeSelectTarget) {
      this.toggleCategoryFields();
      this.toggleSelectOptions();
      this.toggleHiddenFields();
      this.fieldTypeSelectTarget.addEventListener("change", () => {
        this.toggleCategoryFields();
        this.toggleSelectOptions();
        this.toggleHiddenFields();
      });
    }
  }

  toggleCategoryFields() {
    if (this.hasCategoryFieldsTarget) {
      this.categoryFieldsTarget.style.display = this.fieldTypeSelectTarget.value === "category" ? "block" : "none";
    }
  }

  toggleSelectOptions() {
    if (this.hasSelectOptionsTarget) {
      this.selectOptionsTarget.style.display = this.fieldTypeSelectTarget.value === "select_option" ? "block" : "none";
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
