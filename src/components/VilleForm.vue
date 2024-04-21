<template>
  <v-row class="ma-0 align-center">
      <v-btn class="ma-3" color="blue" @click="$refs.address.geolocate()" prepend-icon="mdi-map-marker" alt="Géolocalisation">Géolocalisation</v-btn>
      
      <vue-google-autocomplete 
          
          id="map" 
          ref="address"
          classname="form-control border ma-3 pa-2" 
          placeholder="Saisir une ville" 
          v-on:placechanged="getAddressData"
          types="(cities)"
          
      >    
      </vue-google-autocomplete>
  </v-row>
</template>

<script setup>
// Required libraries and arrays
import { ref } from "vue";
import { meteoStore } from "@/stores";
import VueGoogleAutocomplete from "vue-google-autocomplete";

const data_store = meteoStore();

//
function getAddressData(addressData, placeResultData, id) {
  data_store.city = addressData.locality;
  data_store.lat = addressData.latitude;
  data_store.lon = addressData.longitude;
}

</script>