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

  submitPrevent(event) {
    if (event.key === "Enter") {
      event.preventDefault()
    }
  }

  submit(event) {
    event.preventDefault()
    const {hasError} = this.validate()
    if (hasError) {
      this.setFlashEl("※保存に失敗しました")
    }
    else {
      this.formTarget.submit()
    }
  }

  checkInput() {
    this.validate()
  }

  validate() {
    let hasError = false
    
    //一人以上かチェック
    const firstNameInput = this.nameTargets.at(0)
    const firstNameErrorMessage = this.nameErrorMessageTargets.at(0)
    const emptyCounts = this.nameTargets.filter(el => el.value.trim())
    if (emptyCounts.length === 0) {
      this.addErrorStyle(firstNameInput)
      this.addErrorMessage(firstNameErrorMessage, "※1人以上の参加者を追加してください")
      hasError = true
      console.log("0人エラー")
      return hasError;
    }

    //15字以内かチェック
    this.eachTemplateTargets.forEach(f => {
      const nameInput = f.querySelector('input')
      const nameErrorMessage = f.querySelector('[data-participant-validate-target="nameErrorMessage"]')
      if(nameInput.value.trim().length > 15) {
        this.addErrorStyle(nameInput)
        this.addErrorMessage(nameErrorMessage, "※15字以内で入力してください")
        hasError = true
        console.log("15字エラー")
      }
      else {
        this.removeError(nameInput, nameErrorMessage)
      }
    })

    //名前重複チェック
    function isDuplicated(nameInputs) {
      const trimmed = nameInputs.map(name  => name.value.trim()).filter(name => name !== "");
      const setElements = new Set(trimmed);
      return setElements.size !== trimmed.length;
    }
    if (isDuplicated(this.nameTargets)) {
      this.participantCardTarget.classList.add("!border-red-400")
      this.duplicatedErrorMessageTarget.textContent = "※名前が重複しています"
      hasError = true
    } else {
      this.participantCardTarget.classList.remove("!border-red-400")
      this.duplicatedErrorMessageTarget.textContent = ""
      hasError = false
    }

    return hasError;
  }


    //references
  setFlashEl(message) {
    const flashErrorEl = this.flashErrorTarget
    const errorMessageEl = flashErrorEl.querySelector('p')
    errorMessageEl.textContent = message
    flashErrorEl.classList.remove("-translate-y-full")
    flashErrorEl.classList.add("translate-y-0")
    setTimeout(() => this.removeFlashEl(), 5000)
  }
  removeFlashEl() {
    const flashErrorEl = this.flashErrorTarget
    flashErrorEl.classList.remove("translate-y-0")
    flashErrorEl.classList.add("-translate-y-full")
  }

  addErrorStyle(formEl) {
    formEl.classList.add("!border-red-400", "!bg-red-50")
  }l
  addErrorMessage(formEl, errorMessage) {
    formEl.textContent = errorMessage
  }
  removeError(formEl, messageEl) {
    formEl.classList.remove("!border-red-400", "!bg-red-50")
    messageEl.textContent = ""
  }
}
