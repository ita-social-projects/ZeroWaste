require('flatpickr/dist/themes/material_green.css');
const flatpickr = require('flatpickr');

$(function () {
  $('#datepicker').flatpickr({
    altInput: true,
    altFormat: 'F j, Y',
    dateFormat: 'Y-m-d',
    maxDate: 'today',
  });
  $('#mybtn').on('click', function () {
    let choosenDate = new Date (document.getElementById('datepicker').value);
    let differentsOfDays = Math.floor((Date.now() - choosenDate.getTime()) / 1000 / 60 / 60 / 24);
    $('#days').html(differentsOfDays);
  });
});
