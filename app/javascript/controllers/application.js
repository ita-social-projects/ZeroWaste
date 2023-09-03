import { Application } from "@hotwired/stimulus"
import toastr from "toastr";


const application = Application.start()

// Configure Stimulus development experience
application.debug = false
window.Stimulus   = application

export { application }
export { toastr }
