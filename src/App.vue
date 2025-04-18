<template>
  <div>
    <h1>🚀 SpaceX Launches Dashboard</h1>

    <div v-if="loading">Cargando datos...</div>
    <div v-else>
      <LaunchTable :launches="launches" />
      <StatusChart :launches="launches" />
    </div>
  </div>
</template>

<script setup>
import { ref, onMounted } from 'vue'
import LaunchTable from './components/LaunchTable.vue'
import StatusChart from './components/StatusChart.vue'

const launches = ref([])
const loading = ref(true)

onMounted(async () => {
  try {
    const res = await fetch("https://19azuh2l80.execute-api.us-east-1.amazonaws.com/launches")
    const data = await res.json()
    console.log("✅ Datos recibidos:", data)
    launches.value = data
  } catch (e) {
    console.error("❌ Error al cargar datos:", e)
  } finally {
    loading.value = false
  }
})
</script>
