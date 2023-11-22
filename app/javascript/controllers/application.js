import { Application } from "@hotwired/stimulus"
import { Turbo } from "@hotwired/turbo-rails";
import toastr from "toastr";

window.toastr = toastr

const application = Application.start()
Turbo.start();

// Configure Stimulus development experience
application.debug = false
window.Stimulus   = application

export { application }
