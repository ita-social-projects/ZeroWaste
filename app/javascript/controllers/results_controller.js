import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = [
    "diapersUsed",
    "diapersToBeUsed",
    "moneySpent",
    "moneyWillBeSpent",
    "ToBeUsedDiapersAmount",
    "UsedDiapersAmount",
  ];

  showResults(data) {
    let result = data.result;

    this.moneySpentTarget.innerHTML = result.money_spent;
    this.moneyWillBeSpentTarget.innerHTML = result.money_will_be_spent;
    this.diapersUsedTarget.innerHTML = result.used_diapers_amount;
    this.diapersToBeUsedTarget.innerHTML = result.to_be_used_diapers_amount;

    this.UsedDiapersAmountTarget.innerHTML = data.text_products_used;
    this.ToBeUsedDiapersAmountTarget.innerHTML = data.text_products_to_be_used;
  }
}
