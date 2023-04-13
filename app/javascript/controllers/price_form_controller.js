import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "price", "checkbox", "hiddenField"]

  connect() {
    for (const obj of this.checkboxesPrices) {
      let [checkbox, price] = Object.values(obj)
      if (!this.valueOfInput(price)) {
        checkbox.checked = false
      }
    }

    if (!this.checkbox.checked) {
      this.prices.forEach((el) => el.hidden = true)
    }
  }

  get prices() {
    return this.priceTargets
  }

  valueOfInput(price) {
    return price.querySelector('input').value
  }

  get checkboxesPrices() {
    const checkboxes = this.checkboxes
    const prices = this.prices

    const checkboxesPrices = []

    checkboxes.forEach((checkbox, index) => {
      checkboxesPrices.push({checkbox: checkbox, price: prices[index]})
    })

    return checkboxesPrices
  }

  get checkboxes() {
    return this.checkboxTargets
  }

  get checkbox() {
    return this.checkboxTarget
  }

  get hiddenFields() {
    return this.hiddenFieldTargets
  }

  togglePrice(event) {
    this.prices.forEach((target) => {
      if (event.target.attributes.name.value == target.attributes.name.value) {
        target.hidden = !target.hidden
      }
    })
  }

  removePrice(event) {
    this.prices.forEach((target) => {
      if (event.target.attributes.name.value == target.attributes.name.value) {
        target.querySelector('input').value = ''
      }
    })
  }

  submit() {
    for(let i = 0; i < this.checkboxes.length; i++) {
      this.hiddenFields[i].value = !this.checkboxes[i].checked
    }
  }
}
