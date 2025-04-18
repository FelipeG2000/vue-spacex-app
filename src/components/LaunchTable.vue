<template>
    <div>
      <h2>Launches Table</h2>
      <table>
        <thead>
          <tr>
            <th>Mission</th>
            <th>Date</th>
            <th>Rocket</th>
            <th>Status</th>
          </tr>
        </thead>
        <tbody>
          <tr v-for="launch in launches" :key="launch.launch_id">
            <td>{{ launch.mission_name }}</td>
            <td>{{ launch.launch_date }}</td>
            <td>{{ launch.rocket_name }}</td>
            <td>{{ launch.status }}</td>
          </tr>
        </tbody>
      </table>
    </div>
  </template>
  
  <script setup>
  defineProps({
    launches: Array
  });
  </script>
  
  <style scoped>
  table {
    border-collapse: collapse;
    width: 100%;
  }
  th, td {
    border: 1px solid #ccc;
    padding: 0.5rem;
  }
  </style>
  