import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="toggle-svg"
export default class extends Controller {
  static targets = ["before", "after"]
  connect() {
    this.showBefore();
  }

  toggle() {
    if (this.beforeTarget.classList.contains('hidden')) {
      
    }

  }

}
