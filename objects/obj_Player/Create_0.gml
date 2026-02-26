//Movimento
hsp    = 0;
vsp    = 0;
grv    = 0.4;
walksp = 3;


//Pulo
jump_force_basic = -9;
jump_force_gun   = -9;
jump_force_sword = -12;
jump_force       = jump_force_basic;


//Direção e Dash
facing           = 1;
can_dash         = true;
dash_duration    = 10;
dash_timer       = 0;
dash_sp          = 10;
// pequena janela antes de iniciar o dash (frames)
dash_delay       = 5;
dash_delay_timer = 0;
// cooldown pós‑dash para evitar spam (frames, 2s = 120 em 60fps)
dash_cooldown       = 90;
dash_cooldown_timer = 0;


//Wall Slide
wall_speed_limit = 3;
on_wall          = 0;
control_lock     = 0;


//Partículas
part_sys  = part_system_create();
part_dust = part_type_create();

part_type_sprite(part_dust, spr_pixel, false, false, false);
part_type_size(part_dust, 1, 2, -0.05, 0);
part_type_color1(part_dust, c_gray);
part_type_alpha2(part_dust, 0.8, 0);
part_type_speed(part_dust, 1, 3, 0, 0);
part_type_direction(part_dust, 0, 360, 0, 0);
part_type_life(part_dust, 10, 20);


#region Enums
enum PlayerState {
    IDLE,
    RUN,
    AIR,
    DASH,
    ATTACK,
	HIT,
	DEATH,
    CUTSCENE
}

enum WeaponType {
    BASIC,
    SWORD,
    GUN
}
#endregion


//Estado Inicial
state  = PlayerState.IDLE;
weapon = WeaponType.BASIC;

// Vida do player
max_hp = 100;
hp     = max_hp;
invincible      = false; // para dar um tempo de invencibilidade após levar dano
invincible_timer = 0;
invincible_time  = 30;   // frames de invencibilidade após levar dano


//Ataque
attack_type         = 0;
attack_timer        = 0;
attack_duration     = 15;
attack_cooldown     = 0;
attack_cooldown_max = 5;
maxFall = 10;


//Combo
combo_step     = 0;
combo_timer    = 0;
combo_max_time = 20;


//Canhão
gun_charge     = 0;
gun_max_charge = 60;
gun_hold_timer = 0;
can_shoot      = false;
is_charging    = false;

room_speed_original = room_speed;

hit_timer        = 0;
hit_duration     = 20; // frames no estado de hit
death_timer      = 0;
death_duration   = 60; // frames da animação de morte antes de ficar no chão
is_dead          = false;


//Funções
function shootBullet(_sprite, _dir, _spd, _dmg, _offset_x, _offset_y, _onehit)
{
    var b          = instance_create_layer(x + _offset_x, y + _offset_y, "Instances", obj_EnemyBullet);
    b.sprite_index = _sprite;
    b.image_speed  = 3;
    b.image_xscale = (_dir == 180) ? -1 : 1;
    b.direction    = _dir;
    b.speed        = _spd;
    b.damage       = _dmg;
    b.one_hit      = _onehit;
    b.hit_enemy    = obj_InimigoPai;
    return b;
}


// Função de dano
function takeDamage(_amount, _knockback_dir) {
    if (invincible || is_dead) exit;

    global.vida_atual -= _amount;
    global.vida_atual = clamp(global.vida_atual, 0, global.vida_max);

    instance_create_layer(x, y, "Instances", obj_flash_dano);
    audio_play_sound(snd_hitplayer, 1, false);

    if (global.vida_atual <= 0) {
        is_dead = true;
        state   = PlayerState.DEATH;
        hsp     = 0;
        vsp     = -3; // pequeno salto ao morrer
        exit;
    }

    // Knockback
    hsp              = -_knockback_dir * 4;
    vsp              = -2;
    invincible       = true;
    invincible_timer = invincible_time;
    hit_timer        = hit_duration;
    state            = PlayerState.HIT;
}