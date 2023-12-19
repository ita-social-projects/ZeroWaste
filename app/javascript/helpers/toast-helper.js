import Toastify from "toastify-js";

export function showToast(message, background) {
  Toastify({
    text: message,
    duration: 20000,
    destination: "",
    close: true,
    gravity: "top",
    position: "right",
    stopOnFocus: true,
    style: {
      background: background == "notice" ? "#8FBA3B" : "#DC3545",
    }
  }).showToast()
}
