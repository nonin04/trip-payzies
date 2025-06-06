import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["message"]

  connect() {
    this.messageTargets.forEach((el) => {
      setTimeout(() => {
        el.classList.remove('-translate-y-full')
        el.classList.add('translate-y-0')
      }
    )}
  )}
};
