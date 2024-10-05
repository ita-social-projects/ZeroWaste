import { Controller } from "@hotwired/stimulus";
import { FetchRequest } from "@rails/request.js";
import { toastUtils } from "helpers/toast_helper";

export default class extends Controller {
  static targets = ["period", "priceCategory"];
  static outlets = ["calculation-results"];
  static values = {
    url: {
      type: String,
      default: "en/api/v1/calculators",
    },
  };

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
      this.calculationResultsOutlet.showResults(result);
    } else if (response.statusCode == 422) {
      toastUtils.showToast(result.error, "error");
    }
  }
}
