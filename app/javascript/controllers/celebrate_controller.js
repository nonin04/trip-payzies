import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="celebrate"
export default class extends Controller {
  static targets = [
    "effect"
  ]
  connect() {
    const params = new URLSearchParams(window.location.search)
    if (params.get("settled")) {
      this.effectTarget.classList.remove("hidden")

      setTimeout(() => {
        const url = new URL(window.location);
        url.searchParams.delete("settled");
        window.history.replaceState({}, "", url);
        this.effectTarget.classList.add("hidden")
      }, 5000);
    }
  }
}
