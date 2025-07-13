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

    window.addEventListener("beforeunload",this.removeFlash)
    document.addEventListener("turbo:before-visit", this.removeFlash)
  }

  disconnect() {
    window.removeEventListener("beforeunload",this.removeFlash)
    document.removeEventListener("turbo:before-visit", this.removeFlash)
  }

  removeFlash = () => {
    this.moveAreaTargets.forEach((el) =>
      el.remove()
    )
  }


  touchClose() {
    if (this.flashTimeoutId) {
      clearTimeout(this.flashTimeoutId)
      this.flashTimeoutId = null
    }
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

}
