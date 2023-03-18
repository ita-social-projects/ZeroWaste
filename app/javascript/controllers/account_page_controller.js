import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="account-page"
export default class extends Controller {
  static targets = [ "changeLang", "navbarNav" ]

  toggleBurger(){
    const navbarVisible = () => Array.from(this.navbarNavTarget.classList).includes("show")

    this.changeLangTarget.hidden = (navbarVisible()) ? false : true
  }
}
