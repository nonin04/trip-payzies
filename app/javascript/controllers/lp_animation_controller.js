import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="lp-animation"
export default class extends Controller {
  static targets = [
    "shakable",
    "fadeInUp",
    "fadeInDown",
    "expand",
    "fadeInUpLate",
    "fadeIn",
  ]

  connect() {


    this.fadeInUpTargets.forEach((el) => {
      el.classList.remove("animate-fadeInUp");
      requestAnimationFrame(() => {
        el.classList.add("animate-fadeInUp");
      });
    });

    this.expandTargets.forEach((el) => {
      el.classList.remove("animate-expand");
      el.classList.remove("opacity-0");
      requestAnimationFrame(() => {
        el.classList.add("animate-expand");
      });
    });


    this.fadeInDownTargets.forEach((el) => {

      el.classList.remove("animate-fadeInDown");
      requestAnimationFrame(() => {
        el.classList.add("animate-fadeInDown");
      });
    });

    const descriptionEls =  Array.from(this.fadeInTarget.children)
    descriptionEls.forEach((el, index) => {
      el.classList.remove("animate-fadeIn");
      setTimeout(() => {
        el.classList.remove("opacity-0")
        el.classList.add("animate-fadeIn");
      }, (index + 1) * 300);
    });

    this.fadeInUpLateTargets.forEach((el) => {
      el.classList.remove("animate-fadeInUp");
      setTimeout(() => {
        el.classList.remove("opacity-0", "pointer-events-none")
        el.classList.add("animate-fadeInUp");
      }, 300);
    });


    this.shakableTargets.forEach((el) => {
      el.classList.remove("animate-shake");
      setTimeout(() => {
        el.classList.add("animate-shake");
      }, 1000);
    });

  }

}
