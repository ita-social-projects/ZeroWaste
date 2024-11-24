document.addEventListener('input', function (event) {
  if (event.target && event.target.classList.contains('resize-auto') && event.target.tagName === 'TEXTAREA') {
    const textarea = event.target;
    textarea.style.overflow = 'hidden';
    textarea.style.resize = 'none';
    textarea.style.height = 'auto';
    textarea.style.height = (textarea.scrollHeight) + 'px';
  }
});
