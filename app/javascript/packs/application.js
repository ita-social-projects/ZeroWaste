// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import Rails from '@rails/ujs';
import Turbolinks from 'turbolinks';
import * as ActiveStorage from '@rails/activestorage';
import 'channels';
require('jquery');
require("@nathanvda/cocoon");
// const jQuery = require('jquery');
// global.$ = global.jQuery = jQuery;
// window.$ = window.jQuery = jQuery;
import 'bootstrap';
import '@fortawesome/fontawesome-free/js/all';
import '../stylesheets/application';
// import 'ajax/result_button';
import 'ajax/checkbox';
import 'plugins/flatpickr';
import "@fortawesome/fontawesome-free/css/all"

import "../js/calculators/edit"
import "../controllers/index"

import "../ajax/calculate_result_button"

const images = require.context('../images', true)
Rails.start();
Turbolinks.start();
ActiveStorage.start();
// document.addEventListener('turbolinks:load', () => {
//   $('[data-toggle="tooltip"]').tooltip();
//   $('[data-toggle="popover"]').popover();
// });
$('document').ready(function() {
    setTimeout(function() {
        $('.alert').slideUp();
    }, 10000);
});
