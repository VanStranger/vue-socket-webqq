import Vue from 'vue'
import Vuex from 'vuex'

import getters from "./getters.js"
import {mutations,actions} from "./actions.js"
Vue.use(Vuex)

var store=new Vuex.Store({
    state:{
        user:null,
        talktos:[],
        talktoid:0,
        draging:0,
        ws:0,
        messages:{},
        ceshiobj:{},
    },
    mutations,actions,
    getters:getters
})
export default store;