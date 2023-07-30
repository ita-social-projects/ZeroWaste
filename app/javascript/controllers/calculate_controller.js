import { Controller } from "@hotwired/stimulus";
import { FetchRequest } from "@rails/request.js";

export default class extends Controller {
  static targets = ["period", "priceCategory"];
  static outlets = ["calculationresults"];
  static values = {
    url: {
      type: String,
      default: "en/api/v1/diaper_calculators",
    },
  };

  connect() {}

  submit(e) {
    e.preventDefault();

    let formData = {
      period: this.periodTarget.value,
      price_id: this.priceCategoryTarget.value
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
      console.log("RESULTS")
      console.log(result)
      console.log("RESULTS")
      this.calculationresultsOutlet.showResults(result);
    } else if (response.statusCode == 422) {
      toastr.error(result.error);
    }
  }

  getBasicOption(i) {
    let option = document.createElement("option");

    option.value = i;
    option.innerText = i;

    return option;
  }
}
