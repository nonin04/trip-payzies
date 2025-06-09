import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="form-step"
export default class extends Controller {
  static targets = [
    "stepGauge", 
    "stepTitle", 
    "tripForm", 
    "participantForm", 
    "toggleBtn", 
    "tripTitle",
    "tripDate",
    "titleErrorMessage",
    "dateErrorMessage",
    "deleteBtn",
    "eachParticipantForm",

  ];

  setError(element) {
    element.classList.add("!border-red-500", "!bg-red-100")
  }
  
  connect() {
    requestAnimationFrame(() => {
      this.stepGaugeTarget.style.width = "50%";
    })
    this.isStep2 = false
  };

  changeForm() {
    const title = this.tripTitleTarget
    const date = this.tripDateTarget
    let hasError = false;

    if (!title.value) {
      this.setError(title);
      this.titleErrorMessageTarget.textContent = "※入力必須項目です"
      hasError = true;
    } else if (title.value.length > 20) {
      this.setError(title);
      this.titleErrorMessageTarget.textContent = "※20字以内で入力してください"
      hasError = true;
    }

    if (!date.value) {
      this.setError(date);
      this.dateErrorMessageTarget.textContent = "※入力必須項目です"
      hasError = true;
    }

    if (hasError) return;
    
    this.isStep2 = !this.isStep2
    this.stepGaugeTarget.style.width = this.isStep2 ? "100%" : "50%";
    this.stepTitleTarget.textContent = this.isStep2 ? "STEP2" : "STEP1";
    this.toggleBtnTargets.forEach(btn => btn.classList.toggle("hidden"))
    this.tripFormTarget.classList.toggle("hidden")
    this.participantFormTarget.classList.toggle("hidden")
  }


  saveParticipants() {
    const participants = this.tripParticipantTargets

    let hasError = false;

    if (participants.forEach(p => p.value > 15)) {
      this.participantErrorMessageTarget.textContent = "15字以内で入力してください"
      hasError = true;
    }

  }
}
