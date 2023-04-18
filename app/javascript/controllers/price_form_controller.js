import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "price", "checkbox", "hiddenField"]

  connect() {
    for(let i = 0; i < this.checkboxTargets.length; i++) {
      if (!this.priceInputValue(this.priceTargets[i])) {
        this.checkboxTargets[i].checked = false
        this.priceTargets[i].hidden = true
      }
    }
  }

  priceInputValue(price) {
    return price.querySelector('input').value
  }

  togglePrice(event) {
    this.priceTargets.forEach((target) => {
      if (event.target.attributes.name.value == target.attributes.name.value) {
        target.hidden = !target.hidden
      }
    })
  }

  removePrice(event) {
    this.priceTargets.forEach((target) => {
      if (event.target.attributes.name.value == target.attributes.name.value) {
        target.querySelector('input').value = ''
      }
    })
  }

  submit() {
    for(let i = 0; i < this.checkboxTargets.length; i++) {
      this.hiddenFieldTargets[i].value = !this.checkboxTargets[i].checked
    }
  }
}
