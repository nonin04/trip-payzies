import { Controller } from "@hotwired/stimulus"
//---------------------------------------------------------------------------------------
// このコントローラーはtrip#new,editアクションでの旅行情報入力フォームを制御する
  //trip#new => 旅行情報のバリデーション
  //trip#new => フラッシュメッセージの設定
  //trip#new => ステップフォーム(STEP2 participants)への遷移
  //trip#edit => 旅行情報のバリデーション
  //trip#edit => フラッシュメッセージの設定

//trip#newではnested_attributesのparticpiantsも保存するがparticipants側のバリデーションは含まない
//---------------------------------------------------------------------------------------
// Connects to data-controller="trip-validate"
export default class extends Controller {
  static targets = [
    "stepGauge",
    "tripForm", 
    "participantForm", 
    "toggleBtn", 
    "tripTitle",
    "tripDate",
    "titleErrorMessage",
    "dateErrorMessage",
    "deleteBtn",
    "eachParticipantForm",
    "flashError",
    "submitBtn",
    "form"
  ]

  flashTimeoutId = null

  static values = {
    mode: String
  }

//actions
  connect() {
    if (this.modeValue === "new") {
      requestAnimationFrame(() => {
        this.stepGaugeTarget.style.width = "50%";
      })
      this.isStep2 = false
    }

  }

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
    this.toggleBtnTargets.forEach(btn => btn.classList.toggle("!hidden"))
    this.tripFormTarget.classList.toggle("hidden")
    this.participantFormTarget.classList.toggle("hidden")
  }

  // 更新時のバリデーションチェックとsubmit防止
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
      this.formTarget.submit()
    }
  }

  touchClose() {
    this.clearFlashTimeout()
    const flashErrorEl = this.flashErrorTarget
    this.slideUp(flashErrorEl)
  }


  // references
  formErrorClasses = ["!border-red-400", "!bg-red-50", "dark:!border-neutral-600", "dark:!bg-neutral-800"]

  addErrorStyle(formEl) {
    formEl.classList.add(...this.formErrorClasses)
  }l
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




  validate() {
    const hasTitleError = this.titleValidate()
    const hasDateError = this.dateValidate()

    return hasTitleError || hasDateError
  }

//旅行名バリデーションチェック------------------------------------------
//-----------------------------------------------------------------
  titleValidate() {
    let hasError = false;
    const titleInput = this.tripTitleTarget
    const titleErrorMessage = this.titleErrorMessageTarget
    if (!titleInput.value) {
      this.addErrorStyle(titleInput)
      this.addErrorMessage(titleErrorMessage, "※入力必須項目です")
      hasError = true;
    }
    else if (titleInput.value.length > 25) {
      this.addErrorStyle(titleInput)
      this.addErrorMessage(titleErrorMessage, "※25字以内で入力してください")
      hasError = true;
    }
    else {
      this.removeError(titleInput, titleErrorMessage)
      hasError = false;
    }
    return hasError;
  }

//出発日バリデーションチェック------------------------------------------
  dateValidate() {
    let hasError = false;
    const dateInput = this.tripDateTarget
    const dateErrorMessage = this.dateErrorMessageTarget
    if (!dateInput.value) {
      this.addErrorStyle(dateInput)
      this.addErrorMessage(dateErrorMessage, "※入力必須項目です")
      hasError = true;
    }
    else {
      this.removeError(dateInput, dateErrorMessage)
      hasError = false;
    }
    return hasError;
  }
}
