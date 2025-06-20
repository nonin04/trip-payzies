import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="accordion"
export default class extends Controller {
  static targets = [
    "bar",
    "participantsEl",
    "icon"
  ]
  toggle() {
    const iconEl = this.iconTarget
    const participantEl = this.participantsElTarget

    iconEl.classList.toggle("rotate-180")


    const isClosed = participantEl.style.height === "" || participantEl.style.height === "0px"
    if (isClosed) {
      const elHeight = participantEl.scrollHeight
      participantEl.style.height = elHeight + "px"
    }
    else {
      participantEl.style.height = "0px"
    }
  }
}
