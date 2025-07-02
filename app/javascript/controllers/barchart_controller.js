import { Controller } from "@hotwired/stimulus"
import { Chart, registerables } from "chart.js"
import { isDarkMode } from "utils/theme" 

Chart.register(...registerables)

// Connects to data-controller="barchart"
export default class extends Controller {

  static targets =["myChart"]
  static values ={netBalances: Array}

  canvasContext() {
    if (!this.hasMyChartTarget) {
      console.warn("myChartTarget が見つかりません")
    return null
  }
    return this.myChartTarget.getContext('2d')
  }
  

  connect() {
    const net_balances = this.netBalancesValue.map(nb => ({
      name: nb.participant.name,
      difference: nb.difference,
    }))

    new Chart(this.canvasContext(), {
      type: 'bar',
      data: {
        labels: net_balances.map(nb => nb.name),
        datasets: [{
          data: net_balances.map(nb => nb.difference),
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
          borderColor: 'white',
        }]
      },
      options: {
        maintainAspectRatio: false,
        responsive: true,
        plugins: {
          title: {
            color: 'black',
            display: true,
            text: '貸し借り差額グラフ',
          },
          legend: {
            display: false,
            labels: {
            },
            onClick: () => {}
          }
        },
        scales: {
          y:{
            ticks:{
              color: 'black',
            }
          },
          x:{
            ticks:{
              color: 'black',
            }
          }
        }
      }
    })
  }
}