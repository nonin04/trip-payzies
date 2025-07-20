import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="date-restrict"
export default class extends Controller {
  static targets = [
    "currencyType",
    "dateField",
    "attention"
  ]
  static values = {
    today: String
  }

  connect() {
    if (!this.isJpy()) {
      this.setMinMax()
      this.setAttention()
    }
  }
  
  toggle() {
    if (this.isJpy()) {
      this.removeMinMax()
      this.removeAttention()
    } else {
      this.setMinMax()
      this.setAttention()
    }
  }

  isJpy() {
    return this.currencyTypeTarget.selectedOptions[0]?.textContent === "JPY"
  }

  setMinMax() {
    const dateInput = this.dateFieldTarget
    const minDate = "2025-07-19"
    const maxDate = this.todayValue
    console.log(this.todayValue)
    dateInput.setAttribute("min", minDate)
    dateInput.setAttribute("max", maxDate)
  }

  removeMinMax() {
    const dateInput = this.dateFieldTarget
    dateInput.removeAttribute("min")
    dateInput.removeAttribute("max")
  }

  setAttention() {
    this.attentionTarget.classList.remove("hidden")
  }
  removeAttention() {
    this.attentionTarget.classList.add("hidden")
  }
}

