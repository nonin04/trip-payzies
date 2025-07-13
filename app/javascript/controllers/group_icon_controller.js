import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="group-icon"
export default class extends Controller {
  static targets = [
    "input",
    "fileName",
    "iconPreview"
  ]
  connect() {
  }

  showFileName() {
    const file = this.inputTarget.files[0]
    if (file) {
      this.fileNameTarget.textContent = file.name
    } else {
      this.fileNameTarget.textContent = "アイコンが選択されていません。"
    }
  }
}
