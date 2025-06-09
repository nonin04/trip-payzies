import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="participant-form"
export default class extends Controller {
  static targets = [
    "addBtn",
    "eachParticipantForm",
    "eachDeleteBtn",
  ]

  connect() {
    this.deleteBtnDisplayCheck()
  }

  deleteForm(event) {
    const parent = event.target.closest('[data-participant-form-target="eachParticipantForm"]')

    if (parent) {
      parent.querySelectorAll('input').forEach(input => {
        input.value = ""
      })
      parent.classList.add("hidden")
      this.deleteBtnDisplayCheck()
    }
    else {
      console.log("error:表示されているフォーム数が0件です")
    }
  }

  addForm() {
    const nextTarget = this.unDisplayTargets.at(-1)
    if (nextTarget) {
      nextTarget.classList.remove("hidden")
      this.deleteBtnDisplayCheck()
    }
  }

//----------------------------------------------

  deleteBtnDisplayCheck() {
    const formTargets = this.eachParticipantFormTargets
    const displayTargets = formTargets.filter(el => !el.classList.contains("hidden"))
    const firstTarget = displayTargets.at(0);

    this.unDisplayTargets = formTargets.filter(el => el.classList.contains("hidden"))

    if (displayTargets.length >= 10) {
      this.addBtnTarget.classList.add("hidden")
      console.log("1")
    }
    else if (displayTargets.length === 1) {
      const childDeleteBtn = firstTarget.querySelector('[data-participant-form-target="eachDeleteBtn"]')
      childDeleteBtn.classList.add("hidden")
      console.log("2")
    }
    else {
      displayTargets.forEach(t => {
        const deleteBtn = t.querySelectorAll('[data-participant-form-target="eachDeleteBtn"]')
        deleteBtn.forEach(Btn => Btn.classList.remove("hidden"))
      })
      this.addBtnTarget.classList.remove("hidden")
    }
  }
}
