import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = [
    "diapersUsed",
    "diapersToBeUsed",
    "moneySpent",
    "moneyWillBeSpent",
  ];

  showResults(data) {
    console.log(data.result);
    this.results = data.result;

    this.moneySpentTarget.innerHTML = this.results[0].result;
    this.moneyWillBeSpentTarget.innerHTML = this.results[1].result;
    this.diapersUsedTarget.innerHTML = this.results[2].result;
    this.diapersToBeUsedTarget.innerHTML = this.results[3].result;
  }
}
