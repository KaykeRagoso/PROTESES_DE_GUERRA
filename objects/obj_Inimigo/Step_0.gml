// Trocar Estado quando o player tiver perto do inimigo
if (instance_exists(obj_Player)){
	var distPlayer = point_distance(x,y,obj_Player.x, obj_Player.y);
	
	if (distPlayer <= 200){
		target = obj_Player;
		state = EnemyState.CHASE;
	}else{
		target = noone;
		
		if (state == EnemyState.CHASE){
			state = EnemyState.PATROL;	
		}else{
			state = EnemyState.IDLE;	
		}
	}
}

show_debug_message(state);