import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["month", "year", "productCategory", "token"];
  static outlets = ["results"];
  static values = {
    locale: {
      type: String,
      default: "en",
    },
    url: {
      type: String,
      default: "/api/v1/diaper_calculators",
    },
  };

  connect() {
    this.yearTarget[0].disabled = true;
    this.yearTarget[0].hidden = true;

    this.monthTarget[0].disabled = true;
    this.monthTarget[0].hidden = true;
  }

  yearChanged(e) {
    let amount_options;
    if (e.target.value == 2) {
      amount_options = 5;
    } else {
      amount_options = 11;
    }

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
      authenticity_token: this.tokenTarget.value,
      locale: this.localeValue,
    };

    let request = new Request(this.urlValue, {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
      },
      body: JSON.stringify(formData),
    });

    fetch(request)
      .then((response) => response.json())
      .then((data) => {
        this.resultsOutlet.showResults(data);
      });
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
