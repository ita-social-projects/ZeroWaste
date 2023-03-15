import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    let prices = document.querySelectorAll(".hidden-sum")
    let checkboxes = document.querySelectorAll('#checkbox-cat')

    prices.forEach((price) => price.style.display = 'none')

    const checkboxesPrices = []
    for(let i = 0; i < prices.length; i++){
      checkboxesPrices.push({
        checkbox: checkboxes[i],
        price: prices[i]
      })
    }

    for (const el of checkboxesPrices) {
      el.checkbox.addEventListener("click", (event) => {
        el.price.style.display = el.checkbox.checked ? 'block' : 'none'
        el.price.querySelector('input').value = ''
      })
    }
  }
}
