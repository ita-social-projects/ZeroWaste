import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = [
    "diapersUsed",
    "diapersToBeUsed",
    "moneySpent",
    "moneyWillBeSpent",
  ];

  showResults(data) {
    let result = data.result;

    this.moneySpentTarget.innerHTML = Math.ceil(result.money_spent);
    this.moneyWillBeSpentTarget.innerHTML = Math.ceil(result.money_will_be_spent);
    this.diapersUsedTarget.innerHTML = Math.ceil(result.used_diapers_amount);
    this.diapersToBeUsedTarget.innerHTML = Math.ceil(result.to_be_used_diapers_amount);
  }
}
