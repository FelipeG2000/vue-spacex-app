<template>
    <div>
      <h2>Launch Status Distribution</h2>
      <Bar :data="chartData" :options="chartOptions" />
    </div>
  </template>
  
  <script setup>
  import { Bar } from 'vue-chartjs'
  import {
    Chart as ChartJS,
    Title,
    Tooltip,
    Legend,
    BarElement,
    CategoryScale,
    LinearScale,
  } from 'chart.js'
  
  ChartJS.register(Title, Tooltip, Legend, BarElement, CategoryScale, LinearScale)
  
  const { launches } = defineProps({
  launches: {
    type: Array,
    default: () => []
  }
})
  
  const statusCount = { success: 0, failed: 0, upcoming: 0 }
  for (const launch of launches) {
    if (statusCount[launch.status] !== undefined) {
      statusCount[launch.status]++
    }
  }
  
  const chartData = {
    labels: ['Success', 'Failed', 'Upcoming'],
    datasets: [
      {
        label: 'Launches',
        data: [statusCount.success, statusCount.failed, statusCount.upcoming],
        backgroundColor: ['#4CAF50', '#F44336', '#FFC107']
      }
    ]
  }
  
  const chartOptions = {
    responsive: true,
    plugins: {
      legend: { position: 'top' },
      title: { display: true, text: 'Launch Statuses' }
    }
  }
  </script>
  