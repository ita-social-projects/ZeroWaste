import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = [
    "moneySpentResult",
    "itemsUsedResult",
  ];

  showResults(data) {
    console.log(data)

    console.log(data.moneySpent)
    console.log(data.itemsUsed)

    this.moneySpentResultTarget.innerHTML = data.moneySpent;
    this.itemsUsedResultTarget.innerHTML = data.itemsUsed;
  }
}
