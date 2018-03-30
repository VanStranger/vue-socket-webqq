<template>
  <div id="friends">
    <ul v-for="(group,index) in friendsObj">
        <li class="friendsgroup" >
            <div class="friendsgroupbg"></div>
            <div class="friendsgrouncont" @click="changeactive(index)">
                <i class="icon-play3 paddingleft10"></i>
                <span class="groupname">{{group.GroupName}}</span>
                <span class="online">{{group.OnlineFriendsNum}}</span>
                /
                <span class="all">{{group.FriendsNum}}</span>
            </div>
            <ul v-bind:class="{friendsdiv:1,active:group.active}" v-for="friend in group.Friends">
                <Friendsli :friend="friend"></Friendsli>
            </ul>
        </li>
    </ul>
  </div>
</template>
<script>
    import Friendsli from "./Friendsli.vue"
    export default {
        name:"FriendsGroup",
        props:["userid"],
        data(){
          return {
            groups:[],
            friendsObj:[],
          }
        },
        methods:{
          changeactive:function(index){
            this.friendsObj[index]['active']=!this.friendsObj[index]['active'];
          }
        },
        beforeMount(){
          console.log(this);
          var form=new FormData();
          form.append("type","getGroupsFriends");
          form.append("userid",this.userid);
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
             this.groups=res.data.groups;
             var lfriends=res.data.friends;
             var friendsObj=[];
             for(var i=0,glen=res.data.groups.length;i<glen;i++){
                friendsObj[friendsObj.length]={'GroupName':res.data.groups[i],"Friends":[],"FriendsNum":0,"OnlineFriendsNum":0,active:0};
                for(var j=0,flen=lfriends.length;j<flen;j++){
                   if(lfriends[j].groupid==i){
                      friendsObj[i]['Friends'].push(lfriends[j]);
                      friendsObj[i]['FriendsNum']++;
                      lfriends[j].online==1 && friendsObj[i]['OnlineFriendsNum']++;
                      flen--;
                      lfriends.splice(j,1);
                   }
                }
             }
             this.friendsObj=friendsObj;
             console.log(friendsObj);
            }
          })
        },
        components:{
            Friendsli,
        }
    }
</script>
<style scoped>
.friendsgroup{
  line-height: 30px;
  font-size: 14px;
}
.paddingleft10{
  padding-left: 10px;
}

.friendsdiv{
  display: none;
}
.friendsdiv.active{
  display: block;
}
</style>