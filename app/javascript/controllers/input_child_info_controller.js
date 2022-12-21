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
    this.yearTarget[0].disabled = true;
    this.yearTarget[0].hidden = true;

    this.monthTarget[0].disabled = true;
    this.monthTarget[0].hidden = true;
  }

  yearChanged(e) {
    let amount_options =  e.target.value == 2 ? 5 : 11;

    let previous_month_value = this.monthTarget.value;

    this.monthTarget.innerHTML = "";

    if (previous_month_value == "")
      this.monthTarget.appendChild(this.getNillOption(previous_month_value));

    for (let i = 0; i <= amount_options; i++) {
      this.monthTarget.appendChild(this.getBasicOption(i));

      if (i == previous_month_value && previous_month_value != "")
        this.monthTarget.value = i;
    }
  }

  submit(e) {
    e.preventDefault();

    if (!this.valid(e.params)) return;

    let years = parseInt(this.yearTarget.value);
    let months = parseInt(this.monthTarget.value);

    let formData = {
      childs_age: years * 12 + months,
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
    if (response.ok) {
      const result = await response.json;
      this.resultsOutlet.showResults(result);
    }
  }

  valid(params) {
    if (this.yearTarget.value == "" && this.monthTarget.value == "") {
      toastr.error(params.yearAndMonthErrorMsg);
      return false;
    }

    if (this.yearTarget.value == "") {
      toastr.error(params.yearErrorMsg);
      return false;
    }

    if (this.monthTarget.value == "") {
      toastr.error(params.monthErrorMsg);
      return false;
    }

    return true;
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