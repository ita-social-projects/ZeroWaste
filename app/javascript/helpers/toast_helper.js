import Toastify from "toastify-js";

function getColorBackground(background) {
  switch (background) {
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

function showToast(message, background) {
  const backgroundColor = getColorBackground(background);

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

export const toastUtils = {
  showToast,
};
