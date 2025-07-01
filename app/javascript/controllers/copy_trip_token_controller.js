import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="copy-trip-token"
export default class extends Controller {

  static targets = [
    "flashNotice",
    "tokenInput"
  ]

  connect() {
  }

  copyToken() {
    const share_token = this.tokenInputTarget.value
    navigator.clipboard.writeText(share_token)
    console.log("共有リンクをコピーしました")

    this.tokenInputTarget.value = "コピーしました!"
    setTimeout(() => {
      this.tokenInputTarget.value = share_token},
      1500)
  }
}