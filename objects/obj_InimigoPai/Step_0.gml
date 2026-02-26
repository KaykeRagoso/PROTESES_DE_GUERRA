checkDeath();

if (state == EnemyState.DEATH)
{
    if (image_index >= image_number - 1)
    {
        instance_destroy();
    }
    exit;
}

// Dano por contato
if (state != EnemyState.DEATH) {
	if (state == EnemyState.PATROL || state == EnemyState.CHASE){
		if (contato_dano_cooldown > 0){
			contato_dano_cooldown--;
		}else if (place_meeting(x,y,obj_Player)){
			with(obj_Player){
				takeDamage(10,other.facing);	
			}
			contato_dano_cooldown = 60;
		}
	}	
}

//Verificação de morte
if (hpEnemy <= 0){
	state = EnemyState.DEATH;
}

#region DETECÇÃO DO PLAYER

var player = instance_nearest(x, y, obj_Player);

if (player != noone)
{

    var distPlayer = point_distance(x, y, player.x, player.y);
	
	can_see_player =
	(
	    distPlayer < shoot_range
	    && collision_line(x, y, player.x, player.y, obj_Block, false, true) == noone
	);

    var parede = collision_line(
        x, y - 10,
        player.x, player.y - 10,
        obj_Block, false, true
    );

    if (distPlayer <= dist_visao && !parede)
    {

        target = player;
        tempo_perda_alvo = 0;

        if (state == EnemyState.PATROL)
        {
            mostrar_alerta = 60;
        }

    }
    else if (target != noone)
    {

        tempo_perda_alvo++;

        if (tempo_perda_alvo > 90)
        {
            target = noone;
        }

    }

}

#endregion

#region MIRA

if (target != noone && instance_exists(target))
{

    var target_dir = point_direction(x, y - 10, target.x, target.y - 10);

    aim_dir = lerp(aim_dir, target_dir, aim_speed);

}

#endregion


#region STATE MACHINE

switch (state)
{

    case EnemyState.PATROL:

        move_dir = facing;
        hspdEnemy = spdEnemy * move_dir;

        var frontX = x + (facing * 8);
        var frontY = y + 16;

        var parede = place_meeting(x + facing, y, obj_Block);
        var chao_frente = place_meeting(frontX, frontY, obj_Block);

        if (parede || (nao_cair_plataforma && !chao_frente))
        {
            facing *= -1;
        }

        if (target != noone)
        {
            state = EnemyState.CHASE;
        }

    break;



    case EnemyState.CHASE:

        if (target != noone && instance_exists(target))
        {

            var dx = target.x - x;

            facing = sign(dx);
            hspdEnemy = spdEnemyMax * facing;

            if (place_meeting(x + hspdEnemy, y, obj_Block)
            && place_meeting(x, y + 1, obj_Block))
            {
                vspdEnemy = -7.5;
            }

            var dist = point_distance(x, y, target.x, target.y);

            if (dist < dist_tiro && dist > dist_min_tiro)
            {
                state = EnemyState.ATTACK;
                ataque = false;
                tempo_mira = 0;
            }

        }
        else
        {
            state = EnemyState.PATROL;
        }

    break;



   case EnemyState.ATTACK:

    hspdEnemy = 0;

    if (target != noone && instance_exists(target))
    {

        tempo_mira++;

        if (tempo_mira < tempo_mira_max)
            break;

        reaction_timer++;

        if (reaction_timer < reaction_time)
            break;

        if (!ataque)
        {

            var erro = random_range(-shot_inaccuracy, shot_inaccuracy);

            var dir = aim_dir + erro;

            var bullet = instance_create_layer(
                x + (facing * 12),
                y - 10,
                "Instances",
                obj_EnemyBullet
            );

            if (bullet != noone)
            {
                bullet.direction = dir;
                bullet.speed = 5;
				bullet.damage = 10;
                bullet.owner = id;
            }

            aplicarRecoil(dir, 4);

            ataque = true;
            ataque_cool = 0;

        }
        else
        {

            ataque_cool++;

            if (ataque_cool >= ataque_delay)
            {

                ataque = false;
                tempo_mira = 0;
                reaction_timer = 0;

                if (target != noone)
                    state = EnemyState.CHASE;
                else
                    state = EnemyState.PATROL;

            }

        }

    }
    else
    {
        state = EnemyState.PATROL;
    }

break;

}

#endregion



#region RECOIL

if (recoil_force != 0)
{

    hspdEnemy = recoil_force;

    recoil_force = lerp(recoil_force, 0, recoil_decay);

    if (abs(recoil_force) < 0.05)
        recoil_force = 0;

}

#endregion



#region GRAVIDADE

vspdEnemy += grv;

if (vspdEnemy > maxFall)
    vspdEnemy = maxFall;

#endregion



#region COLISÃO HORIZONTAL

if (place_meeting(x + hspdEnemy, y, obj_Block))
{

    while (!place_meeting(x + sign(hspdEnemy), y, obj_Block))
        x += sign(hspdEnemy);

    hspdEnemy = 0;

}

x += hspdEnemy;

#endregion



#region COLISÃO VERTICAL

if (place_meeting(x, y + vspdEnemy, obj_Block))
{

    while (!place_meeting(x, y + sign(vspdEnemy), obj_Block))
        y += sign(vspdEnemy);

    vspdEnemy = 0;

}

y += vspdEnemy;

#endregion



#region SPRITE

if (state == EnemyState.DEATH)
{

    sprite_index = spr_enemy_death2;
    image_speed = 0.2;

}
else if (!place_meeting(x, y + 1, obj_Block))
{

    sprite_index = spr_enemy_jump;
    image_speed = 0.2;

}
else
{

    switch(state)
    {

        case EnemyState.PATROL:
        case EnemyState.CHASE:

            sprite_index = spr_enemy_run;
            image_speed = 0.2;

        break;


        case EnemyState.ATTACK:

            sprite_index = spr_enemy_shoting;
            image_speed = 0.2;

        break;


        default:

            sprite_index = spr_enemy_idle;
            image_speed = 0.15;

        break;

    }

}

image_xscale = facing;

#endregion