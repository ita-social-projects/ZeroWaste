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

    // Clear old options from the month selection list
    this.monthTarget.innerHTML = '';

    // Determining the number of options for months
    const amountOptions = e.target.value == 2 ? 6 : 11;

    // Save the previous month value before updating
    const previousMonthValue = this.monthTarget.value;

    // If the month was not selected before the update, add an empty option to the top of the list
    if (this.monthTarget && !previousMonthValue) {
      this.monthTarget.appendChild(this.getNillOption(previousMonthValue));
    }

    // Adding new options to the month selection list
    for (let monthIndex = 0; monthIndex <= amountOptions; monthIndex++) {
      this.monthTarget.appendChild(this.getBasicOption(monthIndex));

      // If the previous month value is saved, set it as the selected value
      if (monthIndex == previousMonthValue && previousMonthValue) {
        this.monthTarget.value = monthIndex;
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
