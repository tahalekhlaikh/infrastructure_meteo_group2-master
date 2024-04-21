<template>
    <v-card text="Ville">

        
        <v-btn v-on:click="getLocation()">
            Geoloc
        </v-btn>
        <v-btn v-on:click="getCitiesList()">
            Liste des villes
        </v-btn>

       

        <v-sheet class="my-3"
              rounded="lg"
            >
            latitude = {{lat}}
            longitude = {{lon}}
            
            Ville = {{city_selected}} 

            
            
            
        </v-sheet>
        <v-sheet>
            <!--
            <v-list lines="one">
                <v-list-item
                    v-for="country in countries"
                    :key="country.name"
                    :title="country.name"
                    subtitle="Liste de ville"
                ></v-list-item>
            </v-list>
            -->
            Affichage de ville ci-dessus {{}}
        </v-sheet>
        
        <v-autocomplete
            v-model="city_selected"
            :items="cities_fr"
            label="Ville"
        ></v-autocomplete>
        
            

    </v-card>
 
</template>

<script setup>
// Required libraries and arrays
import { ref, computed } from "vue";
//import countries from '@/data/countries.json';
//import type { SearchVilleParams } from '~types';
import cities from 'cities.json';
import villes from '@/data/cities.json';
import { meteoStore } from "@/stores";

const data_store = meteoStore();

// Variables
const lat = ref(null);
const lon = ref(null);
//const city_selected = ref("");
let city_selected = ref('');
const cityList = [];
const cities_fr = ref([]);

// Country and cities
const searchCountries = computed(() => {
  if (searchTerm.value === '') {
    return []
  }

  let matches = 0

  return countries.filter(country => {
    if (
      country.name.toLowerCase().includes(searchTerm.value.toLowerCase())
      && matches < 30
    ) {
      matches++
      return country
    }
  })
});

// Geolocation functions
function getLocation(){
    var options = {
    enableHighAccuracy: true,
    timeout: 5000,
    maximumAge: 0
    };

    function success(pos) {
    var crd = pos.coords;

    console.log('Votre position actuelle est :');
    console.log(`Latitude : ${crd.latitude}`);
    console.log(`Longitude : ${crd.longitude}`);
    console.log(`La précision est de ${crd.accuracy} mètres.`);

    lat.value = crd.latitude;
    lon.value = crd.longitude;

    data_store.lat = lat.value;
    data_store.lon = lon.value;

    }

    function error(err) {
    console.warn(`ERREUR (${err.code}): ${err.message}`);
    }

    navigator.geolocation.getCurrentPosition(success, error, options);
}

/*
function getCountriesList(val){
    'use strict';
    for (const [key, value] of Object.entries(countries)) {
        console.log(key, value['name']);
        if(value['name'])
                myList+=value['name']+',';
    }
    return myList;
}*/

function getCountriesList(val) {
    
    Object.keys(countries).forEach(function(key) {
        //console.log(key, countries[key]);
        //console.log(key, countries[key]['name']);
        let listOfObjects = Object.values(countries[key]['name']);
        console.log(listOfObjects);

    });
    //let listOfObjects = Object.keys(countries);
    //let listOfObjects2 = Object.values(countries);
    //console.log(listOfObjects2[0]);
}

function getCityList() {
    //console.log(villes[2]['country']);
    //console.log(villes[2]['name']);

    'use strict';
    //let maList = [];
    for (const [key, value] of Object.entries(villes)) {
        if ((value['country'])==="ZW"){
            cityList.push(value['name']);
            //console.log(value['name'], value['country']);
        }

    }
    //console.log(cityList);

    
}

//getCityList();


//import { Country, State, City }  from 'country-state-city';
//console.log(Country.getAllCountries())
//console.log(City.getAllCities())



async function fetchCities() {
  const response = await fetch('https://geo.api.gouv.fr/departements/78/communes')
  const cit = await response.json()
  //cities_fr.value = cit

  for (const [key, value] of Object.entries(cit)) {
        /*if ((value['country'])==="ZW"){
            cityList.push(value['name']);
            //console.log(value['name'], value['country']);
        }*/
        //console.log(value['nom']);
        cities_fr.value.push(value['nom']);

    }

}
fetchCities();




</script>