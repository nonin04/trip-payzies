import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="sidebar"
export default class extends Controller {

  static targets = [
    "sidebar",
    "hamburgerMenu",
    "mainEl"
  ]

  toggleSidebar() {
    this.isClosed() ? this.openMenu() : this.closeMenu()
  }

  hideSidebar() {
    if (!this.isClosed()) {this.closeMenu()
    }
  }

  isClosed() {
    const isClosed = this.sidebarTarget.classList.contains('translate-x-full')
    return isClosed
  }

  openMenu() {
    const mainElChilds = Array.from(this.mainElTarget.children)
    this.sidebarTarget.classList.remove("translate-x-full")
    this.sidebarTarget.classList.add("translate-x-0")
    this.mainElTarget.classList.remove("translate-x-0")
    this.mainElTarget.classList.add("-translate-x-16")
    mainElChilds.forEach(el => el.classList.add("pointer-events-none"))
  }

  closeMenu() {
    const mainElChilds = Array.from(this.mainElTarget.children)
    this.sidebarTarget.classList.add("translate-x-full")
    this.sidebarTarget.classList.remove("translate-x-0")
    this.mainElTarget.classList.add("translate-x-0")
    this.mainElTarget.classList.remove("-translate-x-16")
    mainElChilds.forEach(el => el.classList.remove("pointer-events-none"))

  }
}
