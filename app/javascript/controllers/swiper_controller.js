import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="swiper"
export default class extends Controller {
  connect() {
    new Swiper(this.element, {
      direction: 'horizontal',
      loop: true,
      autoplay: {
        delay: 5000,
      },
      pagination: {
        el: this.element.querySelector('.swiper-pagination'),
      },
    })
  }
}
