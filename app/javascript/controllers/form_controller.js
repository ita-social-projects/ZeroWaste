import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "price", "checkbox" ]
  connect() {
    if (!this.checkboxTarget.checked) {
      this.priceTargets.forEach((el) => el.hidden = true)
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
    this.priceTargets,forEach((target) => {
      if (event.target.attributes.name.value == target.attributes.name.value) {
        target.querySelector('input').value = ''
      }
    })
  }

  submit() {
    this.priceTargets.forEach((el) => {
      if (el.hidden || el.querySelector('input').value == '') {
         el.remove()
      }
    })
    this.checkboxTargets.forEach((el) => el.remove())
  }
}
