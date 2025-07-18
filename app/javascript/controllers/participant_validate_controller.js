import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="participant-validate"
export default class extends Controller {
  static targets = [
    "name",
    "eachTemplate",
    "nameErrorMessage",
    "submitBtn",
    "flashError",
    "form",
    "participantCard",
    "duplicatedErrorMessage"
  ]
  static values = {
    errorMessages: Object,
  }

  flashTimeoutId = null

  submitPrevent(event) {
    if (event.key === "Enter") {
      event.preventDefault()
    }
  }

  submit(event) {
    event.preventDefault()
    const hasError = this.validate()
    if (hasError) {
      this.setFlashEl(this.errorMessagesValue.failed)
    }
    else {
      this.submitBtnTarget.disabled = true
      this.formTarget.submit()
    }
  }

  checkInput() {
    this.validate()
  }






  validate() {
    return this.countCheck() || this.lengthCheck() || this.duplicateCheck()
  }


  countCheck() {
    let hasError = false
    const firstNameInput = this.nameTargets.at(0)
    const firstNameErrorMessage = this.nameErrorMessageTargets.at(0)

    const othertemplates = this.eachTemplateTargets.slice(1)


    const filledCounts = this.nameTargets.filter(el => el.value.trim())
    if (filledCounts.length === 0) {
      this.addErrorStyle(firstNameInput)
      this.addErrorMessage(firstNameErrorMessage, this.errorMessagesValue.participantRequired)

      othertemplates.forEach(f => {
        const nameInput = f.querySelector('input')
        const nameErrorMessage = f.querySelector('[data-participant-validate-target="nameErrorMessage"]')
        this.removeError(nameInput, nameErrorMessage)
      })

      hasError = true
      console.log("0人エラー")
    }

    else {
      this.removeError(firstNameInput, firstNameErrorMessage)
    }

    return hasError;
  }

  lengthCheck() {
    let hasError = false
    this.eachTemplateTargets.forEach(f => {
      const nameInput = f.querySelector('input')
      const nameErrorMessage = f.querySelector('[data-participant-validate-target="nameErrorMessage"]')

      if(nameInput.value.trim().length > 15) {
        this.addErrorStyle(nameInput)
        this.addErrorMessage(nameErrorMessage, this.errorMessagesValue.maxLength15)
        hasError = true
        console.log("15字エラー")
      }
      else {
        this.removeError(nameInput, nameErrorMessage)
      }
    })
    return hasError;
  }

  duplicateErrorClasses = ["!border-red-400", "dark:!border-transparent", "dark:!bg-neutral-800"]

  duplicateCheck() {
    let hasError = false
    function isDuplicated(nameInputs) {
      const trimmed = nameInputs.map(name  => name.value.trim()).filter(name => name !== "");
      const setElements = new Set(trimmed);
      return setElements.size !== trimmed.length;
    }
    if (isDuplicated(this.nameTargets)) {
      this.participantCardTarget.classList.add(...this.duplicateErrorClasses)
      this.duplicatedErrorMessageTarget.textContent = this.errorMessagesValue.duplicated
      console.log("重複エラー")
      hasError = true
    } else {
      this.participantCardTarget.classList.remove(...this.duplicateErrorClasses)
      this.duplicatedErrorMessageTarget.textContent = ""
    }
    return hasError
  }

  touchClose() {
    this.clearFlashTimeout()
    const flashErrorEl = this.flashErrorTarget
    this.slideUp(flashErrorEl)
  }

  formErrorClasses = ["!border-red-400", "!bg-red-50", "dark:!border-neutral-600", "dark:!bg-neutral-800"]
    //references
  addErrorStyle(formEl) {
    formEl.classList.add(...this.formErrorClasses)
  }
  addErrorMessage(formEl, errorMessage) {
    formEl.textContent = errorMessage
  }
  removeError(formEl, messageEl) {
    formEl.classList.remove(...this.formErrorClasses)
    messageEl.textContent = ""
  }

  setFlashEl(message) {
    const flashErrorEl = this.flashErrorTarget
    const errorMessageEl = flashErrorEl.querySelector('p')
    errorMessageEl.textContent = message
    this.slideDown(flashErrorEl)
    this.clearFlashTimeout()
    this.flashTimeoutId = setTimeout(() => {
      this.slideUp(flashErrorEl)}, 
      4000
    )
  }
  removeFlashEl() {
    const flashErrorEl = this.flashErrorTarget
    this.slideUp(flashErrorEl)
  }


  slideUp(el) {
    el.classList.add('-translate-y-20')
    el.classList.remove('translate-y-0')
  }
  
  slideDown(el) {
    el.classList.remove('-translate-y-20')
    el.classList.add('translate-y-0')
  }

  clearFlashTimeout() {
    if (this.flashTimeoutId) {
      clearTimeout(this.flashTimeoutId)
      this.flashTimeoutId = null
    }
  }
}
