import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = [
    "diapersUsed",
    "diapersToBeUsed",
    "moneySpent",
    "moneyWillBeSpent",
  ];

  showResults(data) {
    this.moneySpentTarget.innerHTML = data.result.money_spent;
    this.moneyWillBeSpentTarget.innerHTML = data.result.money_will_be_spent;
    this.diapersUsedTarget.innerHTML = data.result.used_diapers_amount;
    this.diapersToBeUsedTarget.innerHTML =
      data.result.to_be_used_diapers_amount;
  }
}
