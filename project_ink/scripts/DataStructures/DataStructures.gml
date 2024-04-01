// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function List(cap) constructor{
	capacity=cap;
	list=array_create(cap);
	index=0;
	add=function(item){
		if(index==capacity){
			show_debug_message("array out of capacity");
			return;
		}
		list[index++]=item;
	};
	addRange=function(ls){
		for(var i=0;i<ls.index;++i){
			add(ls.list[i]);
		}
	}
	at=function(i){
		return list[i];
	}
	clear=function(){
		index=0;
	}
	removeAt=function(i){
		var tmp=list[i];
		for(var j=i+1;j<index;++j){
			list[j-1]=list[j];
		}
		--index;
		return tmp;
	}
}
function Bounds(_x,_y,_w,_h) constructor{
	x=_x;
	y=_y;
	w=_w;
	h=_h;
}
function copyBounds(bd){
	return new Bounds(bd.x,bd.y,bd.w,bd.h);
}
//-----card-----
//1: 普通攻击 d: 1
//2: 重击 d:2
//3: 迅势
//4: 凝霜
//5: 破阵
//6: 疾风
//7: 连附

function copy_struct(struct){
	var key, value;
    var newCopy = {};
    var keys = variable_struct_get_names(struct);
    for (var i = array_length(keys)-1; i >= 0; --i) {
            key = keys[i];
            value = struct[$ key];
            variable_struct_get(struct, key);
            variable_struct_set(newCopy, key, value)
    }
    return newCopy;
}