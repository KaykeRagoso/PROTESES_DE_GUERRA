// Inherit the parent event
event_inherited();

#region DROPAR ITEMS
function dropItem(){
    var chance = irandom_range(1,100);
	if (chance <= 35){
		instance_create_layer(x,y,"Instances",obj_Moedas);	
	}else if (chance <= 70){
		instance_create_layer(x,y,"Instances",obj_PotionLife);
	}
}
#endregion

#region SPRITES CUSTOMIZADOS
spr_enemy_idle = sprt_SoldadoRun;
spr_enemy_run = sprt_SoldadoRun;
spr_enemy_jump = sprt_SoldadoRun;
spr_enemy_shoting = sprt_SoldadoAttack;
spr_enemy_death2 = sprt_SoldadoDeath;
spdEnemy = 0.8; // Patrulha lenta
#endregion