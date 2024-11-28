import { Controller } from '@hotwired/stimulus'

export default class extends Controller {
    static targets = ['input']

    connect() {
        let config = Object.assign({ target: this.inputTarget }, TinyMCERails.configuration.default )
        tinymce.init(config)
        
    }

    disconnect () {
       tinymce.remove()
    }
  }

