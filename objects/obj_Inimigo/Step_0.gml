checkDeath();

if (state == EnemyState.DEATH) {
    instance_destroy();
    exit;
}


#region Detecção
if (instance_exists(obj_Player)) {

    var distPlayer = point_distance(x, y, obj_Player.x, obj_Player.y);

    var parede = collision_line(
        x, y - 10,
        obj_Player.x, obj_Player.y - 10,
        obj_Block, false, true
    );

    if (distPlayer <= dist_visao && !parede) {

        target = obj_Player;
        tempo_perda_alvo = 0;

        if (state == EnemyState.PATROL) {
            mostrar_alerta = 60;
        }

    } 
    else if (target != noone) {
        tempo_perda_alvo++;

        if (tempo_perda_alvo > 60) {
            target = noone;
        }
    }
}
#endregion

#region State Machine
switch (state)
{

    case EnemyState.PATROL:

        move_dir = facing;
        hspdEnemy = spdEnemy * move_dir;

        var frontX = x + (facing * 8);
        var frontY = y + 16;

        if (!place_meeting(frontX, frontY, obj_Block) ||
            place_meeting(x + facing, y, obj_Block))
        {
            facing *= -1;
        }

        if (target != noone)
            state = EnemyState.CHASE;

    break;



    case EnemyState.CHASE:

        if (target != noone)
        {
            var dx = target.x - x;

            facing = sign(dx);
            hspdEnemy = spdEnemyMax * facing;

            // PULO AUTOMÁTICO MELHORADO
            if (place_meeting(x + hspdEnemy, y, obj_Block)
                && place_meeting(x, y + 1, obj_Block))
            {
                vspdEnemy = -7.5;
            }

            if (point_distance(x, y, target.x, target.y) < dist_tiro)
            {
                state = EnemyState.ATTACK;
                ataque = false;
            }
        }
        else
        {
            state = EnemyState.PATROL;
        }

    break;



    case EnemyState.ATTACK:

        if (recoil_force == 0)
            hspdEnemy = 0;

        if (target != noone)
        {
            var dir = point_direction(x, y, target.x, target.y);

            if (!ataque)
            {
                var bullet = instance_create_layer(
                    x + (facing * 12),
                    y - 10,
                    "Instances",
                    obj_Bullet
                );

                if (bullet != noone)
                {
                    bullet.direction = dir;
                    bullet.speed = 5;
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

#region Recoil
if (recoil_force != 0)
{
    hspdEnemy = recoil_force;

    recoil_force = lerp(recoil_force, 0, recoil_decay);

    if (abs(recoil_force) < 0.05)
        recoil_force = 0;
}
#endregion

#region Gravidade
vspdEnemy += grv;

if (vspdEnemy > maxFall)
    vspdEnemy = maxFall;
#endregion

#region Colisão
if (place_meeting(x + hspdEnemy, y, obj_Block))
{
    while (!place_meeting(x + sign(hspdEnemy), y, obj_Block))
        x += sign(hspdEnemy);

    hspdEnemy = 0;
}

x += hspdEnemy;


if (place_meeting(x, y + vspdEnemy, obj_Block))
{
    while (!place_meeting(x, y + sign(vspdEnemy), obj_Block))
        y += sign(vspdEnemy);

    vspdEnemy = 0;
}

y += vspdEnemy;
#endregion

#region Troca de Sprite
switch(state){
	case EnemyState.ATTACK:
		sprite_index = spr_enemy_shoting;
	break;
}
#endregion