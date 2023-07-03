import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = [
    "diapersUsed",
    "diapersToBeUsed",
    "moneySpent",
    "moneyWillBeSpent",
    "toBeUsedDiapersAmount",
    "usedDiapersAmount",
  ];

  showResults(data) {
    let result = data.result;

    this.moneySpentTarget.innerHTML = result.money_spent;
    this.moneyWillBeSpentTarget.innerHTML = result.money_will_be_spent;
    this.diapersUsedTarget.innerHTML = Math.round(result.used_diapers_amount);
    this.diapersToBeUsedTarget.innerHTML = Math.round(result.to_be_used_diapers_amount);

    this.usedDiapersAmountTarget.innerHTML = data.text_products_used;
    this.toBeUsedDiapersAmountTarget.innerHTML = data.text_products_to_be_used;

    console.log(result.money_spent)
    console.log(result.money_will_be_spent)
    console.log(result.used_diapers_amount)
    console.log(result.to_be_used_diapers_amount)
    console.log(data.text_products_used)
    console.log(data.text_products_to_be_used)
  }
}
