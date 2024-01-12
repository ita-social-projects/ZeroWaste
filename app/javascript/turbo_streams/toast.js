import { showToast } from "helpers/toast_helper";

window.Turbo.StreamActions.toast = function() {
  const message = this.getAttribute("message")
  const background = this.getAttribute("background")

  showToast(message, background)
}
