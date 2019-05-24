// EventTable.vue

<template>
  <vuetable ref="vuetable"
    api-url="http://localhost:3600/events"
    pagination-path=""
    data-path="event_data"
    :fields="['uuid', 'recorded_at', 'message']"
  ></vuetable>
</template>

<script>


import Vuetable from 'vuetable-2/src/components/Vuetable'

export default {
  components: {
    Vuetable
  },
  methods: {
    transform: function transform(data) {

      var transformed = {}

      transformed.event_data = []

      for (var i=0; i < data.length; i++) {
        transformed.event_data.push({
          recorded_at: data[i].recorded_at,
          uuid: data[i].uuid,
          message: data[i].message,
        })
      }

      return transformed

    }
  }

};
</script>