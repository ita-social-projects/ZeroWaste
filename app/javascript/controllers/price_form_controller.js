import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["priceInput", "price", "checkbox", "hiddenField", "errorMessage"];

  connect() {
    for(let i = 0; i < this.checkboxTargets.length; i++) {
      if (!this.priceInputTargets[i].value) {
        this.checkboxTargets[i].checked = false
        this.priceTargets[i].hidden = true
      }
    }

    this.priceInputTargets.forEach(input => {
      input.addEventListener('input', this.validatePriceInput.bind(this));
    });
  }

  togglePrice(event) {
    this.priceTargets.forEach((target, i) => {
      if (event.target.attributes.name.value == target.attributes.name.value) {
        target.hidden = !target.hidden;

        if (target.hidden) {
          this.priceInputTargets[i].value = '';
        }
      }
    });
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

  validatePriceInput(event) {
    const target = event.target;
    const inputValue = target.value;
    const regex = /^[\d.]+$/;

    const errorMessage = target.closest('.hidden-sum').querySelector('.error-message');

    if (!regex.test(inputValue)) {
      errorMessage.style.display = "block";
      target.style.borderColor = "red";
    } else {
      errorMessage.style.display = "none";
      target.style.borderColor = "";
    }
  }
}
