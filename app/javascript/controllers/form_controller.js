import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "price", "checkbox" ]
  connect() {
    let prices = this.priceTargets
    prices.forEach((el) => el.hidden = true)
  }

  togglePrice(event) {
    let prices = this.priceTargets
    for (const target of prices) {
      if (event.target.attributes.name.value == target.attributes.name.value) {
        target.hidden = !target.hidden
      }
    }
  }

  submit() {
    let prices = this.priceTargets
    let checkboxes = this.checkboxTargets
    prices.forEach((el) => {
      if (el.hidden) {
         el.remove()
      }
    })
    checkboxes.forEach((el) => el.remove())
  }
}
