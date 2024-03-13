// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function List(cap) constructor{
	capacity=cap;
	list=array_create(cap);
	index=0;
	add=function(item){
		if(index==cap){
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
}