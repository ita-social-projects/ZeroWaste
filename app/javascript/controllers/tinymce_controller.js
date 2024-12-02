import { Controller } from '@hotwired/stimulus'

export default class extends Controller {
  static targets = ['input']

  connect() {
    tinymce.init(this.tinymceConfig)
  }

  disconnect() {
    tinymce.remove()
  }

  get tinymceConfig() {
    return {
      target: this.inputTarget,
      ...TinyMCERails.configuration.default
    }
  }
}
