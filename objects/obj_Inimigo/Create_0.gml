spdEnemy = 1;
spdEnemyMax = spdEnemy + 1;
hspdEnemy = 0;
vspdEnemy = 0;
grv = 0.35;
maxFall = 6;

hpEnemy = 3;

patrol_left = x - 64;
patrol_right = x + 64;

ataque = false;
ataque_cool = 0;
ataque_delay = 15;

target = noone;
facing = 1;

recoil_force = 0;
recoil_decay = 0.2;

enum EnemyState{
	PATROL, 
	CHASE,
	ATTACK,
	DEATH
}

state = EnemyState.PATROL;

function checkDeath(){
	if (hpEnemy <= 0){
		dropItem();
		state = EnemyState.DEATH;	
	}
}

function aplicarRecoil(_forca){
	recoil_force = _forca * -facing; 
}

//Drop de Item com 5% de drop poção vida, 15% munição e restante dropa nada
function dropItem(){
	var chance = irandom_range(1,100);
	
	if (chance <= 5){
		//instance_create_layer(x,y,"Instances",obj_Potion);
		show_debug_message("Dropou Potion");
	}else if (chance <= 20){
		//instance_create_layer(x,y,"Instances",obj_Ammo);
		show_debug_message("Dropou Munição");
	}
}