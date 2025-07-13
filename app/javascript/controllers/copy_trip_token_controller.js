import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="copy-trip-token"
export default class extends Controller {

  static targets = [
    "flashNotice",
    "tokenInput"
  ]
  static values = {
    notice: String,
  }

  connect() {
  }

  copyToken() {
    const share_token = this.tokenInputTarget.value
    navigator.clipboard.writeText(share_token)
    console.log(this.noticeValue);

    this.tokenInputTarget.value = this.noticeValue
    setTimeout(() => {
      this.tokenInputTarget.value = share_token},
      1500)
  }
}