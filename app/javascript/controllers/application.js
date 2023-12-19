import { Application } from "@hotwired/stimulus"
import { Turbo } from "@hotwired/turbo-rails";
import "../turbo_streams/toast"

const application = Application.start()
Turbo.start();

// Configure Stimulus development experience
application.debug = false
window.Stimulus   = application

export { application }
