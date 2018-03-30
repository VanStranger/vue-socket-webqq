<template>
  <div id="reglogdiv">
  <a href="###" class="button">换背景</a>
  <div id="reglog" v-bind:style="{top:reglogTop,left:reglogLeft}">
    <div class="canvasheader">
      <!-- <canvas id = "myCanvas" width = "430px" height = "185px" style = "background-color:black;"> </canvas> -->
      <div id="particles-js" style = "width:430px;height:185px;background-color:black;"></div>
      <div class="absolute">
        <img src="/static/img/logo1new1.png" alt="" class="logo">
        <p style="color:#fff;"></p>
      </div>
      <div class="kong" @mousedown="startDrag" @mousemove="drag" @mouseup="stopDrag"></div>
      <ul id="baohe-btns">
        <li class="ctrli"><a class="ctrbtn" href="###"><i class="iconfont">&#xf0122;</i></a></li>
        <li class="ctrli"><a class="ctrbtn" href="###"><i class="iconfont">&#xf018c;</i></a></li>
        <li class="ctrli"><a class="ctrbtn" href="###"><i class="iconfont">&#xf01b0;</i></a></li>
      </ul>
    </div>
    <div id="logbody">
      <div class="padding15">
        <div class="logphoto">
          <img src="/static/img/photo.jpg" alt="" class="logphotoimg">
          <span class="zhuangtai icon-happy2 logzhuangtai"></span>
        </div>
        <div id="log">
          <input type="text" name="username" id="username" class="regloginput" tabindex=1 v-model="userid" v-on:blur="checkuserid">
          <i class="iconfont moreid">&#xf0122;</i>
          <a href="###" id="regbtn">注册账号</a>

          <input type="password" name="password" id="password" class="regloginput" tabindex=2 v-model="password">
          <i class="iconfont moreid">&#xf0122;</i>
          <a href="###" id="findpass">找回密码</a>
          <div class="logoptions">
            <p class="left"><span class="checkspan ifmemory"></span><span>记住密码</span></p>
            <p class="right"><span class="checkspan auto">  </span><span>自动登录</span></p>
            <a href="###"  class="logbtn" tabindex=3 v-on:click="log">登录</a>
          </div>
        </div>
      </div>
    </div>
    <div id="regbody">
      <div class="padding15">
        <div class="logphoto">
          <img src="/static/img/photo.jpg" alt="" class="logphotoimg">
          <span class="zhuangtai icon-happy2 logzhuangtai"></span>
        </div>
        <div id="reg">
          <input type="text" name="username" id="myname" class="regloginput" value="昵称">
          <input type="text" name="text" id="mypass" class="regloginput" value="请输入密码">
          <a href="###" id="logbtn">已有账号</a>
          <div class="logoptions">
            <p>请按照按钮提示注册</p>
            <a href="###" class="logbtn index0">点我</a><a href="###" class="logbtn index1">不要点我</a>
          </div>
        </div>
      </div>
      
    </div>
  </div>
  </div>
</template>
<script>
    import particles from 'particles.js'
    import router from '../router'
    import vcookie from "vcookie";
    export default{
        name:"Login",
        beforeMount:function(){
          this.w=window.innerWidth|| document.documentElement.clientWidth|| document.body.clientWidth;
          this.h=window.innerHeight|| document.documentElement.clientHeight|| document.body.clientHeight;
          this.stopTop=this.reglogTop=(this.h-330)/2 +"px";
          this.stopLeft=this.reglogLeft=(this.w-430)/2 +"px";
        },
        mounted:function (){
              particlesJS.load('particles-js',"/static/p.json");
        },
        computed:{
          draging:function(){
            return this.$store.getters.draging;
          },
        },
        data (){
          return {
            w:0,
            h:0,
            reglogTop:"0px",
            reglogLeft:"0px",
            stopTop:0,
            stopLfet:0,


            userid:"",
            password:"",

            mouseDownX:0,
            mouseDownY:0,
            mouseMoveX:0,
            mouseMoveY:0,
          }
        },
        methods:{
          log:function(event){
            var form=new FormData();
            form.append("type","login");
            form.append("userid",this.userid);
            form.append("password",this.password);
            fetch("api/api.php",{
              method:"POST",
              body:form,
            })
              .then((res)=>{
                return res.json()
              })
              .then((res)=>{
                console.log(res);
                if(res.state==1){
                  vcookie.set("UserID",this.userid);
                  vcookie.set("UserName",res.data.username);
                  vcookie.set("Password",res.data.password);
                  vcookie.set("Photo",res.data.photo);
                  vcookie.set("UserInfo",res.data.qianming);
                  this.$store.commit("setUser",{
                    "id":this.userid,
                    "username":res.data.username,
                    "photo":res.data.photo,
                    "userInfo":res.data.qianming,
                  });
                  console.log("sd");
                  router.push('/');
                }
              })
          },
          checkuserid:function(){
            console.log("check");
            console.log(this.userid);
          },
          startDrag:function(event){
            this.mouseDownX=event.clientX;
            this.mouseDownY=event.clientY;
            this.$store.commit("setDraging",1);
          },
          drag:function(event){
            window.getSelection ? window.getSelection().removeAllRanges() : document.selection.empty();
            if(!this.draging){
              return;
            }
            console.log(event.clientX);
            console.log(event.clientY);
            console.log(this.reglogTop);
            console.log(this.draging);
            this.reglogTop=parseInt(this.stopTop) +event.clientY-this.mouseDownY + "px";
            this.reglogLeft=parseInt(this.stopLeft) +event.clientX-this.mouseDownX + "px";
          },
          stopDrag:function(){
            this.mouseDownX=0;
            this.mouseDownY=0;
            this.stopTop=this.reglogTop;
            this.stopLeft=this.reglogLeft;
            this.$store.commit("setDraging",0);
          }
          
        }
    }
</script>
<style scoped>

#reglogdiv{
  width:100%;
  height:100%;
}
#reglog{
  width:430px;
  height:330px;
  margin:0 auto;
  background: #666;
  position: absolute;
}
.button{
  color: #666;
  display: block;
  width: 60px;
  height: 30px;
  line-height: 30px;
  text-align: center;
  border: 1px solid #111;
  border-radius: 3px;
  float: right;
  margin: 18px;
}
.kong{
  position: absolute;
  width:100%;
  height:100%;
  left: 0;
  top: 0;
}
#reglog .iconfont{
  color:#fff;
}
.canvasheader{
  height:185px;
  position: relative;
}
.absolute{
  position: absolute;
  width:100%;
  height:100%;
  overflow: hidden;
  top:0;
  left: 0;
}
.logo{
  height:60px;
  width:auto;
  display: block;
  margin:60px auto;
}
#logbody{
  height:145px;
  background: #EBF2F9;
}
#regbody{
  height:145px;
  background: #EBF2F9;
  display: none;
}
.padding15{
  padding:15px;
}
.logphoto{
  height:80px;
  width:80px;
  float: left;
  position: relative;
  padding-left: 25px;
  margin-right: 10px;
}
.logphotoimg{
  width:100%;
  display: block;
}
.logzhuangtai{
  position: absolute;
  bottom: 3px;
  right: 3px;
}
#log{
  float: left;
  width:268px;
}
.regloginput{
  width: 186px;
  padding-left: 3px;
  height: 28px;
  border:1px solid #D1D1D1;
  letter-spacing: 1.5px;
  color: gray;
  font-size: 12px;
}
#reglog .moreid.iconfont{
  position: relative;
  left: -28px;
  color:#B1B1B1;
  font-size: 12px;
}
#mypass{
  margin-right:10px;
}
#regbtn,#findpass,#logbtn{
  font-size: 12px;
  color:#06B1DD;
  position: relative;
  left:-10px;
}
.logoptions{
  width:188px;
  font-size: 12px;
  line-height: 20px;
  float: left;
}
.left{
  float: left;
  line-height: 20px;
  vertical-align: middle;
}
.right{
  float: right;
}
.checkspan{
  display: inline-block;
  width:10px;
  height:10px;
  border:1px solid #666;
  line-height: 20px;
  vertical-align: middle;
  margin-right: 5px;
}
.checkspan.active{
  background: green;
}
.logbtn{
  display: block;
  width: 68px;
  height:30px;
  background: #09A3DC;
  color:#fff;
  letter-spacing: 3px;
  font-size: 14px;
  -moz-border-radius: 5px;
  -webkit-border-radius: 5px;
  border-radius: 5px;
  text-align: center;
  line-height: 30px;
  position: relative;
  top:10px;
  float: left;
  margin-right: 20px;
}
#log .logbtn{
  width:100%;
  margin:0;
}
.logbtn:hover{
  background: #3CC3F5;
}
.rightbtnul{
  background: gray;
}
.rightbtnli{
  padding-left: 28px;
    background: url("/static/img/rightbtnbg.jpg") repeat-y;
    line-height: 24px;
    color: #3A3A3A;
    font-size: 15px;
     position:relative;
}
.rightbtnli:hover{
  background: #337FD1;
}
.rightbtna{
  color: #3A3A3A;
}
.jtr{
  display: inline-block;
  width:0;
  height:0;
  border-top: 5px solid transparent;
  border-bottom: 5px solid transparent;
  border-left: 5px solid gray;
  /* float: right; */
  /* margin: 8px 0; */
  line-height: 24px;
  margin-left: 10px;
}
.rightbtnulzi{
  position: absolute;
  top:0;
  left:100%;
  width: 130px;
  padding-left: 5px;
  color: #3a3a3a;
  display: none;
}
.rightbtnulzi.active{
  display: block;
}
.rightbtnulzi{
  line-height:24px;
  font-size:15px;
}
.rightbtnazi{
  color:#3a3a3a;
}

</style>