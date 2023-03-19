import { Application } from "@hotwired/stimulus";
import { definitionsFromContext } from "@hotwired/stimulus-webpack-helpers";
const application = Application.start();

// Configure Stimulus development experience
application.debug = false;
window.Stimulus = application;

const context = require.context("./", true, /_controller\.js$/);

application.load(definitionsFromContext(context));
