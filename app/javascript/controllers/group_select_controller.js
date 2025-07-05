import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="group-select"
export default class extends Controller {
  static targets = [
    "select",
    "result"
  ]

  connect() {
  }

  selectGroup() {
    const groupId = this.selectTarget.value

    if (!groupId) {
      this.resultTargets.forEach((result) => {result.value = ""})
      return
    }

    fetch("/trips/members_for_group", {
      method: "post",
      headers: {
        "Content-Type": "application/json",
        "X-CSRF-Token": document.querySelector('meta[name="csrf-token"]').content
      },
      body: JSON.stringify({ group_id: groupId})
    })

    .then(response => response.json())
    .then(data => {
      console.log(data.names)
      this.resultTargets.forEach((nameField, index) => {
        nameField.value = data.names[index] || ""; // データが不足していたら空文字で埋める
      });
    })

    .catch(error => {
      console.log("fetch error", error)
    })
  }

}
