import React, { useState } from 'react'
import { Line } from 'react-chartjs-2'
import {Chart as ChartJS} from "chart.js/auto"
import style from "./LineChart.module.css"
const LineChart = (props) => {

  let [chart,setChart]=useState([])

  console.log(props.data)
  // if(props.data.length)
  let data=props.data.reverse()
  if(data.length<7)
  {
    for(let i=0;i<7-data.length+1;i++)
    {
      data.push(0)
    }
    setChart(data)
  }
  else{
    data=data.slice(0,7)
  }
  return (
    
      <div className={style.cont}>
      <div className={style.text} >Recent Transaction Amount   </div>
      <Line
        data={{
          labels: ['SAT', 'SUN', 'MON', 'TUE', 'WED', 'Thu','Fri'],
          datasets: [
            {
              label: props.label,
              data: chart,
              backgroundColor: [
                'rgba(255, 99, 132, 0.2)',
                'rgba(54, 162, 235, 0.2)',
                'rgba(255, 206, 86, 0.2)',
                'rgba(75, 192, 192, 0.2)',
                'rgba(153, 102, 255, 0.2)',
                'rgba(255, 159, 64, 0.2)',
              ],
              borderColor: [
                'rgba(255, 99, 132, 1)',
                'rgba(54, 162, 235, 1)',
                'rgba(255, 206, 86, 1)',
                'rgba(75, 192, 192, 1)',
                'rgba(153, 102, 255, 1)',
                'rgba(255, 159, 64, 1)',
              ],
              borderWidth: 1,
              fill: {
                target: 'origin',
                above: 'rgb(155, 120,120)',   // Area will be red above the origin
                below: 'rgb(115, 17, 222)'    // And blue below the origin
              }

            },
           
          ],
        }}
        height={400}
        width={400}
        options={{
          maintainAspectRatio: false,
          scales: {
            yAxes: [
              {
                ticks: {
                  beginAtZero: true,
                },
              },
            ],
          },
          legend: {
            labels: {
              fontSize: 35,
            },
          },
        }}
      />
      </div>
  )
}

export default LineChart