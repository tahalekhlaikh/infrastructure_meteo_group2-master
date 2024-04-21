
​​​​​<template>

</template>
     
    <script setup>
    import { ref, watch } from "vue"
    import { meteoStore } from "@/stores"
    var data_store = meteoStore()
    
    watch(() => data_store.validate, () => {
        getWeather();
        /*
        if(data_store.city == data_store.city_selected){
            alert("Veuillez selectionner une nouvelle ville valide avant de soumettre votre requête");
        } else{
            
        }*/
    } )

    async function getWeather(){
        
        const key="dc8ba83dd82b929ceb943b6c48229f1b";
        const baseURL='https://api.openweathermap.org/data/2.5/forecast?lat='+ data_store.lat +'&lon='+ data_store.lon +'&appid='+ key +'&units=metric';
        const response= await fetch(baseURL);
        const data = await response.json();
        data_store.forecast = data.list;
        data_store.city_selected = data_store.city;
       
    }  
    
    </script>
