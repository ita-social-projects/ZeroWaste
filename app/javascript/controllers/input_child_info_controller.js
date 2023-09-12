import { Controller } from "@hotwired/stimulus";
import { FetchRequest } from "@rails/request.js";

export default class extends Controller {
  static targets = ["month", "year", "productCategory"];
  static outlets = ["results"];
  static values = {
    url: {
      type: String,
      default: "en/api/v1/diaper_calculators",
    },
    months: Array
  };

  connect() {
    //hide option '__' from user in year selector
    this.yearTarget[0].disabled = true;
    this.yearTarget[0].hidden = true;

    //hide option '__' from user in month selector
    this.monthTarget[0].disabled = true;
    this.monthTarget[0].hidden = true;
  }

  yearChanged(e) {
    // Determining the number of options for months
    const amountOptions = e.target.value.includes("2") ? this.monthsValue.slice(0, 7) : this.monthsValue;

    // Save the previous month value before updating
    const previousMonthValue = this.monthTarget.value;

    // Clear old options from the month selection list
    this.monthTarget.innerHTML = '';

    // Adding new options to the month selection list
    amountOptions.forEach((option) => {
      this.monthTarget.appendChild(this.getBasicOption(option));

      // If the previous month value is saved, set it as the selected value
      if (option == previousMonthValue) {
        this.monthTarget.value = previousMonthValue;
      }
    });
  }

  submit(e) {
    e.preventDefault();

    let formData = {
      childs_years: parseInt(this.yearTarget.value),
      childs_months: parseInt(this.monthTarget.value),
      price_id: this.productCategoryTarget.selectedIndex,
    };

    const request = new FetchRequest("POST", this.urlValue, {
      responseKind: "json",
      body: JSON.stringify(formData),
    });

    this.sendRequest(request);
  }

  async sendRequest(request) {
    const response = await request.perform();
    const result = await response.json;


    if (response.ok) {
      this.resultsOutlet.showResults(result);
    } else if (response.statusCode == 422) {
      toastr.error(result.error);
    }
  }

  getNillOption(previous_month_value) {
    let option = document.createElement("option");

    option.innerText = "__";
    option.disabled = true;
    option.hidden = true;
    option.value = "";
    if (previous_month_value == "") option.selected = true;

    return option;
  }

  getBasicOption(i) {
    let option = document.createElement("option");

    option.value = i;
    option.innerText = i;

    return option;
  }
}
