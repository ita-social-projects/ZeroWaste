import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["input", "clearButton"]

  clear() {
    this.inputTarget.value = ""    
    this.clearButtonTarget.classList.add("invisible")
  }

  input() {
    this.clearButtonTarget.classList.remove("invisible")
  }
}
