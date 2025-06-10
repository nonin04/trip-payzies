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
    "flashError"
  ];
//actions
  connect() {
    requestAnimationFrame(() => {
      this.stepGaugeTarget.style.width = "50%";
    })
    this.isStep2 = false
  };


  checkInput() {
    this.validate()
  }

  changeForm() {
    const hasError = this.validate()

    if (hasError) {
      this.setFlashEl("※保存に失敗しました")
      return;
    }

    this.removeFlashEl()
    this.isStep2 = !this.isStep2
    this.stepGaugeTarget.style.width = this.isStep2 ? "100%" : "50%";
    this.stepTitleTarget.textContent = this.isStep2 ? "STEP2" : "STEP1";
    this.toggleBtnTargets.forEach(btn => btn.classList.toggle("hidden"))
    this.tripFormTarget.classList.toggle("hidden")
    this.participantFormTarget.classList.toggle("hidden")
  }

  // references
  addErrorStyle(formEl) {
    formEl.classList.add("!border-red-500", "!bg-red-100")
  }l
  addErrorMessage(formEl, errorMessage) {
    formEl.textContent = errorMessage
  }
  removeError(formEl, messageEl) {
    formEl.classList.remove("!border-red-500", "!bg-red-100")
    messageEl.textContent = ""
  }
  setFlashEl(message) {
    const flashErrorEl = this.flashErrorTarget
    const errorMessageEl = flashErrorEl.querySelector('p')
    errorMessageEl.textContent = message
    flashErrorEl.classList.remove("-translate-y-full")
    flashErrorEl.classList.add("translate-y-0")
    setTimeout(() => this.removeFlashEl(), 3000)
  }
  removeFlashEl() {
    const flashErrorEl = this.flashErrorTarget
    flashErrorEl.classList.remove("translate-y-0")
    flashErrorEl.classList.add("-translate-y-full")
  }
  validate() {
    const titleInput = this.tripTitleTarget
    const dateInput = this.tripDateTarget
    const titleErrorMessage = this.titleErrorMessageTarget
    const dateErrorMessage = this.dateErrorMessageTarget

    let hasError = false;

    if (!titleInput.value) {
      this.addErrorStyle(titleInput)
      this.addErrorMessage(titleErrorMessage, "※入力必須項目です")
      hasError = true;
    } 
    else if (titleInput.value.length > 20) {
      this.addErrorStyle(titleInput)
      this.addErrorMessage(titleErrorMessage, "※20字以内で入力してください")
      hasError = true;
    } 
    else {
      this.removeError(titleInput, titleErrorMessage)
    }

    if (!dateInput.value) {
      this.addErrorStyle(dateInput)
      this.addErrorMessage(dateErrorMessage, "※入力必須項目です")
      hasError = true;
    }
    else {
      this.removeError(dateInput, dateErrorMessage)
    }
    return hasError;
  }
}
