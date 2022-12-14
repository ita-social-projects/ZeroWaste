import { Controller } from "@hotwired/stimulus";
import { json } from "body-parser";

export default class extends Controller {
  static targets = ["month", "year", "productCategory"];
  static outlets = ["results"];

  yearChanged() {}

  submit(e) {
    event.preventDefault();

    this.years = parseInt(this.yearTarget.value);
    this.months = parseInt(this.monthTarget.value);

    this.formData = {
      childs_age: this.years * 12 + this.months,
      price_id: this.productCategoryTarget.selectedIndex,
    };

    this.request = new Request("/api/v1/diaper_calculators", {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
      },
      body: JSON.stringify(this.formData),
    });

    console.log(this.request);

    fetch(this.request)
      .then((response) => response.json())
      .then((data) => {
        this.resultsOutlet.showResults(data);
      });
  }
}
