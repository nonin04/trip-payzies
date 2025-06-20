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
    const isClosed = this.sidebarTarget.style.width === "" || this.sidebarTarget.style.width === "0px"
    return isClosed
  }

  openMenu() {
    const mainElChilds = Array.from(this.mainElTarget.children)
    this.sidebarTarget.style.width = "200px"
    this.sidebarTarget.classList.remove("pointer-events-none")
    mainElChilds.forEach(el => el.classList.add("pointer-events-none"))
  }

  closeMenu() {
    const mainElChilds = Array.from(this.mainElTarget.children)
    this.sidebarTarget.style.width = "0px"
    this.sidebarTarget.classList.add("pointer-events-none")
    mainElChilds.forEach(el => el.classList.remove("pointer-events-none"))

  }
}
