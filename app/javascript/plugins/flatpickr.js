require('flatpickr/dist/themes/material_green.css');
const flatpickr = require('flatpickr');

$(document).on('turbolinks:load', () => {
  $('.datepick').flatpickr({
    altInput: true,
    altFormat: 'F j, Y',
    dateFormat: 'Y-m-d',
    maxDate: 'today',
  });
});
