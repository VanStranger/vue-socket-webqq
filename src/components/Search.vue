<template>
  <div class="search">
      <div class="search_header">
        <ul class="search_navs center">
          <li class="search_nav active">搜号码</li><span class="lispan"></span>
          <li class="search_nav">搜昵称</li><span class="lispan"></span>
          <li class="search_nav">搜标签</li>
        </ul>
      </div>
      <div class="search_content">
        
      </div>
  </div>
</template>
<script>
    export default {
        name:"Search",
        props:[],
        data(){
          return {
            
          }
        },
        methods:{
          
        },
        beforeMount(){
          
        },
        components:{

        }
    }
</script>
<style scoped lang="scss">
  .search{
    position: fixed;
    top:150px;
    bottom:150px;
    width:80%;
    left:0;
    right:0;
    border:1px solid #eee;
    background: #fff;
    z-index: 2;
    margin:0 auto;
  }
  .search_header{
    height:66px;
    background: #009BDB;
      .search_navs{
        padding-top: 26px;
      }
      .search_nav{
        display: inline-block;
        font-size: 16px;
        padding:0 33px;
        color:#fff;
        vertical-align: middle;
        &.active{
          font-weight: bold;
        }
      }
      .lispan{
        content:"";
        display: inline-block;
        border-right:1px solid #fff;
        width:1px;
        height:12px;
        vertical-align: middle;
      }
  }
</style>