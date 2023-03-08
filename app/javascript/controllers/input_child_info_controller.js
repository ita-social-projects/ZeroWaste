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

    // Якщо значення року не пусте, то скидаємо значення місяця на null, інакше на порожнє рядок
    if (e.target.value !== "") {
      this.monthTarget.value = null;
    } else {
      this.monthTarget.value = "";
    }

    // Очистка старих опцій зі списку вибору місяця
    this.monthTarget.innerHTML = "";

    // Визначення кількості опцій для місяців
    const amount_options = e.target.value == 2 ? 6 : 11;

    // Збереження попереднього значення місяця перед оновленням
    const previous_month_value = this.monthTarget.value;

    // Якщо місяць не було вибрано до оновлення, додаємо порожню опцію на початок списку
    if (this.monthTarget && !previous_month_value) {
      this.monthTarget.appendChild(this.getNillOption(previous_month_value));
    }

    // Додавання нових опцій до списку вибору місяця
    for (let i = 0; i <= amount_options; i++) {
      this.monthTarget.appendChild(this.getBasicOption(i));

      // Якщо попереднє значення місяця збережене, встановлюємо його як вибране значення
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
