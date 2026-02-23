checkDeath();

if (state == EnemyState.DEATH) {
    instance_destroy();
    exit;
}


// Detectar Player
if (instance_exists(obj_Player) 
&& state != EnemyState.ATTACK 
&& state != EnemyState.DEATH)
{
    var distPlayer = point_distance(x, y, obj_Player.x, obj_Player.y);

    if (distPlayer <= 200) {
        target = obj_Player;
        state = EnemyState.CHASE;
    } else {
        target = noone;
        state = EnemyState.PATROL;
    }
}


// STATE MACHINE
switch (state)
{
    case EnemyState.PATROL:
        move_dir = facing;

        var frontX = x + (facing * 8);
        var frontY = y + 16;

        // Não cair da plataforma ou bater na parede
        if (!place_meeting(frontX, frontY, obj_Block) ||
            place_meeting(x + facing, y, obj_Block))
        {
            move_dir = -facing;
        }

        hspdEnemy = spdEnemy * move_dir;
    break;


    case EnemyState.CHASE:
        if (target != noone)
        {
            var target_center = (target.bbox_left + target.bbox_right) * 0.5;
            var dx = target_center - x;

            // Dead zone horizontal
            if (abs(dx) > 4) {
                move_dir = sign(dx);
            }

            hspdEnemy = spdEnemyMax * move_dir;

            // Distância ideal para atacar o playter
            if (abs(dx) > 40 &&
                abs(dx) < 160 &&
                abs(target.y - y) < 32)
            {
                state = EnemyState.ATTACK;
            }
        }
    break;


    case EnemyState.ATTACK:
        move_dir = 0;
        hspdEnemy = 0;

        if (target != noone)
        {
            var target_center = (target.bbox_left + target.bbox_right) * 0.5;
            var dx = target_center - x;

            if (abs(dx) > 4) {
                facing = sign(dx);
            }
        }

        ataque_cool++;

        if (ataque_cool >= ataque_delay && !ataque)
        {
            var bullet = instance_create_layer(
                x + (facing * 12),
                y,
                "Instances",
                obj_Bullet
            );

            bullet.direction = (facing == 1) ? 0 : 180;
            bullet.speed = 6;

            aplicarRecoil(2);
            ataque = true;
        }

        if (ataque_cool >= ataque_delay)
        {
            ataque_cool = 0;
            ataque = false;

            if (target != noone &&
                point_distance(x, y, target.x, target.y) <= 200)
            {
                state = EnemyState.CHASE;
            }
            else
            {
                state = EnemyState.PATROL;
            }
        }
    break;
}


// FACING
if (move_dir != 0) {
    facing = move_dir;
}

// RECOIL
if (recoil_force != 0)
{
    hspdEnemy += recoil_force;

    recoil_force -= sign(recoil_force) * recoil_decay;

    if (abs(recoil_force) < recoil_decay) {
        recoil_force = 0;
    }
}

// GRAVIDADE
vspdEnemy += grv;

if (vspdEnemy > maxFall) {
    vspdEnemy = maxFall;
}

// COLISÃO HORIZONTAL
if (place_meeting(x + hspdEnemy, y, obj_Block))
{
    while (!place_meeting(x + sign(hspdEnemy), y, obj_Block)) {
        x += sign(hspdEnemy);
    }

    hspdEnemy = 0;
}

x += hspdEnemy;

// COLISÃO VERTICAL
if (place_meeting(x, y + vspdEnemy, obj_Block))
{
    while (!place_meeting(x, y + sign(vspdEnemy), obj_Block)) {
        y += sign(vspdEnemy);
    }

    vspdEnemy = 0;
}

y += vspdEnemy;

// SPRITE FLIP
if (facing == -1) image_xscale = -1;
if (facing ==  1) image_xscale =  1;