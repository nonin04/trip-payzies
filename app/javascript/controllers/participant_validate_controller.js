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
    const hasError = this.validate()
    if (hasError) {
      this.setFlashEl("※保存に失敗しました")
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
      this.addErrorMessage(firstNameErrorMessage, "※1人以上の参加者を追加してください")

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
        this.addErrorMessage(nameErrorMessage, "※15字以内で入力してください")
        hasError = true
        console.log("15字エラー")
      }
      else {
        this.removeError(nameInput, nameErrorMessage)
      }
    })
    return hasError;
  }

  duplicateCheck() {
    let hasError = false
    function isDuplicated(nameInputs) {
      const trimmed = nameInputs.map(name  => name.value.trim()).filter(name => name !== "");
      const setElements = new Set(trimmed);
      return setElements.size !== trimmed.length;
    }
    if (isDuplicated(this.nameTargets)) {
      this.participantCardTarget.classList.add("border", "!border-red-400")
      this.duplicatedErrorMessageTarget.textContent = "※名前が重複しています"
      console.log("重複エラー")
      hasError = true
    } else {
      this.participantCardTarget.classList.remove("!border-red-400")
      this.duplicatedErrorMessageTarget.textContent = ""
    }
    return hasError
  }

  touchClose() {
    const flashErrorEl = this.flashErrorTarget
    this.slideUp(flashErrorEl)
  }


    //references
  addErrorStyle(formEl) {
    formEl.classList.add("!border-red-400", "!bg-red-50")
  }
  addErrorMessage(formEl, errorMessage) {
    formEl.textContent = errorMessage
  }
  removeError(formEl, messageEl) {
    formEl.classList.remove("!border-red-400", "!bg-red-50")
    messageEl.textContent = ""
  }

  setFlashEl(message) {
  const flashErrorEl = this.flashErrorTarget
  const errorMessageEl = flashErrorEl.querySelector('p')
  errorMessageEl.textContent = message
  errorMessageEl.textContent = message
  this.slideDown(flashErrorEl)
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
    if (el.classList.contains("translate-y-0")) {
      setTimeout(() => {
        this.slideUp(el)}, 
        3000
      )
    }
  }
}
