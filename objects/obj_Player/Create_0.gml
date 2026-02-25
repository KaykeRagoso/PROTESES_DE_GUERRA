// Movimento
hsp = 0;
vsp = 0;
grv = 0.4;
walksp = 3;
jump_force = -9;

global.ativo = true;

// Direção
facing = 1;

// Dash
can_dash = true;
dash_duration = 10;
dash_timer = 0;
dash_sp = 10;

// Wall
wall_speed_limit = 3;
on_wall = 0;
control_lock = 0;

// Criar o Sistema
part_sys = part_system_create();

//partícula de poeira
part_dust = part_type_create();
part_type_sprite(part_dust, spr_pixel, false, false, false);
part_type_size(part_dust, 1, 2, -0.05, 0);
part_type_color1(part_dust, c_gray);
part_type_alpha2(part_dust, 0.8, 0);
part_type_speed(part_dust, 1, 3, 0, 0);
part_type_direction(part_dust, 0, 360, 0, 0);
part_type_life(part_dust, 10, 20);

enum PlayerState {
    IDLE,
    RUN,
    AIR,
    DASH,
    DEATH,
    DAMAGE,
    ATTACK,
	CUTSCENE
}

state = PlayerState.IDLE;

enum WeaponType{
    BASIC,
    SWORD,
    GUN
}

weapon = WeaponType.BASIC;

// Sistema de ataque
attack_type = 0;
attack_timer = 0;
attack_cooldown = 0;
attack_cooldown_max = 5;

// Combos
combo_step = 0;
combo_timer = 0;
combo_max_time = 20; // frames que o combo espera para resetar

// Canhão
gun_charge = 0;
gun_max_charge = 60;

fpsGame = game_get_speed(gamespeed_fps);

can_shoot = false;

function shootBullet(_sprite, _dir, _spd, _dmg, _offset_x, _offset_y){
    var b = instance_create_layer(obj_Player.x + _offset_x, obj_Player.y + _offset_y, "Instances", obj_Bullet);
    b.sprite_index = _sprite;
    b.img_speed = 0.2;
    b.dir = _dir;
    b.spd = _spd;
    b.damage = _dmg;
    b.hit_enemy = obj_Inimigo;
    return b;
}