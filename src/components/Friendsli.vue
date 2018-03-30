<template>
    <li class="friendli" @click="addtalkto">
        <div class="friendlibg"></div>
        <div class="friendlicont">
            <div class="friendpho">
                <img :src='"/static/img/" + friend.photo ' alt="" class="friendphoimg">
                <span class="friendnewsnum">0</span>
            </div>
            <p class="friendname">{{friend.username}}</p>
            <p class="friendinfo">{{friend.userinfo}}</p>
        </div>
    </li>
</template>
<script>
    export default {
        name:"Friendsli",
        props:['friend'],
        data(){
            return {
                userid:0,
                photo:"",
                username:"",
                userinfo:""
            }
        },
        methods:{
            addtalkto:function(){
                this.$store.commit("addtalkto",this.friend);
                console.log(this.$store);
                console.log(this.$store.getters.talkto);
            },
        }
    }
</script>
<style scoped>
.friendli{
    height: 56px;
    border-bottom: 1px solid #E8E6E6;
    overflow: hidden;
    position: relative;
}
.friendlibg{
    position: absolute;
    width:100%;
    height:100%;
    left: 0;
    top: 0;
    background: #fff;
    -moz-opacity:0.0;
    filter:alpha(opacity=00);
    opacity:.00;
    z-index: 1;
}
.friendlibg:hover{
    -moz-opacity:0.6;
    filter:alpha(opacity=60);
    opacity:.60;
}
.friendlicont{
    position: relative;
}
.friendli:first-child{
    border-top: 1px solid #E8E6E6;
}
.friendpho{
    width:40px;
    height:40px;
    -moz-border-radius: 5px;
    -webkit-border-radius: 5px;
    border-radius: 5px;
    float: left;
    margin: 8px 10px;
    position: relative;
    overflow:hidden;
}
.friendphoimg{
    display:block;
    width:100%;
    height:100%;
}
.friendnewsnum{
    display:block;
    width:14px;
    height:14px;
    color:#fff;
    background:orange;
    text-align:center;
    font-size:10px;
    line-height:14px;
    position:absolute;
    right:2px;
    bottom:2px;
}
.friendname {
    font-size: 14px;
    padding-top: 10px;
    line-height: 18px;
}
.friendinfo {
    font-size: 12px;
    color: #666;
    line-height: 28px;
}
</style>