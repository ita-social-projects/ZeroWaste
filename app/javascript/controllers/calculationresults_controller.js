import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = [
    "moneySpentResult",
    "itemsUsedResult",
  ];

  showResults(data) {
    this.moneySpentResultTarget.innerHTML = data.moneySpent;
    this.itemsUsedResultTarget.innerHTML = data.itemsUsed;
  }
}
