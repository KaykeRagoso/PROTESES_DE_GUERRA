#region INPUT
var key_left  = keyboard_check(ord("A")) || keyboard_check(vk_left);
var key_right = keyboard_check(ord("D")) || keyboard_check(vk_right);
var key_jump  = keyboard_check_pressed(vk_space) || keyboard_check_pressed(vk_up);
var key_dash  = keyboard_check_pressed(vk_shift);

//Ataques
var key_switchWeapon = keyboard_check_pressed(vk_tab);
var key_attack = keyboard_check(ord("Z"));
var key_attack_pressed = keyboard_check_pressed(ord("Z"));
var key_attack_released = keyboard_check_released(ord("Z"));
var key_kick = keyboard_check_pressed(ord("X"));
var key_spin = keyboard_check_pressed(ord("C"));

var move = key_right - key_left;
#endregion

#region SwitchWeapon
if (key_switchWeapon && state != PlayerState.CUTSCENE)
{
    weapon += 1;

    if (weapon > WeaponType.GUN)
        weapon = WeaponType.BASIC;
}
#endregion


#region DETECÇÕES
var grounded = place_meeting(x, y + 1, obj_Block);

var wall_r = place_meeting(x + 1, y, obj_Block);
var wall_l = place_meeting(x - 1, y, obj_Block);

on_wall = 0;
if (wall_r) on_wall = 1;
if (wall_l) on_wall = -1;
#endregion


#region COMBO TIMER
if (combo_timer > 0)
{
    combo_timer--;
}
else
{
    combo_step = 0;
}
#endregion

#region GUN CHARGE
if (weapon == WeaponType.GUN)
{
    if (key_attack)
    {
        gun_charge += 1;

        if (gun_charge > gun_max_charge)
            gun_charge = gun_max_charge;

        hsp = 0;
    }

    if (key_attack_released)
    {
        state = PlayerState.ATTACK;
        attack_timer = 0;
        attack_type = 10;
    }
}
#endregion

#region ATTACK COOLDOWN
if (attack_cooldown > 0)
    attack_cooldown--;
#endregion


#region STATE MACHINE
switch (state)
{
case PlayerState.CUTSCENE:
    // Não se move
    hsp = 0;
    vsp = 0;

    // Não permite ataques
    attack_timer = 0;
    attack_type = 0;

    // Mantém a sprite de idle dependendo da arma
    if (weapon == WeaponType.BASIC) sprite_index = (facing==1)?sprt_PlayerIdleEsq:sprt_PlayerIdleDir;
    if (weapon == WeaponType.SWORD) sprite_index = (facing==1)?sprt_PlayerIdleEspadaDir:sprt_PlayerIdleEspadaEsq;
    if (weapon == WeaponType.GUN) sprite_index = (facing==1)?sprt_PlayerIdleCanhaoEsq:sprt_PlayerIdleCanhaoDir;
    image_speed = image_number / 2;
break;

case PlayerState.IDLE:

    hsp = move * walksp;

    if (move != 0)
    {
        facing = move;
        state = PlayerState.RUN;
    }

    if (!grounded)
        state = PlayerState.AIR;

    if (key_jump && grounded)
    {
        vsp = jump_force;
        state = PlayerState.AIR;
    }

    if ((key_attack_pressed || key_kick || key_spin) && attack_cooldown <= 0)
    {
        state = PlayerState.ATTACK;
        attack_timer = 0;
        attack_cooldown = attack_cooldown_max;

        if (weapon == WeaponType.BASIC)
        {
            if (key_attack_pressed)
            {
                combo_step += 1;
                combo_timer = combo_max_time;
                if (combo_step > 2) combo_step = 1;
                attack_type = combo_step;
            }

            if (key_kick) attack_type = 3;
            if (key_spin) attack_type = 4;
        }

        if (weapon == WeaponType.SWORD) attack_type = 1;
        if (weapon == WeaponType.GUN) attack_type = 10;
    }

break;



case PlayerState.RUN:

    hsp = move * walksp;

    if (move != 0)
        facing = move;
    else
        state = PlayerState.IDLE;

    if (!grounded)
        state = PlayerState.AIR;

    if (key_jump && grounded)
    {
        vsp = jump_force;
        state = PlayerState.AIR;
    }

    if (key_dash && can_dash)
        state = PlayerState.DASH;

    if ((key_attack_pressed || key_kick || key_spin) && attack_cooldown <= 0)
    {
        state = PlayerState.ATTACK;
        attack_timer = 0;
        attack_cooldown = attack_cooldown_max;

        if (weapon == WeaponType.BASIC)
        {
            if (key_attack_pressed)
            {
                combo_step += 1;
                combo_timer = combo_max_time;
                if (combo_step > 2) combo_step = 1;
                attack_type = combo_step;
            }

            if (key_kick) attack_type = 3;
            if (key_spin) attack_type = 4;
        }

        if (weapon == WeaponType.SWORD) attack_type = 1;
        if (weapon == WeaponType.GUN) attack_type = 10;
    }

break;



case PlayerState.AIR:

    vsp += grv;

    if (control_lock > 0)
        control_lock--;
    else
    {
        hsp = move * walksp;
        if (move != 0) facing = move;
    }

    // Wall slide (só com braço básico)
    if (weapon == WeaponType.BASIC)
    {
        if (on_wall != 0 && vsp > 0)
            vsp = min(vsp, wall_speed_limit);

        if (on_wall != 0 && key_jump)
        {
            vsp = jump_force;
            hsp = -on_wall * walksp * 2.5;
            facing = -on_wall;
            control_lock = 12;

            audio_play_sound(snd_wall_jump, 10, false);

            part_particles_create(part_sys, x + (10 * on_wall), y, part_dust, 10);
        }
    }

    if (grounded)
    {
        can_dash = true;
        state = PlayerState.IDLE;
    }

    if (key_dash && can_dash)
        state = PlayerState.DASH;

break;



case PlayerState.DASH:

    if (!variable_instance_exists(id, "dash_delay_timer"))
        dash_delay_timer = 8;

    if (dash_delay_timer > 0)
    {
        dash_delay_timer--;
        hsp = 0;
        vsp = 0;
    }
    else
    {
        if (dash_timer <= 0)
        {
            dash_timer = dash_duration;
            can_dash = false;
        }

        vsp = 0;
        hsp = facing * dash_sp;

        dash_timer--;

        if (dash_timer <= 0)
        {
            state = PlayerState.AIR;
            dash_delay_timer = undefined;
        }
    }

break;



case PlayerState.ATTACK:

    hsp = 0;

    attack_timer++;

    // Fim do ataque
    if (attack_timer > 15)
    {
        state = PlayerState.IDLE;
    }

    // Hitbox básico
    if (attack_type <= 3)
    {
        var hit = collision_rectangle(x + (facing * 20), y - 10, x + (facing * 40), y + 10, obj_Inimigo, false, true);
        if (hit != noone) with(hit) { hpEnemy -= 1; }
    }

    // Canhão dispara de acordo com gun_charge
    if (weapon == WeaponType.GUN && attack_type == 10)
    {
        // spawn de tiro aqui, por exemplo:
        // instance_create_layer(x + facing*16, y, "Instances", obj_Tiro);
        gun_charge = 0;
    }

break;

}
#endregion


#region COLISÕES
// Horizontal
if (place_meeting(x + hsp, y, obj_Block))
{
    while (!place_meeting(x + sign(hsp), y, obj_Block))
        x += sign(hsp);
    hsp = 0;
}
x += hsp;

// Vertical
if (place_meeting(x, y + vsp, obj_Block))
{
    while (!place_meeting(x, y + sign(vsp), obj_Block))
        y += sign(vsp);
    vsp = 0;
}
y += vsp;
#endregion


#region SPRITES
switch (state)
{

case PlayerState.IDLE:
    if (weapon == WeaponType.BASIC) sprite_index = (facing == 1) ? sprt_PlayerIdleEsq : sprt_PlayerIdleDir;
    if (weapon == WeaponType.SWORD) sprite_index = (facing == 1) ? sprt_PlayerIdleEspadaDir : sprt_PlayerIdleEspadaEsq;
    if (weapon == WeaponType.GUN) sprite_index = (facing == 1) ? sprt_PlayerIdleCanhaoEsq : sprt_PlayerIdleCanhaoDir;
    image_speed = image_number / 2;
break;

case PlayerState.RUN:
    if (weapon == WeaponType.BASIC) sprite_index = (facing == 1) ? sprt_PlayerRunEsq : sprt_PlayerRunDir;
    if (weapon == WeaponType.SWORD) sprite_index = (facing == 1) ? sprt_PlayerRunEspadaEsq : sprt_PlayerRunEspadaDir;
    if (weapon == WeaponType.GUN) sprite_index = (facing == 1) ? sprt_PlayerRunCanhaoEsq : sprt_PlayerRunCanhaoDir;
    image_speed = image_number / 3;
break;

case PlayerState.AIR:
    if (on_wall != 0 && vsp > 0 && weapon == WeaponType.BASIC)
    {
        sprite_index = (on_wall == 1) ? sprt_PlayerWallSlideDir : sprt_PlayerWallSlideEsq;
    }
    else
    {
        if (weapon == WeaponType.BASIC) sprite_index = (facing == 1) ? sprt_PlayerJumpandFallEsq : sprt_PlayerJumpandFallDir;
        if (weapon == WeaponType.SWORD) sprite_index = (facing == 1) ? sprt_PlayerJumpandfallEspadaEsq : sprt_PlayerJumpandfallEspadaDir;
        if (weapon == WeaponType.GUN) sprite_index = (facing == 1) ? sprt_PlayerJumpandFallCanhaoEsq : sprt_PlayerJumpandFallCanhaoDir;
    }
break;

case PlayerState.DASH:
    if (weapon == WeaponType.BASIC) sprite_index = (facing == 1) ? sprt_PlayerDashEsq : sprt_PlayerDashDir;
    if (weapon == WeaponType.SWORD) sprite_index = (facing == 1) ? sprt_PlayerDashEspadaEsq  : sprt_PlayerDashEspadaDir;
    if (weapon == WeaponType.GUN) sprite_index = (facing == 1) ? sprt_PlayerDashCanhaoEsq : sprt_PlayerDashCanhaoDir;
break;

case PlayerState.ATTACK:
    if (weapon == WeaponType.BASIC)
    {
        if (attack_type == 1) sprite_index = (facing == 1) ? sprt_PlayerSocoFrenteEsq  : sprt_PlayerSocoFrenteDir;
        if (attack_type == 2) sprite_index = (facing == 1) ? sprt_PlayerSocoFrenteEsq  : sprt_PlayerSocoFrenteDir;
        if (attack_type == 3) sprite_index = (facing == 1) ? sprt_PlayerChuteBaixoEsq : sprt_PlayerChuteBaixoDir;
        if (attack_type == 4) sprite_index = (facing == 1) ? sprt_PlayerAtaqueGiratorioEsq  : sprt_PlayerAtaqueGiratorioDir;
    }
    if (weapon == WeaponType.SWORD)
    {
        sprite_index = (facing == 1) ? sprt_PlayerAtaqueEspadaEsq : sprt_PlayerAtaqueEspadaDir;
    }
    if (weapon == WeaponType.GUN)
    {
        sprite_index = (facing == 1) ? sprt_PlayerAtirouEsq  : sprt_PlayerAtirouDir;
    }
    image_speed = image_number / 2;
break;

}
#endregion