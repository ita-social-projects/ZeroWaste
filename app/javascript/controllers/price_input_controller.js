import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    let prices = document.querySelectorAll(".hidden-sum")
    // to select all inputs of checkbox types (class does not work)
    let checkboxes = Array.from(document.querySelectorAll('input')).filter((el) => el.type == 'checkbox')
    let submit = document.querySelector('#submit')

    // to delete prices which categories are not selected and the same with categories in params
    submit.addEventListener('click', (e) => {
      let filtered_prices = Array.from(prices).filter(function (price) {
        return price.style.display == 'none';
      })
      filtered_prices.forEach(el => {el.remove()})
      checkboxes.forEach(el => {el.remove()})
    })

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
      })
    }
  }
}
