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
    "catchCopy"
  ]

  connect() {


    this.fadeInUpTargets.forEach((el) => {
      el.classList.remove("opacity-0");
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
      el.classList.remove("opacity-0");
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
      }, (index + 1) * 200);
    });

    this.catchCopyTargets.forEach((el) => {
      el.classList.remove("animate-fadeIn");
      setTimeout(() => {
      el.classList.remove("opacity-0")
      el.classList.add("animate-fadeIn");
      },200)
    });


    this.fadeInUpLateTargets.forEach((el) => {
      el.classList.remove("animate-fadeInUp");
      setTimeout(() => {
        el.classList.remove("opacity-0", "pointer-events-none")
        el.classList.add("animate-fadeInUp");
      }, 700);
    });


    this.shakableTargets.forEach((el) => {
      el.classList.remove("animate-shake");
      setTimeout(() => {
        el.classList.add("animate-shake");
      },400);
    });

  }

}
