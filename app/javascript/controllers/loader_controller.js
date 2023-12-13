import { Controller } from "@hotwired/stimulus";

export default class extends Controller {

  connect() {
    this.createLoaderMask();
  }

  createLoaderMask() {
    const maskDiv = document.createElement('div');
    maskDiv.classList.add('mask');

    maskDiv.setAttribute('data-loader-target', 'loader_mask');

    const loaderDiv = document.createElement('div');
    loaderDiv.classList.add('loader');

    maskDiv.appendChild(loaderDiv);
    this.element.appendChild(maskDiv);
  }

  static targets = ["loader_mask"];

  show_loader(event) {
    const loaderMask = this.loader_maskTarget;
    loaderMask.style.opacity = 0.7;
    loaderMask.style.zIndex = 100;
  }
}

