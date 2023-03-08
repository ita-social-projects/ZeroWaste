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

    // If the year value is not empty, then reset the month value to null, otherwise to an empty string
    if (e.target.value !== "") {
      this.monthTarget.value = null;
    } else {
      this.monthTarget.value = "";
    }

    // Clear old options from the month selection list
    this.monthTarget.innerHTML = "";

    // Determining the number of options for months
    const amount_options = e.target.value == 2 ? 6 : 11;

    // Save the previous month value before updating
    const previous_month_value = this.monthTarget.value;

    // If the month was not selected before the update, add an empty option to the top of the list
    if (this.monthTarget && !previous_month_value) {
      this.monthTarget.appendChild(this.getNillOption(previous_month_value));
    }

    // Adding new options to the month selection list
    for (let i = 0; i <= amount_options; i++) {
      this.monthTarget.appendChild(this.getBasicOption(i));

      // If the previous month value is saved, set it as the selected value
      if (i == previous_month_value && previous_month_value) {
        this.monthTarget.value = i;
      }
    }
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
