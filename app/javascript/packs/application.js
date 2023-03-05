// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import Rails from "@rails/ujs";
import Turbolinks from "turbolinks";
import * as ActiveStorage from "@rails/activestorage";
import "channels";
import "@rails/request.js";

require("jquery");
require("@nathanvda/cocoon");

// const jQuery = require('jquery');
// global.$ = global.jQuery = jQuery;
// window.$ = window.jQuery = jQuery;

import "@fortawesome/fontawesome-free/js/all";

// import 'ajax/result_button';
import "ajax/checkbox";
import "plugins/flatpickr";

import "../js/calculators/edit";
import "../controllers/stimulus_application";

global.toastr = require("toastr");

Rails.start();
Turbolinks.start();
ActiveStorage.start();

// document.addEventListener('turbolinks:load', () => {
//   $('[data-toggle="tooltip"]').tooltip();
//   $('[data-toggle="popover"]').popover();
// });

$("document").ready(function () {
  setTimeout(function () {
    $(".alert").slideUp();
  }, 10000);
});
