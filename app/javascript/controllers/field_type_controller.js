import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["fieldTypeSelect", "categoryFields", "selectOptions", "periodicalCategory"]

  connect() {
    this.setupFieldTypeSelect();
  }

  setupFieldTypeSelect() {
    if (this.hasFieldTypeSelectTarget) {
      this.toggleFields();
      this.fieldTypeSelectTarget.addEventListener("change", () => this.toggleFields());
    }
  }

  toggleFields() {
    const selected = this.fieldTypeSelectTarget.value;

    if (this.hasCategoryFieldsTarget) {
      if (selected === "category") {
        this.categoryFieldsTarget.style.display = "block";
      } else {
        this.categoryFieldsTarget.style.display = "none";
      }
    }

    if (this.hasSelectOptionsTarget) {
      if (selected === "select_option") {
        this.selectOptionsTarget.style.display = "block";
      } else {
        this.selectOptionsTarget.style.display = "none";
      }
    }

    if (this.hasCategoryFieldsTarget) {
      if (selected === "periodical_category") {
        this.periodicalCategoryTarget.style.display = "block";
      } else {
        this.periodicalCategoryTarget.style.display = "none";
      }
    }
  }
}
