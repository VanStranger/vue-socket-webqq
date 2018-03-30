<template>
  <div id="app" @mouseup="stopDrag">
    <router-view/>
  </div>
</template>

<script>
export default {
  name: 'App',
  methods:{
    stopDrag:function(){
        // this.$store.commit("setDraging",0);
        // console.log(this.$store);
    }
  }
}
</script>

<style scoped>
#app {
  width:100%;
  height: 100%;
}
</style>
