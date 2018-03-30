import Vue from 'vue'
import Router from 'vue-router'
import Index from '@/pages/Index'
import Login from '@/pages/Login'

Vue.use(Router)

const router = new Router({
  routes: [
    {
      path: '/',
      name: 'Index',
      component: Index,
      meta:{
        title:"首页",
      }
    },
    {
      path: '/login',
      name: 'Login',
      component: Login,
      meta:{
        title:"登录页",
      }
    },
   
  ],
  
})
router.afterEach((to,from,next)=>{
    if(to.meta.title){
      document.title=to.meta.title;
    }
  })
export default router;
