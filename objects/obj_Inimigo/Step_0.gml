checkDeath();
// Trocar Estado quando o player tiver perto do inimigo
if (instance_exists(obj_Player) && state != EnemyState.ATTACK && state != EnemyState.DEATH){
	
	var distPlayer = point_distance(x,y,obj_Player.x, obj_Player.y);
	
	if (distPlayer <= 200) {
		target = obj_Player;
		state = EnemyState.CHASE;
	} else {
		target = noone;
		state = EnemyState.PATROL;
	}
}


// State machine
switch (state) {

	case EnemyState.PATROL:
		
		hspdEnemy = spdEnemy * facing;
		
		// Não cair da plataforma
		var frontX = x + (facing * 8);
		var frontY = y + 16;
		
		if (!place_meeting(frontX, frontY, obj_Block)) {
			facing *= -1;
		}
		
	break;
	
	
	case EnemyState.CHASE:
		
		if (target != noone){
			
			facing = sign(target.x - x);
			
			// Persegue mais rápido
			hspdEnemy = spdEnemyMax * facing;
			
			// Distância ideal para ranged
			if (abs(target.x - x) > 40 &&
				abs(target.x - x) < 160 &&
				abs(target.y - y) < 32){
					
				state = EnemyState.ATTACK;
			}
		}
		
	break;
	
	
	case EnemyState.ATTACK:
		
		hspdEnemy = 0;
		
		if (target != noone){
			facing = sign(target.x - x);
		}
		
		ataque_cool++;
		
		// Momento do disparo
		if (ataque_cool >= ataque_delay && !ataque){
			
			var bullet = instance_create_layer(x + (facing * 12), y, "Instances", obj_Bullet);
			bullet.direction = facing == 1 ? 0 : 180;
			bullet.speed = 6;
			
			aplicarRecoil(2)
			
			ataque = true;
		}
		
		// Final do ataque
		if (ataque_cool >= ataque_delay){
			ataque_cool = 0;
			ataque = false;
			state = EnemyState.ATTACK;
		}else if (distance_to_object(obj_Player) >= 20){
			state = EnemyState.CHASE;
		}
		
	break;
	
	
	case EnemyState.DEATH:		
		instance_destroy();		
	break;
}
//Recoil
if (recoil_force != 0){
	
	hspdEnemy += recoil_force;
	
	// Redução gradual do recoil
	recoil_force -= sign(recoil_force) * recoil_decay;
	
	if (abs(recoil_force) < recoil_decay){
		recoil_force = 0;
	}
}

// GRAVIDADE
vspdEnemy += grv;

if (vspdEnemy > maxFall){
	vspdEnemy = maxFall;
}


// COLISÃO HORIZONTAL
if (place_meeting(x + hspdEnemy, y, obj_Block)){
	
	while (!place_meeting(x + sign(hspdEnemy), y, obj_Block)){
		x += sign(hspdEnemy);
	}
	
	hspdEnemy = 0;
	facing *= -1;
}

x += hspdEnemy;


// COLISÃO VERTICAL
if (place_meeting(x, y + vspdEnemy, obj_Block)){
	
	while (!place_meeting(x, y + sign(vspdEnemy), obj_Block)){
		y += sign(vspdEnemy);
	}
	
	vspdEnemy = 0;
}

y += vspdEnemy;

// Trocar Xscale automatico
image_xscale = facing;