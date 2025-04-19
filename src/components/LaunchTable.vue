<template>
  <div>
    <h2 class="text-center my-4">Launches Table</h2>
    <div class="container">
      <div class="header row fw-bold text-white bg-dark text-center py-2 py-md-0">
        <div class="col-12 col-md-4 py-2 border border-white text-break">Mission</div>
        <div class="col-6 col-md-2 py-2 border border-white text-break">Date</div>
        <div class="col-6 col-md-2 py-2 border border-white text-break">Rocket</div>
        <div class="col-6 col-md-2 py-2 border border-white text-break">Launchpad name</div>
        <div class="col-6 col-md-2 py-2 border border-white text-break">Status</div>
      </div>
      <div class="row text-center py-2 py-md-0" v-for="launch in launches" :key="launch.launch_id">
        <div class="col-12 mission-name col-md-4 border text-break">
          <img :src="launch.patch_image" style="max-width: 1rem;" v-if="launch.patch_image != 'N/A'">
          <component :is="launch.webcast == 'N/A' ? 'span': 'a'" :href="launch.webcast" target="_blank" class="webcast">
            &nbsp;{{ launch.mission_name }}
          </component>
        </div>
        <div class="col-6 col-md-2 border text-break">{{ formatDate(launch.launch_date) }}</div>
        <div class="col-6 col-md-2 border text-break">{{ launch.rocket_name }}</div>
        <div class="col-6 col-md-2 border text-break">{{ launch.launchpad_name }}</div>
        <div class="col-6 col-md-2 border text-break">
          <div :style="{backgroundColor: getStatusColor(launch.status)}" class="status-dot"></div>
          &nbsp;{{ launch.status }}
        </div>
      </div>
    </div>
  </div>
</template>
<script setup>
  defineProps({
    launches: Array
  });
  const formatDate = (dateString) => {
    const options = { year: 'numeric', month: 'long', day: 'numeric' };
    return new Date(dateString).toLocaleDateString('es-ES', options);
  }
  const getStatusColor = (status) => {
    switch (status) {
      case 'success':
        return 'green';
      case 'failed': 
        return 'red';
      case 'upcoming':
        return 'yellow'
      default:
        return "white";
    }
  }
</script>
<style scoped>
  a {
    text-decoration: none;
    color: #ccc;
  }
  a:hover {
    color: rgb(0, 0, 255);
  }
  .text-break {
    word-break: break-word;
    overflow-wrap: break-word;
  }
  @media (min-width: 1200px) {
    .header {
        z-index: 1;
        position: sticky;
        top: 0;
    }
  }
  @media (max-width: 576px) {
    .mission-name {
        position: sticky;
        top: 0;
        background-color: #212529;
    }
  }
  [class^="col-"] {
    height: 3rem;
    display: flex;
    align-items: center;
    justify-content: center;
  }
  .status-dot{
      width: 10px;
      height: 10px;
      border-radius: 50%;
    }
</style>
