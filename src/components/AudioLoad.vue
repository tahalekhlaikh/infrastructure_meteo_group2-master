<template>
    <!-- Audio-->
    <v-row justify="center" class="my-3">
        <v-btn @click="changeStart()" v-show="onValid" color="red">{{ audio_btn }}</v-btn>
        <audio id="pluie" loop :src="audio_pluie"></audio>
        <audio id="vent" loop :src="audio_vent"></audio>
        <audio id="temp" loop :src="audio_temp"></audio>
    </v-row> 
    <!---->
</template>

<script setup>
import { ref, watch } from "vue"
import { meteoStore } from "@/stores"
const data_store = meteoStore()

// Audios
const isStart = ref(false);
const audio_pluie = ref(null);
const audio_vent = ref(null);
const audio_temp = ref(null);
const onValid = ref(false);
const audio_btn = ref("");

watch(() => data_store.trigger_audio , () => { updateAudio() } );

const pluie_rose = "/audio/pluie_rose.mp3";
const pluie_faible = "/audio/pluie_faible.mp3";
const pluie_moyenne = "/audio/pluie_moyenne.mp3";
const pluie_forte = "/audio/Pluie-forte.mp3";

const vent_faible = "/audio/ventFaible.mp3";
const vent_moyen = "/audio/ventMoyen.mp3";
const vent_fort = "/audio/ventFort.mp3";

const temperature_faible = "/audio/temperature-basse.mp3";
const temperature_moyenne = "/audio/temperature-moyenne.mp3";
const temperature_haute = "/audio/temperature-haute.mp3";

function updateAudio(){

  //Definition de la condition d'affichage du bouton
  if (data_store.validate > 0) {
    onValid.value = true;
  }
  //Definition des sons de température
  if (data_store.temp_meteo_round < 9){
    audio_temp.value = null;
  } else if (data_store.temp_meteo_round >= 9 && data_store.temp_meteo_round <= 20 ){
    audio_temp.value = temperature_faible;
  } else if (data_store.temp_meteo_round > 20 && data_store.temp_meteo_round < 30){
    audio_temp.value = temperature_moyenne;
  } else {
    audio_temp.value = temperature_haute;
  }

  //Definition des sons de pluie
  // AJouter un son de pluie entre 0 et 1 mm
  if (data_store.rain_meteo == 0){
    audio_pluie.value = null;
  } else if(data_store.rain_meteo > 0 && data_store.rain_meteo <= 1){
    audio_pluie.value = pluie_rose;
  } else if(data_store.rain_meteo > 1 && data_store.rain_meteo <= 3){
    audio_pluie.value = pluie_faible;
  } else if(data_store.rain_meteo > 3 && data_store.rain_meteo <= 5){
    audio_pluie.value = pluie_moyenne;
  } else {
    audio_pluie.value = pluie_forte;
  }

  //Definition des sons de vent
  if (data_store.wind_meteo_convert <= 9){
    audio_vent.value = null;
  } else if(data_store.wind_meteo_convert > 9 && data_store.wind_meteo_convert <= 20){
    audio_vent.value = vent_faible;
  } else if(data_store.wind_meteo_convert > 20 && data_store.wind_meteo_convert < 40 ){
    audio_vent.value = vent_moyen;
  } else{
    audio_vent.value = vent_fort;
  }

  isStart.value = false;
  changeStart();
}

function startPlay() {
  let pluie_html = document.querySelector("#pluie");
  let vent_html = document.querySelector("#vent");
  let temp_html = document.querySelector("#temp");
  if(audio_pluie) { setTimeout(function() {pluie_html.play()}, 500);}
  if(audio_vent) { setTimeout(function() {vent_html.play()}, 500); }
  if(audio_temp) { setTimeout(function() {temp_html.play()}, 500); }
  audio_btn.value = "MUTE";
}

function stopPlay() {
  let pluie_html = document.querySelector("#pluie");
  let vent_html = document.querySelector("#vent");
  let temp_html = document.querySelector("#temp");
  //if(audio_pluie) { setTimeout(function() {document.querySelector("#pluie").pause()}, 100);}
  //if(audio_vent) { setTimeout(function() {document.querySelector("#vent").pause()}, 200); }
  //if(audio_temp) { setTimeout(function() {document.querySelector("#temp").pause()}, 300); }
  if(pluie_html.play() !== undefined){ pluie_html.play().then(_ => { pluie_html.pause() })};
  if(vent_html.play() !== undefined){ vent_html.play().then(_ => { vent_html.pause() })};
  if(temp_html.play() !== undefined){ temp_html.play().then(_ => { temp_html.pause() })};
  audio_btn.value = "PLAY";
}

function changeStart() {
  isStart.value = !isStart.value;
  if (isStart.value == true) {
    startPlay();
  } else {
    stopPlay();
  }
}

</script>