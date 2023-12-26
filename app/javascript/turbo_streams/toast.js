import { showToast } from "helpers/toast_helper";

window.Turbo.StreamActions.toast = function() {
  const message = this.getAttribute("message")
  const messageType = this.getAttribute("background")

  showToast(message, messageType)
}
