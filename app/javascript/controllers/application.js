// app/javascript/controllers/application.js
import { Application } from "@hotwired/stimulus"
import { definitionsFromContext } from "@hotwired/stimulus-loading"

const application = Application.start()
application.debug = false
window.Stimulus = application

export { application }
