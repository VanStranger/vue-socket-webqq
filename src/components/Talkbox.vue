<template>
  <div id="box" v-bind:class="{none:!talktos.length}">
    <div id="emoji"></div>
    <div id="talkbox">
        <div id="talkto">
            <ul id="talktoul" v-for="talkto in talktos">
                <li v-bind:class="{talkto:1,active:talkto.friendid==talktoid}">
                    <div class="talktodiv">
                        <div class="talktodivbg"></div>
                        <div class="talktodivcont">
                            <img :src="'static/img/' + talkto.photo " alt="" class="talkto-photo">
                            <p class="talkto-name">{{talkto.username}}</p>
                            <a class="ctrbtn right closethis" href="###" @click="closetalkto(talkto.friendid)"><i class="iconfont">&#xf01b0;</i></a>
                        </div>
                    </div>
                </li>
            </ul>
        </div>
        <div v-for="talkto in talktos">
          
            <div v-bind:class="{talkbox_count:1,active:talktoid==talkto.friendid} ">
                <div class="talkbox_countbg"></div>
                <div class="talkbox_countdiv">
                    <div class="talkbox-header">
                        <div id="myinfo">
                            <h3>{{talkto.username}}</h3>
                            <!-- <i class="iconfont font12">&#x346a;</i> -->
                            <p id="mystate">{{talkto.userinfo}}</p>
                        </div>
                    </div>
                    <div class="talkbox-body">
                        <div class="talk-bodydiv">
                            <div class="newsdiv" :uid="talkto.friendid">
                              <div v-if="messages['u'+talkto.friendid]">
                                <div v-for="message in messages['u' + talkto.friendid]">
                                      <div class='message' v-if="message.type=='come'">
                                        <img :src="'static/img/' + talkto.photo " class='anotherphoto' /><div class='saymessage'>{{message.message}}</div ><p class='saytime'>{{datetime("mm-dd h:i:s",message.create_time*1000)}}</p>
                                      </div>
                                      <div class='message' v-else-if="message.type=='go'">
                                        <img :src="'static/img/' + user.photo " class='myphoto' /><div class='replymessage'>{{message.message}}</div><p class='replytime'>{{datetime("mm-dd h:i:s",message.create_time*1000)}}</p>
                                      </div>
                                </div>
                              </div>
                              <!-- <div v-for="message in messages">
                                <div v-if="message.withid==talkto.friendid">
                                  <div v-for="msg in message.data">
                                    
                                    <div class='message' v-if="msg.type=='come'">
                                      <img :src="'static/img/' + talkto.photo " class='anotherphoto' /><div class='saymessage'>{{msg.message}}</div ><p class='saytime'>{{datetime("mm-dd h:i:s",msg.create_time*1000)}}</p>
                                    </div>
                                    <div class='message' v-else-if="msg.type=='go'">
                                      <img :src="'static/img/' + user.photo " class='myphoto' /><div class='replymessage'>{{msg.message}}</div><p class='replytime'>{{datetime("mm-dd h:i:s",msg.create_time*1000)}}</p>
                                    </div>
                                  </div>
                                </div>
                              </div>
                               -->



                            </div>
                            <div class="btns">
                                <ul class="clearfix">
                                    <li class="btnsli"><a class="btnsa" href="###"><span class="icon-text-color"></span></a></li>
                                    <li class="btnsli"><a class="btnsa emojibtn" href="###"><span class="icon-grin"></span></a></li>
                                    <li class="btnsli"><a class="btnsa" href="###"><span class="icon-magic-wand"></span></a></li>
                                    <li class="btnsli"><a class="btnsa" href="###"><span class="icon-stopwatch"></span></a></li>
                                    <li class="btnsli"><a class="btnsa" href="###"><span class="icon-image"></span></a></li>
                                    <li class="btnsli"><a class="btnsa" href="###"><span class="icon-scissors"></span></a></li>
                                </ul>
                            </div>
                            <div class="say" contenteditable=true ref="editdiv"></div>
                            <div class="saybtns">
                                <a href="###" class="saybtns-ad">分享给好友，我们更茁壮。</a>
                                <a href="###" class="talkbtn">关闭(C)</a>
                                <a href="###" class="talkbtn" @click="sendmsg">发送(S)</a>
                                <a href="###" class="talkbtn option"><i class="iconfont">&#xf0122;</i></a>
                            </div>
                        </div>
                        <div class="talk-bodyads">
                            <a href="###"><img src="static/img/hh.jpg" alt="" class="imgbg"></a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div id="ctr">
            <ul>
                <li class="ctrli"><a class="ctrbtn" href="###"><i class="iconfont">&#xf0122;</i></a></li>
                <li class="ctrli"><a class="ctrbtn" href="###"><i class="iconfont">&#xf018c;</i></a></li>
                <li class="ctrli"><a class="ctrbtn removebox" href="###" @click="closetalktos"><i class="iconfont">&#xf01b0;</i></a></li>
            </ul>
        </div>
    </div>
</div>
</template>

<script>
import vcookie from "vcookie";
import router from "../router/index.js"
import {mapState} from "vuex"
export default {
  name: 'Talkbox',
  computed:{
    ...mapState([
      "ws",
      "talktoid",
      "user",
      "messages",
    ]),
    talktos:function(){
      return this.$store.getters.talkto;
    },
    
  },
  beforeMount(){
    console.log(this.user);
    var w=window.innerWidth|| document.documentElement.clientWidth|| document.body.clientWidth;
    var h=window.innerHeight|| document.documentElement.clientHeight|| document.body.clientHeight;

    // this.talkto=this.$store.getters.talkto;
    // this.show=this.talkto.length;
    // console.log(this.talkto);
  },
  data () {
    return {
      msg:"",
      name1:"l"
    }
  },
  methods:{
    datetime(fmt,time){   
      let date=new Date(time); 
      var o = {   
        "m+" : date.getMonth()+1,                 //月份   
        "d+" : date.getDate(),                    //日   
        "h+" : date.getHours(),                   //小时   
        "i+" : date.getMinutes(),                 //分   
        "s+" : date.getSeconds(),                 //秒   
        "q+" : Math.floor((date.getMonth()+3)/3), //季度   
        "S"  : date.getMilliseconds()             //毫秒   
      };  
      if(/(y+)/.test(fmt))   
        fmt=fmt.replace(RegExp.$1, (date.getFullYear()+"").substr(4 - RegExp.$1.length));   
      for(var k in o)   
        if(new RegExp("("+ k +")").test(fmt))   
      fmt = fmt.replace(RegExp.$1, (RegExp.$1.length==1) ? (o[k]) : (("00"+ o[k]).substr((""+ o[k]).length)));   
      return fmt;   
    } ,
    closetalktos:function(){
      this.$store.commit("deltalkto");
    },
    closetalkto:function(id){
      this.$store.commit("deltalkto",id);
    },
    sendmsg:function(){
      console.log(this.ws);
      let that=this;
      let msg=that.$refs.editdiv[0].innerHTML;
      let create_time=Math.floor(new Date().getTime()/1000);
      this.$store.commit("addMessages",{"withid":that.talktoid,"type":"go","message":msg,"create_time":create_time,"readed":0});
      this.ws.send(JSON.stringify({"type":"sendtoUid","toid":that.talktoid,"fromid":this.user.id,"message":that.$refs.editdiv[0].innerHTML,"create_time":Math.floor(new Date().getTime()/1000)}));
      that.$refs.editdiv[0].innerHTML="";
      console.log(this.messages);
    }
  },
  components:{
    
  }
}
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>
#box{
  width:800px;
  height:600px;
  position: absolute;
  left: 68px;
  top:0;
}
#talkbox{
  position: absolute;
  width: 736px;
  height: 510px;
  left: 50px;
  top: 50px;
  background: #333;
  -moz-border-radius: 5px;
    -webkit-border-radius: 5px;
    border-radius:5px;
    background: url("/static/img/bg1.jpg");
}
#talkto{
  width:150px;
  height:504px;
  background: rgb(171, 177, 242);
  float: left;
  padding:3px 0;
}
.talktodiv{
  width:144px;
  height:30px;
  /*background: gray;*/
  margin:0 3px;
  padding: 6px 0;
  position: relative;
  z-index: 2;
}
.talktodivbg{
  position: absolute;
  left: 0;
  top:0px;
  width: 144px;
  height:42px;
  -moz-border-radius: 5px;
  -webkit-border-radius: 5px;
  border-radius:5px;
  z-index: 1;
}
.talkto:hover .talktodivbg{
  background: #EDE6E6;
  -moz-opacity:0.3;
  filter:alpha(opacity=30);
  opacity:.30;
}
.talkto.active .talktodivbg{
  background: #EDE6E6;
  -moz-opacity:0.6;
  filter:alpha(opacity=60);
  opacity:.60;
}
.talktodivcont{
  position: relative;
  z-index: 2;
}
.talkto-photo{
  display: inline-block;
  width:30px;
  height:30px;
  vertical-align: middle;
  padding: 0 3px;
  -moz-border-radius: 5px;
  -webkit-border-radius: 5px;
  border-radius:5px;
}
.talkto-name{
  display: inline-block;
  font-size: 14px;
  line-height: 30px;
  width: 76px;
  vertical-align: middle;
  color:#fff;
  overflow: hidden;
  white-space: nowrap;
}
.active .talkto-name{
  color: #000000;
}
.talktodiv.active  .talkto-name{
  color:#000;
}
.ctrbtn.closethis{
  display:none;
}
.talkto:hover .ctrbtn.closethis{
  display:block;
}
.newsnum{
  background:orange;
  color:#fff;
  font-size:12px;
  line-height:16px;
  -moz-border-radius: 5px;
  -webkit-border-radius: 5px;
  border-radius: 5px;
  display: block;
  text-align: center;
}
.talkto:hover .newsnum{
  display:none;
}
.talkto.active .newsnum{
  display:none;
}


.talkbox_count{
  float: left;
  width: 585px;
  height:510px;
  position: relative;
  display: none;
}
.talkbox_count.active{
  display: block;
}
.talkbox_countbg{
  position: absolute;
  width:100%;
  height:510px;
  -moz-opacity:0.1;
  filter:alpha(opacity=10);
  opacity: .10;
  background: #fff;
  z-index: 1;
  left: 0;
  top: 0;
}
.talkbox_countdiv{
  position: relative;
  z-index: 2;
}
.talkbox-header{
  width:585px;
  height:85px;
  border-bottom: 1px solid #666;
}
  #ctr{
    height:25px;
    position: absolute;
    right: 5px;
    top: 5px;
    z-index: 3;
  }
  .ctrli{
    float: left;
  }
  .ctrbtn{
    display: block;
    height:16px;
    min-width: 16px;
    margin:4px;
    text-decoration: none;
    margin: 7px 5px 7px 0;
    padding: 0 2px;
  }
#myinfo{
  padding: 0 10px;
  width:427px;
}
#myinfo h3{
  font-size:18px;
  line-height: 28px; 
  padding-top: 5px;
}
#mystate,.iconfont.font12{
  width: 410px;
  font-size: 12px;
  float: left;
}
.iconfont.font12{
  display: block;
  width: 12px;
  font-size: 12px;
  margin-right: 5px;
  float: left;
}
.talkbox-body{
  width:585px;
  height:424px;
}
.talk-bodyads{
  width:140px;
  height:424px;
  float: right;
}
.talk-bodydiv{
  width:445px;
  float: left;
}
.newsdiv{
  overflow-x:hidden;
  overflow-y:auto;
  height:286px;
  border-bottom: 1px solid #666;
  position: relative;
  background: rgba(255, 255, 255, 0.46);
}
#emoji{
  position: absolute;
  display: none;
  width:387px;
  height: 238px;
  overflow-y:auto;
  left: 100px;
  top: 163px;
  z-index: 4;
  background: #fff;
  padding: 10px;
}
#emoji.active{
  display: block;
}
.btnsli{
  float: left;
}
.btnsa{
  display: block;
  width:16px;
  height:16px;
  margin:2px 5px;
  overflow: hidden;
  padding:2px;
  border:1px solid transparent;
}
.btnsa:hover{
  border:1px solid #666;
}
.icon-text-color {
    font-size: 20px;
}
.say{
  width:100%;
  height: 72px;
  line-height: 24px;
  font-size: 16px;
  vertical-align: middle;
  background: rgba(255, 255, 255, 0.46);
}
.msEmoji{
  display: inline-block;
    line-height: 24px;
    vertical-align: top;
}
.saybtns{
  width:100%;
  height:40px;
}
.saybtns-ad{
  width:200px;
  padding:0 10px;
  color:#333;
  font-size: 14px;
  line-height: 40px;
  float: left;
}
.talkbtn{
  float: left;
  margin: 5px 0 5px 10px;
  display: block;
  width:70px;
  height:30px;
  color:#fff;
  text-align: center;
  line-height: 30px;
  background: #83BB40;
  -moz-border-radius: 5px;
  -webkit-border-radius: 5px;
  border-radius: 5px;
  font-size: 13px;
}
.talkbtn.option{
  margin-left:0;
  width:20px;
}
.talkbtn .iconfont{
  color:#fff;
  font-size: 12px;
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
