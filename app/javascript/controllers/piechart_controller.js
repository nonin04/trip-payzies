import { Controller } from "@hotwired/stimulus"
import { Chart, registerables } from "chart.js"

Chart.register(...registerables)

// Connects to data-controller="piechart"
export default class extends Controller {

  static targets = ["myChart"]
  static values = { balances: Array}


  canvasContext() {
    if (!this.hasMyChartTarget) {
      console.warn("myChartTarget が見つかりません")
    return null
  }
    return this.myChartTarget.getContext('2d')
  }
  

  connect() {
    const balances = this.balancesValue.map(b => ({
      name: b.participant.name,
      paidTotal: b.paid_total,
    }))

    new Chart(this.canvasContext(), {

      type: 'doughnut',
      data: {
        labels: [...balances.map(b => b.name)],
        datasets: [{
          data: [...balances.map(b => b.paidTotal)],
          backgroundColor: [
            '#4F6783',
            '#e6bfb1',
            '#e6ded8',
            '#dd7859',
            '#9fc7d3',
            '#aec5b0',
            '#e6cf9f',
            '#c3b9d3',
            '#79b2b7',
            '#de9f89',
            '#de9f89'
          ],
          borderWidth: 1,
        }]
      },
      options: {

        maintainAspectRatio: false,
        responsive: true,
        cutout: '70%',
        plugins: {
          title: {
            color: '',
            display: true,
            text: '決済額合計',
          },
          legend: {
            position: 'bottom',
            labels: {
              color: 'black',
              boxWidth: 10,
              font:{
                size: 12
              }
            }
          }
        }
      }
    })
  }
}