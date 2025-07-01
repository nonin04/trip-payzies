import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="modal"
export default class extends Controller {
  static targets = [
    "modalEl",
    "modalBgEl",
    "closeBtn",
    "modalContentEl"
  ]



  connect() {
  }

  openModal() {
    const modalEl = this.modalElTarget
    const contentEl = this.modalContentElTarget
    this.openStyle(modalEl, contentEl)
  }

  closeModal() {
    const modalEl = this.modalElTarget
    const contentEl = this.modalContentElTarget
    this.closeStyle(modalEl, contentEl) 
  }


  openStyle(modalEl, contentEl) {

    modalEl.classList.remove("hidden")
    this.modalBgElTarget.classList.remove("opacity-0")
    this.modalBgElTarget.classList.add("opacity-50")
    requestAnimationFrame(() => {
    contentEl.classList.remove("opacity-0","scale-80")
    contentEl.classList.add("opacity-100","scale-100")
    modalEl.classList.remove("opacity-0")
    modalEl.classList.add("opacity-100")
    })
  }

  closeStyle(modalEl, contentEl) {
    contentEl.classList.remove("opacity-50", "scale-100")
    contentEl.classList.add("opacity-0", "scale-80")
    this.modalBgElTarget.classList.remove("opacity-50")
    this.modalBgElTarget.classList.add("opacity-0")

    setTimeout(() => {
      modalEl.classList.add("hidden")
    }, 200)
  }
}
