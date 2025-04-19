<template>
  <div class="my-5">
    <h1 class="text-center">🚀 SpaceX Launches Dashboard</h1>
    <div class="text-center" v-if="loading">Cargando datos...</div>
    <div v-else-if="errorMessage">{{ errorMessage }}</div>
    <div v-else>
      <LaunchTable :launches="launches" />
      <StatusChart style="width: 90vw;" class="mx-auto" :launches="launches" />
    </div>
  </div>
</template>
<script setup>
import { ref, onMounted } from 'vue'
import LaunchTable from './components/LaunchTable.vue'
import StatusChart from './components/StatusChart.vue'
const launches = ref([])
const loading = ref(true)
const errorMessage = ref('')
onMounted(async () => {
  try {
    const res = await fetch(`${import.meta.env.VITE_API_URL}/launches`)
    if (!res.ok) {
      throw new Error('No se pudieron cargar los datos. Intenta más tarde.')
    }
    const data = await res.json()
    launches.value = data
  } catch (error) {
    console.error(error)
    errorMessage.value = error.message
  } finally {
    loading.value = false
  }
})
</script>