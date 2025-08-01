import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="demo"
export default class extends Controller {
  static targets = [
    "email",
    "password"
  ]

  fill() {
    this.emailTarget.value = "test@email.com"
    this.passwordTarget.value = "password"
  }
}
