# Pin npm packages by running ./bin/importmap

pin "application", preload: true
pin "@hotwired/turbo-rails", to: "turbo.min.js", preload: true
pin "@hotwired/stimulus", to: "stimulus.min.js", preload: true
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js", preload: true
pin_all_from "app/javascript/controllers", under: "controllers"
pin_all_from "app/javascript/channels", under: "channels"
pin_all_from "app/javascript/turbo_streams", under: "turbo_streams"
pin_all_from "app/javascript/helpers", under: "helpers"
pin "bootstrap", to: "https://ga.jspm.io/npm:bootstrap@5.3.0/dist/js/bootstrap.esm.js", preload: true
pin "@fortawesome/fontawesome-free", to: "https://ga.jspm.io/npm:@fortawesome/fontawesome-free@6.4.0/js/all.js", preload: true
pin "@popperjs/core", to: "https://ga.jspm.io/npm:@popperjs/core@2.11.8/lib/index.js", preload: true
pin "@rails/actioncable", to: "actioncable.esm.js", preload: true
pin "toastify-js", to: "https://ga.jspm.io/npm:toastify-js@1.12.0/src/toastify.js", preload: true
pin "@oddcamp/cocoon-vanilla-js", to: "https://ga.jspm.io/npm:@oddcamp/cocoon-vanilla-js@1.1.3/index.js"
pin "auto_resize_textarea", to: "app/javascript/components/auto_resize_textarea.js"
