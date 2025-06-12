import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="expense-checkbox"
export default class extends Controller {
  static targets = [
    "checkForm",
    "unChecked",
    "checked"
  ]

  checkBtn(event) {
    const el = event.currentTarget
    const beforeBtn = el.querySelector('[data-expense-checkbox-target="unChecked"]')
    const afterBtn = el.querySelector('[data-expense-checkbox-target="checked"]')
    beforeBtn.classList.toggle("hidden")
    afterBtn.classList.toggle("hidden")
  }
}

