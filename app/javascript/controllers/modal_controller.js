import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="modal"
export default class extends Controller {
  static targets = [
    "closeBtn",

    "descriptionModal",
    "descriptionModalBg",
    "descriptionModalContent",

    "destroyModal",
    "destroyModalBg",
    "destroyModalContent",

    "logoutModal",
    "logoutModalBg",
    "logoutModalContent"

  ]

  connect() {
  }


  openModal(event) {
    const name = event.params.name
    const modalEl = this[`${name}ModalTarget`]
    const pageBg = this[`${name}ModalBgTarget`]
    const content = this[`${name}ModalContentTarget`]
    this.openStyle(modalEl, pageBg, content)
  }
  closeModal(event) {
    const name = event.params.name
    const modalEl = this[`${name}ModalTarget`]
    const pageBg = this[`${name}ModalBgTarget`]
    const content = this[`${name}ModalContentTarget`]
    this.closeStyle(modalEl, pageBg, content) 
  }


  openStyle(modalEl, pageBg, content) {
    modalEl.classList.remove("hidden")
    pageBg.classList.remove("opacity-0")
    pageBg.classList.add("opacity-50")
    requestAnimationFrame(() => {
    content.classList.remove("opacity-0","scale-80")
    content.classList.add("opacity-100","scale-100")
    modalEl.classList.remove("opacity-0")
    modalEl.classList.add("opacity-100")
    })
  }

  closeStyle(modalEl, pageBg, content) {
    content.classList.remove("opacity-50", "scale-100")
    content.classList.add("opacity-0", "scale-80")
    pageBg.classList.remove("opacity-50")
    pageBg.classList.add("opacity-0")

    setTimeout(() => {
      modalEl.classList.add("hidden")
    }, 200)
  }
}
