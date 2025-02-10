import { Controller } from "@hotwired/stimulus";
import { FetchRequest } from "@rails/request.js";

export default class extends Controller {
  static targets = ["userAge", "menstruationAge", "menopauseAge", "averageMenstruationCycleDuration", "durationOfMenstruation", "disposableProductsPerDay", "padCategory"];
  static outlets = ["pad-results"];
  static values = {
    url: {
      type: String,
      default: "en/api/v1/pad_calculators",
    }
  };

  submit(e) {
    e.preventDefault();

    let formData = {
      user_age: parseInt(this.userAgeTarget.value),
      menstruation_age: parseInt(this.menstruationAgeTarget.value),
      menopause_age: parseInt(this.menopauseAgeTarget.value),
      average_menstruation_cycle_duration: parseInt(this.averageMenstruationCycleDurationTarget.value),
      duration_of_menstruation: parseInt(this.durationOfMenstruationTarget.value),
      disposable_products_per_day: parseInt(this.disposableProductsPerDayTarget.value),
      pad_category: this.padCategoryTarget.value
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

    this.clearErrors()

    if (response.ok) {
      this.padResultsOutlet.showResults(result);
    } else if (response.statusCode == 422) {
      this.showErrors(result.errors);
    }
  }

  showErrors(errors) {
    Object.keys(errors).forEach(errorKey => {
      const targetKey = errorKey.replace(/_([a-z])/g, (match, letter) => letter.toUpperCase());
      const feedbackDiv = document.createElement('div');

      feedbackDiv.className = 'invalid-feedback';
      feedbackDiv.textContent = errors[errorKey];

      this[`${targetKey}Target`].classList.add("is-invalid");
      this[`${targetKey}Target`].insertAdjacentElement('afterend', feedbackDiv);
    });
  }

  clearErrors(){
    this.constructor.targets.forEach(targetKey => {
      const targetElement = this[`${targetKey}Target`];
      targetElement.classList.remove("is-invalid");

      const feedbackDiv = targetElement.nextElementSibling;
      if (feedbackDiv && feedbackDiv.classList.contains('invalid-feedback')) {
        feedbackDiv.remove();
      }
    });
  }
}
