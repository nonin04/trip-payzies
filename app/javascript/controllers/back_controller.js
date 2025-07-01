import { Controller } from "@hotwired/stimulus"
import { Turbo } from "@hotwired/turbo-rails"

// Connects to data-controller="back"
export default class extends Controller {

  static targets = [
  ]
  static values = {
    returnTo: String,
    returnGroupId: String,
  }

  goBack() {
    history.back()
  }

  goBackFromTrip() {
    const returnToPage = localStorage.getItem("returnToPage")
    const groupId = localStorage.getItem("returnGroupId")
    if (returnToPage === "trip-index") {
      Turbo.visit("/trips")
      this.clearLocalStorage()
    }
    else if (returnToPage === "group-show"){
      Turbo.visit("/groups/" + groupId)
      this.clearLocalStorage()
    }
    else{
      history.back()
    }
  }

  storeFromPage() {
    localStorage.setItem("returnToPage",this.returnToValue)
    if (this.returnGroupIdValue) {
      localStorage.setItem("returnGroupId",this.returnGroupIdValue)
    }
  }


  clearLocalStorage() {
    localStorage.removeItem("returnToPage");
    localStorage.removeItem("returnGroupId");
  }
}
