import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["loaderMask"];

  connect() {
    this.createLoaderMask();
  }

  createLoaderMask() {
    const maskDiv = document.createElement('div');
    maskDiv.classList.add('mask');

    maskDiv.setAttribute('data-loader-target', 'loaderMask');

    const loaderDiv = document.createElement('div');
    loaderDiv.classList.add('loader');

    maskDiv.appendChild(loaderDiv);
    this.element.appendChild(maskDiv);
  }


  show_loader(event) {
    const loaderMask = this.loaderMaskTarget;
    loaderMask.style.opacity = 0.7;
    loaderMask.style.zIndex = 100;
  }
}

