import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [
    "padsUsed",
    "padsToBeUsed",
    "moneySpent",
    "moneyWillBeSpent"
  ];

  showResults(data) {
    let result = data;

    this.moneySpentTarget.innerHTML = Math.ceil(result.already_used_products_cost);
    this.moneyWillBeSpentTarget.innerHTML = Math.ceil(result.products_to_be_used_cost);
    this.padsUsedTarget.innerHTML = Math.ceil(result.already_used_products);
    this.padsToBeUsedTarget.innerHTML = Math.ceil(result.products_to_be_used);

    this.element.scrollIntoView({ behavior: "smooth" });
  }
}
