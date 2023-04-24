import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "priceInput", "price", "checkbox", "hiddenField" ]

  connect() {
    for(let i = 0; i < this.checkboxTargets.length; i++) {
      if (!this.priceInputTargets[i].value) {
        this.checkboxTargets[i].checked = false
        this.priceTargets[i].hidden = true
      }
    }
  }

  togglePrice(event) {
    this.priceTargets.forEach((target) => {
      if (event.target.attributes.name.value == target.attributes.name.value) {
        target.hidden = !target.hidden
      }
    })
  }

  removePrice(event) {
    for (let i = 0; i < this.priceTargets.length; i++) {
      if (event.target.attributes.name.value == this.priceTargets[i].attributes.name.value) {
        this.priceInputTargets[i].value = ''
      }
    }
  }

  submit() {
    for(let i = 0; i < this.checkboxTargets.length; i++) {
      this.hiddenFieldTargets[i].value = !this.checkboxTargets[i].checked
    }
  }
}
