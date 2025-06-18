import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="sidebar"
export default class extends Controller {

  static targets = [
    "sidebar",
    "hamburgerMenu",
    "mainEl"
  ]

  menuBtn() {
    this.sidebarTarget.classList.toggle("opacity-0")
    this.sidebarTarget.classList.toggle("pointer-events-none")
    this.mainElTarget.classList.toggle("pointer-events-none")
  }
}
