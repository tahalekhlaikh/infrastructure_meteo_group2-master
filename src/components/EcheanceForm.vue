<template>
    <v-row class="ma-0  align-center">
      <!-- Affichage de la date -->
      <v-text-field class="ma-3" type="date" label="Entrer une date" 
      v-model="date_selected" :min="date_min" :max="date_max"></v-text-field>   
      
      <!-- Affichage de l'heure -->
      <v-autocomplete class="ma-3" 
      label="Entrer une heure" v-model="time_selected"
      :items="['00:00', '01:00', '02:00', '03:00', '04:00', '05:00', '06:00',
      '07:00', '08:00', '09:00', '10:00', '11:00', '12:00', '13:00',
      '14:00', '15:00', '16:00', '17:00', '18:00', '19:00', '20:00', '21:00',
      '22:00', '23:00']"
      ></v-autocomplete>
    </v-row> 
</template>
  
<script setup>
import { ref, watch } from "vue";
import { meteoStore } from "@/stores";

// gérer la date et l'heure actuelles
const now = new Date();

const annee   = now.getFullYear();
const mois    = ('0'+now.getMonth()+2).slice(-2);
const jour    = ('0'+now.getDate()   ).slice(-2);
const heure   = ('0'+now.getHours()  ).slice(-2);
const minute  = "00";

// variables contenant respectivement les valeurs de la date et de l'heure
const date_selected = ref(annee+"-"+mois+"-"+jour);
const time_selected = ref(heure+":"+minute);

// gestion de la date minimale (date du jour)
const date_min = ref(annee+"-"+mois+"-"+jour);

// gestion de la date maximale (J+5 date du jour)
const set_new_date = new Date(); 
set_new_date.setDate(set_new_date.getDate() + 4);

const jour_max = set_new_date.getDate();
const mois_max = set_new_date.getMonth() + 1;
const annee_max = set_new_date.getFullYear();

const date_max = ref(annee_max+"-"+mois_max+"-"+jour_max);

// gestion de l'accès des variables par d'autres composants
var data_store = meteoStore();
data_store.date_selected = date_selected;
data_store.time_selected = time_selected;


// Gestion des previsions en fonction de l'evenement de variation de date et heure

watch(() => (data_store.validate, data_store.forecast) , () => { updateWeather() } );
watch(() => [data_store.time_selected, data_store.date_selected] , () => { updateWeather() } );

function updateWeather(){
  if(data_store.validate > 0) {
    const time_pick = data_store.time_selected.substring(0,2);
    var next_time_slot = "";
    const step = ["00", "03", "06", "09", "12", "15", "18", "21"];

    for(let i=0; i<8; i++){
      let a = parseInt(time_pick);
      let b = parseInt(step[i]);
      if(a <= b) {
        next_time_slot = step[i];
        break;
      } else if(a > 21){
        next_time_slot = 21;
        break;
      }
    }

    const next_date_slot = data_store.date_selected + " " + next_time_slot + ":00:00";
    
    try {
      var forecast_slot = getMatchWeather(next_date_slot) ;
      data_store.temp_meteo = forecast_slot.main.temp ;
      data_store.rain_meteo = forecast_slot.rain ? forecast_slot.rain['3h'] : 0 ;
      data_store.rain_percent = forecast_slot.pop ;
      data_store.wind_meteo = forecast_slot.wind.speed ;

      // Mise à jour de l'increment pour déclencher la lecture des audios
      data_store.trigger_audio += 1;
    }
    catch(e){
      alert("Aucunes données météo pour ce créneau");
    }
    
  }
}

function getMatchWeather(date_slot){
  for (let i=0; i<40; i++){
    if(date_slot == data_store.forecast[i].dt_txt){
      return data_store.forecast[i];
    }
  }
}



</script>