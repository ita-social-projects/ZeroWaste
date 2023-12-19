import { showToast } from "../helpers/toast-helper";

window.Turbo.StreamActions.toast = function() {
  const message = this.getAttribute("message")
  const background = this.getAttribute("background")

  showToast(message, background)
}
