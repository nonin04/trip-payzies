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
    "flashError",
    "submitBtn",
    "form"
  ]
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
    this.stepTitleTarget.textContent = this.isStep2 ? "STEP2" : "STEP1";
    this.toggleBtnTargets.forEach(btn => btn.classList.toggle("hidden"))
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


  // references
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


  validate() {
    const hasTitleError = this.titleValidate()
    const hasDateError = this.dateValidate()

    return hasTitleError || hasDateError
  }


//旅行名バリデーションチェック------------------------------------------
  titleValidate() {
    let hasError = false;
    const titleInput = this.tripTitleTarget
    const titleErrorMessage = this.titleErrorMessageTarget
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
