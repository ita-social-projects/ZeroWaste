import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    let prices = document.querySelectorAll(".hidden-sum")
    let checkboxes = Array.from(document.querySelectorAll('input')).filter((el) => el.type == 'checkbox')
    let submit = document.querySelector('#submit')

    submit.addEventListener('click', (e) => {
      //debugger
      let filtered_prices = Array.from(prices).filter(function (price) {
        return price.style.display == 'none';
      })
      filtered_prices.forEach(el => {el.remove()})
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
      //debugger
      el.checkbox.addEventListener("click", (event) => {
        el.price.style.display = el.checkbox.checked ? 'block' : 'none'
      })
    }
  }
}
