    import Vue from "vue"
    var mutations={
        setUser(state,u){
            if(u){
                state.user=u;
            }
        },
        addtalkto(state,p){
            var len=state.talktos.length;
            state.talktoid=p.friendid;
            for(var i=0;i<len;i++){
                if(state.talktos[i].friendid==p.friendid){
                    return;
                }
            }
            state.talktos.push(p);
        },
        deltalkto(state,id){
            if(!id){
                state.talktoid=0;
                state.talktos=[];
                return;
            }
            var len=state.talktos.length;
            for(var i=0;i<len;i++){
                if(state.talktos[i].friendid==id){
                    state.talktos.splice(i,1);
                    state.talktoid=i>0?state.talktos[i-1].friendid:0;
                    return;
                }
            }
        },
        setDraging(state,int){
            state.draging=int?1:0;
        },
        setWs(state,socket){
            state.ws=socket;
        },
        addMessages(state,message){
            // 对象属性变化不更新视图，舍弃。
            var twithid=message.withid;
            delete message.withid;
            // for(let i=0,len=state.messages.length;i<len;i++){
            //     if(state.messages[i].widthid==twithid){
            //         state.messages[i].data.push(message);
            //         return;
            //     }
            // }
            // state.messages.push({"withid":twithid,"data":[message]});


            if(state.messages["u"+twithid]){
                state.messages["u"+twithid].push(message);
            }else{
                // var obj=Object.assign({},state.messages,{"u"+twithid:[message]});
                // state.messages=obj;
                Vue.set(state.messages,"u"+twithid,[message]);
            }

        },
        readMessages(state,withid){
            var obj=state.messages['u'+withid] || [];
            for(var i=0,len=obj.length;i<len;i++){
                if(obj[i].readed==0){
                    
                }
                obj[i].readed=1;
            }
            Vue.set(state.messages,"u"+withid,obj);
        },

        
    };
    var actions={

    }
    export {mutations,actions};
