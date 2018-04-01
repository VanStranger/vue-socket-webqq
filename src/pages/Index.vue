<template>
  <div>
  <Search></Search>
  <div id="baohe" v-bind:style="{top:baoheTop,left:baoheLeft}">
    <div id="header">
      <div id="headerbg"></div>
      <div id="headercont">
        <div id="dragbox"></div>
        <h3>{{UserName}}<span class="zhuangtai icon-happy2"></span></h3>
        <p class="qianming" contenteditable=true>{{UserInfo}}</p>
      </div>
      <ul id="baohe-btns">
        <li class="ctrli"><a class="ctrbtn" href="###"><i class="iconfont">&#xf0122;</i></a></li>
        <li class="ctrli"><a class="ctrbtn" href="###"><i class="iconfont">&#xf018c;</i></a></li>
        <li class="ctrli"><a class="ctrbtn" href="###" v-on:click="logout"><i class="iconfont">&#xf01b0;</i></a></li>
      </ul>
    </div>
    <div id="search">
      <div id="searchbg"></div>
      <div id="searchcont">
        <input type="text" id="searchinput" placeholder ="搜索联系人，讨论组">
        <a href="###" id="searchbtn"><i class="icon-search"></i></a>
      </div>
    </div>
    <div id="mainbody">
      <div id="mainbodybg">
      </div>
      <div id="mainbodycont">
        <div id="navs">
          <ul class="clearfix">
            <li class="navli"><a class="nava" href="###"><i class="icon-user"></i></a></li>
            <li class="navli"><a class="nava" href="###"><i class="icon-bubbles2"></i></a></li>
          </ul>
        </div>
        <FriendsGroup :userid="UserID"></FriendsGroup>
      </div>
    </div>
  </div>
  <canvas id="xiuxiu"></canvas>
  <audio src="static/voice/voice1.wav" id="audio" ref="audio"></audio>
  <Talkbox></Talkbox>
  </div>
</template>

<script>
import vcookie from "vcookie";
import router from "../router/index.js"
import {mapState} from "vuex"
import Talkbox from  "../components/Talkbox.vue"
import Search from "../components/Search.vue"
import FriendsGroup from "../components/FriendsGroup.vue"
export default {
  name: 'Index',
  computed:{
    ...mapState([
        "ws",
      ]),
  },
  beforeMount(){
    this.UserID=vcookie.get("UserID");
    this.UserName=vcookie.get("UserName");
    this.Photo=vcookie.get("Photo");
    this.UserInfo=vcookie.get("UserInfo") || "请输入您的个性签名！";

    if(!this.UserID){
      router.push("/login");
    }else{
      this.$store.commit("setUser",{
        "id":this.UserID,
        "username":this.UserName,
        "photo":this.Photo,
        "userInfo":this.UserInfo,
      });
      var w=window.innerWidth|| document.documentElement.clientWidth|| document.body.clientWidth;
      var h=window.innerHeight|| document.documentElement.clientHeight|| document.body.clientHeight;
      var that=this;
      this.baoheLeft=w-330 +"px";
      let uid =this.UserID;
      if(!this.ws){
        (function connectws(){
            var ws = new WebSocket("ws://127.0.0.1:1234");
            ws.onopen=function(){
              ws.send(JSON.stringify({"type":"login","uid":uid}));
            }
            ws.onmessage=function(data){
              console.log(data);
              var obj=JSON.parse(data.data);
              if(obj.type=="newmessage"){
                that.$refs.audio.play();
                let create_time=Math.floor(new Date().getTime()/1000);
                that.$store.commit("addMessages",{"withid":obj.fromid,"type":"come","message":obj.message,"create_time":create_time,"readed":0})
              }
              ws.send("pong");
            }
            ws.onerror=function (){
              console.log("错误");
              setTimeout(function(){
                connectws();
              },3000);  
            };
            ws.onclose=function(){
              console.log("关闭");
              setTimeout(function(){
                connectws();
              },3000);
            }
            if(ws){
              that.$store.commit("setWs",ws);
            }
        })();
      }
    }

    
  },
  data () {
    return {
      "UserID":"",
      "UserName":"",
      "Photo":"",
      "UserInfo":"请输入您的个性签名！",
      baoheTop:"50px",
      baoheLeft:"0px",

      groups:[],
      friends:[],
    }
  },
  methods:{
    logout:function(){
      console.log("logout");
      vcookie.delete("UserName");
      vcookie.delete("UserID");
      this.UserName="";
      this.ws.close();
      this.$store.commit("setWs",0);
      // router.push("/login");
      window.location.reload();
    },
  },
  components:{
    Talkbox,FriendsGroup,Search
  }
}
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>
#baohe{
  width:280px;
  height:568px;
  background: url("/static/img/bbg2.jpg");
  background-size: cover;
  position: absolute;
  top:50px;
}
#baohe-btns{
  position: absolute;
  top:0;
  right: 0;
}
#header{
  height:136px;
  position: relative;
}
#headerbg{
  width:100%;
  height:100%;
  position: absolute;
  top:0;
  left: 0;
  background: #000;
  -moz-opacity:0.2;
  filter:alpha(opacity=20);
  opacity:.20;
}
#headercont{
  position: relative;
}
#header #dragbox{
  width:100%;
  height:35px;
  background: rgba(255,255,255,0.3);
}
#header h3{
  padding: 5px 0 0 10px;
  color:#fff;
  font-size: 20px;
}
.zhuangtai.icon-happy2{
  color: rgb(167, 255, 0);
  font-size: 16px;
  vertical-align: bottom;
  margin-left: 5px;
}
.qianming{
  margin-left: 10px;
  color:#fff;
}
#search{
  height:30px;
  width:100%;
  position: relative;
}
#searchbg{
  position: absolute;
  width:100%;
  height:30px;
  left: 0;
  top: 0;
  background: #000;
  -moz-opacity:0.6;
    filter:alpha(opacity=60);
    opacity:.60;
}
#searchcont{
  position: relative;
}
#searchinput{
  background: transparent;
  width: 250px;
  height:30px;
  border:none;
  outline: none;
  float: left;
  color: #bbb9b9;
  padding-left: 10px;
}
#searchbtn{
  line-height: 30px;
  float: left;
  color:#fff;
}
#mainbody{
  position: relative;
  height: 342px;
}
#mainbodybg{
  position: absolute;
  width:100%;
  height:342px;
  left: 0;
  top: 0;
  background: #fff;
  -moz-opacity:0.6;
    filter:alpha(opacity=60);
    opacity:.60;
}
#mainbodycont{
  position: relative;
  height:342px;
}
#navs{
  height:30px;
  border-bottom: 1px solid #A9A7A7;
}
.navli{
  float: left;
  font-size: 20px;
  line-height: 30px;
}
.nava{
  display: block;
  margin:0px 10px;
}
.nava [class^="icon-"], [class*=" icon-"]{
  color: #757575;
}
#friends{
  overflow-y:auto;
  height: 311px;
}

/*friendsgroup.vue*/


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



.anotherphoto{
    float:left;
    display: block;
    width:25px;
    height:25px;
    margin-right: 10px;
  }
  .saymessage{
    float: left;
    background: #F7E4F7;
    padding: 5px;
    border-radius: 15px;
    max-width: 280px;
  }
  .saytime{
    float: left;
    font-size: 12px;
    line-height: 35px;
    margin-left: 5px;
  }
  .myphoto{
    float:right;
    display: block;
    width:25px;
    height:25px;
    margin-left: 10px;
  }
  .replytime{
    float:right;
    font-size:12px;
    line-height: 35px;
    margin-right: 5px;
  }
  .replymessage{
    float:right;
    background: #F1F2D0;
    padding: 5px;
    border-radius: 15px;
    max-width: 308px;
  }
  .message{
    clear:both;
    overflow: hidden;
    padding:5px;
  }
</style>
