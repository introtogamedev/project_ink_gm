/// @description Insert description here
// You can write your code in this editor

card={};

function onHitEnemy(enemy){
	switch(card.type){
		case 5: //破阵
		var aoe=instance_create_layer(x, y, "Instances", obj_explosion);
		aoe.card=card; /////////    aoe.damage=card.aoe;
		break;
	}
}