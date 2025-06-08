import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="form-step"
export default class extends Controller {
  static targets = [
    "stepGauge", 
    "stepTitle", 
    "tripForm", 
    "participantForm", 
    "toggleBtn", 
    "tripTitle"

  ];
  
  connect() {
    requestAnimationFrame(() => {
      this.stepGaugeTarget.style.width = "50%";
    })
    this.isStep2 = false
  };

  changeForm() {
    const form =this.element.querySelector("form");
    const title = this.tripTitleTarget
    const date = this.tripDateTarget
    const errorStyle = classList.add("!border-red-500 !bg-red-100")
    const 

    if (title.value.lengh > 20) {
      this.title.errorStyle
      return;
    }

    if (!date.value) {
      this.date.errorStyle
      return;
    }

      this.isStep2 = !this.isStep2
      this.stepGaugeTarget.style.width = this.isStep2 ? "100%" : "50%";
      this.stepTitleTarget.textContent = this.isStep2 ? "STEP2" : "STEP1";
      this.toggleBtnTargets.forEach(btn => btn.classList.toggle("hidden"))
      this.tripFormTarget.classList.toggle("hidden")
      this.participantFormTarget.classList.toggle("hidden")
    }
  };
