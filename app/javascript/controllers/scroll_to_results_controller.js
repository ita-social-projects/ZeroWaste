import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["resultsContainer"]

  scrollTo(event) {
    const form = event.target.form || event.target.closest("form")
    if (!form) return

    const fields = form.querySelectorAll("input.calculator-field, select.calculator-field")
    let allFilled = true

    fields.forEach(field => {
      if (field.value.trim() === "") {
        allFilled = false
      }
    })

    if (allFilled && this.resultsContainerTarget) {
      this.resultsContainerTarget.scrollIntoView({ behavior: "smooth" });
    }
  }
}
