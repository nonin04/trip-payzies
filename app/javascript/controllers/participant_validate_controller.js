import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="participant-validate"
export default class extends Controller {
  static targets = [
    "name",
    "eachTemplate",
    "dateErrorMessage",
    "submitBtn",
    "flashError",
    "form"
  ]

  submitPrevent(event) {
    if (event.key === "Enter") {
      event.preventDefault()
    }
  }

  submit(event) {
    event.preventDefault()
    const {noParticipantError, textLengthError} = this.validate()
    if (noParticipantError || textLengthError) {
      this.setFlashEl("※保存に失敗しました")
    }
    else {
      this.formTarget.submit()
    }
  }

  checkInput() {
    this.validate()
  }




  //references
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

    let textLengthError = false
    let noParticipantError = false

    const firstNameForm = this.nameTargets.at(0)
    const firstErrorMessageArea = this.dateErrorMessageTargets.at(0)

    //一人以上かチェック
    const emptyCounts = this.nameTargets.filter(el => el.value.trim())
    if (emptyCounts.length === 0) {
      firstNameForm.classList.add("!border-red-500", "!bg-red-100")
      firstErrorMessageArea.textContent = "※1人以上の参加者を追加してください"
      noParticipantError = true
      console.log("0人エラー")
    }
    else {
      //15字以内かチェック
      this.eachTemplateTargets.forEach(f => {
        const textArea = f.querySelector('input')
        const errorMessageArea = f.querySelector('[data-participant-validate-target="dateErrorMessage"]')
        if(textArea.value.trim().length > 15) {
          textArea.classList.add("!border-red-500", "!bg-red-100")
          errorMessageArea.textContent = "※15字以内で入力してください"
          textLengthError = true
          console.log("15字エラー")
        }
        else {
          textArea.classList.remove("!border-red-500", "!bg-red-100")
          errorMessageArea.textContent = ""
        }
      })
    }
    return {
      noParticipantError,
      textLengthError
    }
  }
}
