import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [
    "moveArea",
    "message"
  ]

  flashTimeoutId = null

  connect() {
    this.moveAreaTargets.forEach((el) => {
      this.flashTimeoutId = setTimeout(() => {
        this.slideDown(el)
      })
    })
  }

  touchClose() {
    this.clearFlashTimeout()
    this.moveAreaTargets.forEach((el) => {
      this.slideUp(el)
    })
  }


  // reference
  slideUp(el) {
    el.classList.add('-translate-y-20')
    el.classList.remove('translate-y-0')
  }

  slideDown(el) {
    el.classList.remove('-translate-y-20')
    el.classList.add('translate-y-0')
    if (el.classList.contains("translate-y-0")) {
      setTimeout(() => {
        this.slideUp(el)}, 
        4000
      )
    }
  }

  clearFlashTimeout() {
    if (this.flashTimeoutId) {
      clearTimeout(this.flashTimeoutId)
      this.flashTimeoutId = null
    }
  }

}
