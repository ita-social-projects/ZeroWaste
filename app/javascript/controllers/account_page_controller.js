import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="account-page"
export default class extends Controller {
  static targets = [ "changeLang", "navbarNav" ]

  toggleBurger(){
    const navbarVisible = () => this.navbarNavTarget.classList.contains("show")

    this.changeLangTarget.hidden = !navbarVisible()
  }
}
