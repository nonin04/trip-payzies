import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="modal"
export default class extends Controller {
  static targets = [
    "mainEl",
    "modalEl",
    "modalBgEl",
    "closeBtn",
    "modalContentEl"
  ]



  connect() {
  }

  openModal() {
    const mainEl = this.mainElTarget
    const modalEl = this.modalElTarget
    const contentEl = this.modalContentElTarget
    this.openStyle(mainEl, modalEl, contentEl)
  }

  closeModal() {
    const mainEl = this.mainElTarget
    const modalEl = this.modalElTarget
    const contentEl = this.modalContentElTarget
    this.closeStyle(mainEl, modalEl, contentEl) 
  }


  openStyle(mainEl, modalEl, contentEl) {
    mainEl.classList.add("pointer-events-none")
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

  closeStyle(mainEl, modalEl, contentEl) {
    contentEl.classList.remove("opacity-50", "scale-100")
    contentEl.classList.add("opacity-0", "scale-80")
    this.modalBgElTarget.classList.remove("opacity-50")
    this.modalBgElTarget.classList.add("opacity-0")

    setTimeout(() => {
      mainEl.classList.remove("pointer-events-none")
      modalEl.classList.add("hidden")
    }, 200)
  }
}
