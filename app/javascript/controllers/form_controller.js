import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "price", "checkbox" ]
  connect() {
    this.priceTargets.forEach((el) => el.hidden = true)
  }

  togglePrice(event) {
    for (const target of this.priceTargets) {
      if (event.target.attributes.name.value == target.attributes.name.value) {
        target.hidden = !target.hidden
      }
    }
  }

  submit() {
    this.priceTargets.forEach((el) => {
      if (el.hidden) {
         el.remove()
      }
    })
    this.checkboxTargets.forEach((el) => el.remove())
  }
}
