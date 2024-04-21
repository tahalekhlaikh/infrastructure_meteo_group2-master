import { defineStore } from 'pinia'
const options = { weekday: 'long', year: 'numeric', month: 'long', day: 'numeric'};
// le 1er argument est un identifiant unique entre tous les stores de l'application
export const meteoStore = defineStore('meteo', {
  state: () => {
    return {
        city_selected : "--",
        lat : 0,
        lon: 0,
        date_selected: "",
        time_selected: "00:00",
        temp_meteo: "0",
        rain_meteo: "0",
        rain_percent: "0",
        wind_meteo: "0",
        forecast: "",
        validate: 0,
        trigger_audio: 0,
        city: null
    }
  },
  getters: {
    temp_meteo_round : (state) => Math.round(state.temp_meteo),
    wind_meteo_convert : (state) => Math.round(state.wind_meteo * 3.6),
    rain_percent_convert : (state) => Math.round(state.rain_percent * 100),
    date_selected_string : (state) => new Date(state.date_selected).toLocaleString("fr-FR", options),
    wind_meteo_noeud : (state) => Math.round(state.wind_meteo * 1.94384)
  },
  actions: {
  },
})