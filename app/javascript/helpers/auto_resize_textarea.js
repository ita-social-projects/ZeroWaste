document.addEventListener("DOMContentLoaded", function () {
  const textareas = document.querySelectorAll('.resize-auto');

  textareas.forEach(textarea => {
    textarea.addEventListener('input', function () {
      this.style.overflow = 'hidden';
      this.style.resize = 'none';
      this.style.height = 'auto'; // Reset height to auto
      this.style.height = (this.scrollHeight) + 'px'; // Set height based on scrollHeight
    });
  });
});
