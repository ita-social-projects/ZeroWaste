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

  yearChanged(e) {
    if (e.target.value == 2) {
      this.amount_options = 5;
    } else {
      this.amount_options = 11;
    }

    this.previous_month_value = this.monthTarget.value;

    this.monthTarget.innerHTML = "";

    this.option = document.createElement("option");
    this.option.innerText = "__";
    this.monthTarget.appendChild(this.option);
    for (let i = 0; i <= this.amount_options; i++) {
      this.option = document.createElement("option");
      this.option.value = i;
      this.option.innerText = i;
      this.monthTarget.appendChild(this.option);

      if (i == this.previous_month_value && this.previous_month_value != "")
        this.monthTarget.value = i;
    }
  }

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
