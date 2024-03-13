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