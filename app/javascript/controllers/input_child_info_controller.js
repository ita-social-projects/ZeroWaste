import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["month", "year", "productCategory", "token"];
  static outlets = ["results"];
  static values = {
    locale: {
      type: String,
      default: "en",
    },
  };

  yearChanged() {}

  submit(e) {
    e.preventDefault();

    this.years = parseInt(this.yearTarget.value);
    this.months = parseInt(this.monthTarget.value);

    this.formData = {
      childs_age: this.years * 12 + this.months,
      price_id: this.productCategoryTarget.selectedIndex,
      authenticity_token: this.tokenTarget.value,
      locale: this.localeValue,
    };

    this.request = new Request(`/api/v1/diaper_calculators`, {
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
