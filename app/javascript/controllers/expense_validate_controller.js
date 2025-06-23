import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="expense-validate"
export default class extends Controller {
  static targets = [
    "flashError",
    "checked",
    "checkBox",
    "submitBtn",
    "payer",
    "title",
    "amount",
    "date",
    "owedEl",
    "payerErrorMessage",
    "titleErrorMessage",
    "amountErrorMessage",
    "dateErrorMessage",
    "owedErrorMessage",
    "form"
  ]

  submitPrevent(event) {
    if (event.key === "Enter") {
      event.preventDefault();
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

  touchClose() {
    const flashErrorEl = this.flashErrorTarget
    this.slideUp(flashErrorEl)
  }

// references
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


  validate() {
    const hasPayerError = this.payerValidate()
    const hasAmountError = this.amountValidate()
    const hasTitleError = this.titleValidate()
    const hasDateError = this.dateValidate()
    const hasOwedError = this.owedValidate()

    return hasPayerError || hasAmountError || hasTitleError || hasDateError || hasOwedError;
  }

  //決済者--バリデーション---------------------------------------------------
  //----------------------------------------------------------------------
  payerValidate() {
    let hasError = false
    const payerInput = this.payerTarget
    const payerErrorMessage = this.payerErrorMessageTarget
    if (!payerInput.value) {
      this.addErrorStyle(payerInput)
      this.addErrorMessage(payerErrorMessage, "※選択必須です")
      hasError = true;
    }
    else {
      this.removeError(payerInput, payerErrorMessage)
      hasError = false;
    }
    return hasError;
  }

  //項目--バリデーション---------------------------------------------------
  titleValidate() {
    let hasError = false
    const titleInput = this.titleTarget
    const titleErrorMessage = this.titleErrorMessageTarget
    if (!titleInput.value) {
      this.addErrorStyle(titleInput)
      this.addErrorMessage(titleErrorMessage, "※入力必須です")
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
  //金額--バリデーション---------------------------------------------------  
  amountValidate() { 
    let hasError = false 
    const amountInput = this.amountTarget
    const amount = Number(amountInput.value)
    const amountErrorMessage = this.amountErrorMessageTarget
    if (!amountInput.value) {
      this.addErrorStyle(amountInput)
      this.addErrorMessage(amountErrorMessage, "※入力必須です")
      hasError = true;
    } 
    else if (isNaN(amount) || amount <= 0) {
      this.addErrorStyle(amountInput)
      this.addErrorMessage(amountErrorMessage, "※正しい金額を入力してください")
      hasError = true;
    } 
    else if (amount > 1000000) {
      this.addErrorStyle(amountInput)
      this.addErrorMessage(amountErrorMessage, "※100万円以内で入力してください")
      hasError = true;
    } 
    else {
      this.removeError(amountInput, amountErrorMessage)
      hasError = false;
    }
    return hasError;
  }

  //日付--バリデーション---------------------------------------------------  
  dateValidate() { 
    let hasError = false
    const dateInput = this.dateTarget
    const dateErrorMessage = this.dateErrorMessageTarget
    if (!dateInput.value) {
      this.addErrorStyle(dateInput)
      this.addErrorMessage(dateErrorMessage, "※入力必須です")
      hasError = true;
    }
    else {
      this.removeError(dateInput, dateErrorMessage)
      hasError = false;
    }
    return hasError;
  }

    //対象者--バリデーション---------------------------------------------------  
  owedValidate() { 
    let hasError = false
    const checkedImage = this.checkedTargets.filter(el => !el.classList.contains("hidden"))
    const owedErrorMessage = this.owedErrorMessageTarget
    const owedEl = this.owedElTarget

    if (checkedImage.length === 0) {
    owedErrorMessage.textContent = "※選択必須です"
    owedEl.classList.add("!bg-red-50")
    hasError = true;
    }
    else {
      owedErrorMessage.textContent = ""
      owedEl.classList.remove("!bg-red-50")
      hasError = false;
    }
    return hasError;
  }
}
