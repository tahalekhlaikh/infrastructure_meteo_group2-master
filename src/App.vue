<template>
  <v-app id="inspire">
  

    <v-app-bar
      absolute
      color=blue
      dark
      shrink-on-scroll
      prominent
      fade-img-on-scroll
      scroll-target="#scrolling-techniques-5"
      scroll-threshold="500"
    >
      <!--<template v-slot:img="{ props }">
        <v-img
          v-bind="props"
          gradient="to top right, rgba(55,236,186,.7), rgba(25,32,72,.7)"
        ></v-img>
      </template>-->
      
    
      <img class="ml-3" src="/image/Cloud-Sun-256.png" width="50" height="50" alt="logo"/>

      <v-app-bar-title>ICD Météo</v-app-bar-title>

      
    </v-app-bar>
  


    <v-main class="bg-grey-lighten-3">
      <v-container>
        <v-row>
          <v-col class="px-10 py-10"
            cols="12"
            sm="8"
            
          >
            <v-sheet class="pa-10"
              rounded="lg"
            >            

              <h2 class="color-blue">
                Ville
              </h2>
              <v-divider thickness="2px" color="blue" class="mb-5"></v-divider>
              <VilleFormVue />

              <h2 class="color-blue mt-5">
                Echeance
              </h2>
              <v-divider thickness="2px" color="blue" class="mb-5"></v-divider>
              <EcheanceFormVue />
              
              <v-row class="justify-end ma-0">
                <v-btn class="ma-3" @click="validateForm()" prepend-icon="mdi-check-bold" color="green">Valider</v-btn>
              </v-row>
              <!--<v-alert
                v-model="alert"
                border="left"
                close-text="Fermer"
                color="red"
                dark
                dismissible
                > Veuillez selectionner une ville
              </v-alert>-->
              

            </v-sheet>
          </v-col>

          <v-col class="px-10 py-10"
            cols="12"
            sm="4"
          >
            <v-sheet
              rounded="lg"
            >
           
            <!-- debut Barre de test-->    
           
            <!-- Fin Barre de test -->
            
            <v-card
                class="pa-5"
              >
                <v-list-item two-line>
                  <v-list-item-content>
                    <v-list-item-title class="text-h3">
                      {{data_store.city_selected}}
                    </v-list-item-title>
                    <v-list-item-subtitle class="font-weight-bold">
                      <span>{{data_store.date_selected_string}}</span><br /> 
                      <span>{{data_store.time_selected.substring(0,2)}} heures</span>
                    </v-list-item-subtitle>
                  </v-list-item-content>
                </v-list-item>

                <v-card-text>
                  <v-row>
                    <v-col
                      class="text-h2"
                      cols="6"
                    >
                      <h6>{{data_store.temp_meteo_round}} &deg;C</h6>
                    </v-col>
              
                    <v-col cols="6" v-if="(data_store.rain_meteo > 1)">
                      <v-img
                        
                        src="/image/pluvieux.png"
                        alt="pluvieux"
                        width="92"
                      ></v-img>
                      
                    </v-col>
                    <v-col cols="6" v-else-if="(data_store.temp_meteo_round>20)">
                      <v-img
                        
                        src="/image/soleil.png"
                        alt="Ensoleillé"
                        width="92"
                      ></v-img>
                      
                    </v-col>
                    
                    <v-col cols="6" v-else-if="(data_store.temp_meteo_round>9 && data_store.temp_meteo_round<20)">
                      <v-img
                        
                        src="/image/ciel-clair.png"
                        alt="nuageux et Ensoleillé"
                        width="92"
                      ></v-img>
                      
                    </v-col>
                    <v-col cols="6" v-else>
                      <v-img
                        
                        src="/image/nuage.png"
                        alt="nuageux"
                        width="92"
                      ></v-img>
                      
                    </v-col>
                  </v-row>
                </v-card-text>
                
                <v-list-item density="compact" prepend-icon="mdi-weather-windy">
                  <v-list-item-subtitle class="font-weight-bold">Vent {{ data_store.wind_meteo_convert }} km/h</v-list-item-subtitle>
                </v-list-item>
                <v-list-item density="compact" prepend-icon="mdi-weather-windy">
                  <v-list-item-subtitle class="font-weight-bold">Vent {{ data_store.wind_meteo_noeud }} Noeuds</v-list-item-subtitle>
                </v-list-item>
                <v-list-item density="compact" prepend-icon="mdi-weather-rainy">
                  <v-list-item-subtitle class="font-weight-bold">Précipitation {{data_store.rain_meteo}} mm</v-list-item-subtitle>
                </v-list-item>
                <v-list-item density="compact" prepend-icon="mdi-weather-rainy">
                  <v-list-item-subtitle class="font-weight-bold">Probabilité de précipitation {{data_store.rain_percent_convert}} %</v-list-item-subtitle>
                </v-list-item>


                <ResultatMeteo />
                <AudioLoad />

               
              </v-card>
              




            <!-- fin --> 





            </v-sheet>
          </v-col>
        </v-row>
      </v-container>
    </v-main>
    <v-footer
    class="bg-indigo-lighten-1 text-center d-flex flex-column" color="blue"
  >
    
 
    
    

    <v-divider></v-divider>

    <div>
       <strong> &copy; Copyright  {{ new Date().getFullYear() }} - MS ICD</strong>
    </div>
  </v-footer>
  </v-app>
  
</template>

<script setup>

import { ref } from "vue"
import VilleFormVue from "@/components/VilleForm.vue"
import EcheanceFormVue from "@/components/EcheanceForm.vue"
import ResultatMeteo from "@/components/ResultatMeteo.vue"
import AudioLoad from "@/components/AudioLoad.vue"

import { meteoStore } from "@/stores"
const data_store = meteoStore()
//const alert = ref(false)
function validateForm(){
  if(data_store.city){
    data_store.validate += 1;
    //alert.value = false;
  } else{
    //alert.value = true;
    alert("Veuillez selectionner une ville");
  }
}

</script>

<style scoped>
.color-blue {
    color: #2196F3 !important;
}
.bg-blue {
    background-color: #2196F3 !important;
    color: #FFFFFF !important;
}
</style>