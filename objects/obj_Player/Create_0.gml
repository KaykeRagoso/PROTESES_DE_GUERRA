// Movimento
hsp = 0;
vsp = 0;
grv = 0.4;
walksp = 3;
jump_force = -9;

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
    ATTACK
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

// Canhão
gun_charge = 0;
gun_max_charge = 60;

fpsGame = game_get_speed(gamespeed_fps);