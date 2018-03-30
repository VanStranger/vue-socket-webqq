
    var mutations={
        setUser(state,u){
            if(u){
                state.user=u;
            }
        },
        addtalkto(state,p){
            var len=state.talkto.length;
            state.talktoid=p.friendid;
            for(var i=0;i<len;i++){
                if(state.talkto[i].friendid==p.friendid){
                    return;
                }
            }
            state.talkto.push(p);
        },
        deltalkto(state,id){
            if(!id){
                state.talktoid=0;
                state.talkto=[];
                return;
            }
            var len=state.talkto.length;
            for(var i=0;i<len;i++){
                if(state.talkto[i].friendid==id){
                    state.talkto.splice(i,1);
                    state.talktoid=state.talkto[i-1].friendid;
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
            //对象属性变化不更新视图，舍弃。
            // var withid=message.withid;
            // delete message.withid;
            // if(state.messages[withid]){
            //     var messages=state.messages[withid]
            //     messages.push(message);
            //     var newobj={};
            //     newobj[withid]=messages;
            //     Object.assign(state.messages,newobj);
            // }else{
            //     var newobj={};
            //     newobj[withid]=message;
            //     Object.assign(state.messages,newobj);
            // }
            state.messages.push(message);
        },
    };
    var actions={

    }
    export {mutations,actions};
