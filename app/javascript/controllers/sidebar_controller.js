import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="sidebar"
export default class extends Controller {

  static targets = [
    "sidebar",
    "hamburgerMenu",
    "mainEl"
  ]

  hideSidebar() {
    if (this.isOpened()) {this.toggleSidebar()
    }
  }

  isOpened() {
    const isClosed = this.sidebarTarget.classList.contains('translate-x-0')
    return isClosed
  }

  toggleSidebar() {
    const mainElChilds = Array.from(this.mainElTarget.children)
    this.sidebarTarget.classList.toggle("translate-x-full")
    this.sidebarTarget.classList.toggle("translate-x-0")
    this.mainElTarget.classList.toggle("translate-x-0")
    this.mainElTarget.classList.toggle("-translate-x-16")
    mainElChilds.forEach(el => el.classList.toggle("pointer-events-none"))
  }
}
