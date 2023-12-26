import Toastify from "toastify-js";

function getColorByMessageType(messageType) {
  switch (messageType) {
    case "error":
      return "#DC3545";
    case "notice":
      return "#8FBA3B";
    case "alert":
        return "#FF6A00";
    default:
      return "#DC3545";
  }
}

export function showToast(message, messageType) {
  const backgroundColor = getColorByMessageType(messageType);

  Toastify({
    text: message,
    duration: 20000,
    destination: "",
    close: true,
    gravity: "top",
    position: "right",
    stopOnFocus: true,
    style: {
      background: backgroundColor,
    }
  }).showToast()
}
