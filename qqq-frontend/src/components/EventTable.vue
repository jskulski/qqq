// EventTable.vue

<template>
  <vuetable ref="vuetable"
    api-url="http://localhost:3600/events"
    pagination-path=""
    data-path="mydata"
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
      console.log(arguments);

        var transformed = {}

        // transformed.pagination = {
        //   total: data.total,
        //   per_page: data.per_page,
        //   current_page: data.current_page,
        //   last_page: data.last_page,
        //   next_page_url: data.next_page_url,
        //   prev_page_url: data.prev_page_url,
        //   from: data.from,
        //   to: data.to
        // }

      transformed.mydata = []

      for (var i=0; i < data.length; i++) {
        transformed.mydata.push({
          // id: data[i].id,
          recorded_at: data[i].recorded_at,
          uuid: data[i].uuid,
          message: data[i].message,
          // created_at: data[i].created_at,
          // updated_at: data[i].updated_at,
        })
      }

      return transformed

    }
  }

};
</script>