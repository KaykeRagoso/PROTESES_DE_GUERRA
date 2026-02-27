#region Input
var key_left     = keyboard_check(ord("A")) || keyboard_check(vk_left);
var key_right    = keyboard_check(ord("D")) || keyboard_check(vk_right);
var key_jump     = keyboard_check_pressed(vk_space) || keyboard_check_pressed(vk_up);
var key_dash     = keyboard_check_pressed(vk_shift);

var key_switchWeapon   = keyboard_check_pressed(vk_tab);

var key_attack         = keyboard_check(ord("Z"));
var key_attack_pressed = keyboard_check_pressed(ord("Z"));
var key_attack_released= keyboard_check_released(ord("Z"));

var key_kick           = keyboard_check_pressed(ord("X"));
var key_spin           = keyboard_check_pressed(ord("C"));

var move = key_right - key_left;

// decrementa cooldown de dash a cada frame
if (dash_cooldown_timer > 0) dash_cooldown_timer--;
#endregion

#region Switch Weapon
if (key_switchWeapon && state != PlayerState.CUTSCENE)
{
    weapon += 1;
    if (weapon > WeaponType.GUN) weapon = WeaponType.BASIC;

    switch (weapon)
    {
        case WeaponType.BASIC: jump_force = jump_force_basic; break;
        case WeaponType.SWORD: jump_force = jump_force_sword; break;
        case WeaponType.GUN:   jump_force = jump_force_gun;   break;
    }

    is_charging = false;
    gun_charge  = 0;
}
#endregion

#region Detecções
// chão / rampas
var grounded = false;
var ramp_inst = noone;

// bloco horizontal normal
if (place_meeting(x, y + 1, obj_Block))
    grounded = true;

//// checa se estamos sobre uma rampa (usa um pixel adiante para "colocar o pé" na inclinação)
//ramp_inst = instance_place(x, y + 1, obj_RampaDir);
//if (ramp_inst != noone)
//{
//    grounded = true;
//}
//else
//{
//    ramp_inst = instance_place(x, y + 1, obj_RampaEsq);
//    if (ramp_inst != noone)
//        grounded = true;
//}

// paredes (não são afetadas por rampas)
var wall_r = place_meeting(x + 1, y, obj_Block);
var wall_l = place_meeting(x - 1, y, obj_Block);

on_wall = 0;
if (wall_r) on_wall =  1;
if (wall_l) on_wall = -1;

// Invencibilidade timer
if (invincible) {
    invincible_timer -= 1;
    if (invincible_timer <= 0) {
        invincible = false;
    }
}

#endregion

#region Combo Timer
if (combo_timer > 0)
    combo_timer--;
else
    combo_step = 0;
	
if (combo_zx_timer > 0)
    combo_zx_timer--;
else
    combo_zx_ready = false;
#endregion

#region Carregar Canhão
if (weapon == WeaponType.GUN && state != PlayerState.CUTSCENE && state != PlayerState.ATTACK)
{
    if (key_attack)
    {
        gun_hold_timer += 1;

        // Só entra em modo charge após 60 frames segurando
        if (gun_hold_timer >= 60)
        {
            is_charging = true;
            gun_charge  = min(gun_charge + 1, gun_max_charge);

            hsp = 0;

            if (state == PlayerState.RUN)
                state = PlayerState.IDLE;
        }
    }

    if (key_attack_released)
    {
        if (is_charging)
        {
            // 7 níveis divididos em 60 frames (~8 frames cada)
            if      (gun_charge <  9) attack_type = 10;  // Fraco Pequeno
            else if (gun_charge < 18) attack_type = 11;  // Fraco Médio
            else if (gun_charge < 27) attack_type = 12;  // Fraco Grande
            else if (gun_charge < 36) attack_type = 13;  // Grande
            else if (gun_charge < 45) attack_type = 14;  // Azul Forte
            else if (gun_charge < 54) attack_type = 15;  // Roxo Forte
            else                      attack_type = 16;  // Vermelho Forte
        }
        else if (gun_hold_timer > 0)
        {
            // Soltou Z antes dos 60 frames — tiro fraco imediato
            attack_type = 10;
        }

        is_charging    = false;
        gun_hold_timer = 0;
        gun_charge     = 0;
        state          = PlayerState.ATTACK;
        attack_timer   = 0;
        can_shoot      = true;
    }
}
#endregion

#region Cooldown de Ataque
if (attack_cooldown > 0) attack_cooldown--;
#endregion

#region State Machine
switch (state)
{

// Cutscene
case PlayerState.CUTSCENE:
    hsp = 0;
    vsp = 0;
    attack_timer = 0;
    attack_type  = 0;

    switch (weapon)
    {
        case WeaponType.BASIC: sprite_index = (facing==1) ? sprt_PlayerIdleEsq       : sprt_PlayerIdleDir;       break;
        case WeaponType.SWORD: sprite_index = (facing==1) ? sprt_PlayerIdleEspadaDir : sprt_PlayerIdleEspadaEsq; break;
        case WeaponType.GUN:   sprite_index = (facing==1) ? sprt_PlayerIdleCanhaoEsq : sprt_PlayerIdleCanhaoDir; break;
    }
    image_speed = image_number / 2;
break;


// Idle
case PlayerState.IDLE:

    if (!(weapon == WeaponType.GUN && is_charging))
        hsp = move * walksp;

    if (move != 0 && !(weapon == WeaponType.GUN && is_charging))
    {
        facing = move;
        state  = PlayerState.RUN;
    }

    if (!grounded)
        state = PlayerState.AIR;

    if (key_jump && grounded && !is_charging)
    {
        vsp   = jump_force;
        state = PlayerState.AIR;
    }

    if (weapon != WeaponType.GUN)
	{
	    var _pode_spin = (weapon == WeaponType.BASIC) && key_spin;
	    if ((key_attack_pressed || key_kick || _pode_spin) && attack_cooldown <= 0)
	    {
	        state           = PlayerState.ATTACK;
	        attack_timer    = 0;
	        attack_cooldown = attack_cooldown_max;
	        _setAttackType(weapon, key_attack_pressed, key_kick, key_spin);
	    }
	}

break;


// Run
case PlayerState.RUN:

    hsp = move * walksp;

    if (move != 0) facing = move;
    else           state  = PlayerState.IDLE;

    if (!grounded) state = PlayerState.AIR;

    if (key_jump && grounded)
    {
        vsp   = jump_force;
        state = PlayerState.AIR;
    }

    if (key_dash && can_dash && dash_cooldown_timer <= 0) {
        state = PlayerState.DASH;
        dash_delay_timer = dash_delay;
    }

    if (weapon != WeaponType.GUN)
    {
        if ((key_attack_pressed || key_kick) && attack_cooldown <= 0)
        {
            state           = PlayerState.ATTACK;
            attack_timer    = 0;
            attack_cooldown = attack_cooldown_max;
            _setAttackType(weapon, key_attack_pressed, key_kick,false);
        }
    }

break;


// Air
case PlayerState.AIR:

    vsp += grv;

    if (control_lock > 0) control_lock--;
    else
    {
        hsp = move * walksp;
        if (move != 0) facing = move;
    }

    // Wall slide — só com básico
    if (weapon == WeaponType.BASIC)
    {
        if (on_wall != 0 && vsp > 0)
            vsp = min(vsp, wall_speed_limit);
			

        if (on_wall != 0 && key_jump)
        {
			// Ativa o tremor do personagem enquanto desliza
        
            vsp          = jump_force;
            hsp          = -on_wall * walksp * 2.5;
            facing       = -on_wall;
            control_lock = 12;

            audio_play_sound(snd_wall_jump, 10, false);
            part_particles_create(part_sys, x + (10 * on_wall), y, part_dust, 10);
        }
    }

    if (grounded)
    {
        can_dash = true;
        state    = PlayerState.IDLE;
    }

    if (key_dash && can_dash && dash_cooldown_timer <= 0) {
        state = PlayerState.DASH;
        dash_delay_timer = dash_delay;
    }

break;


// Dash
case PlayerState.DASH:

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
            can_dash   = false;
        }

        vsp = 0;
        hsp = facing * dash_sp;
        dash_timer--;

        if (dash_timer <= 0)
        {
            state            = PlayerState.AIR;
            dash_delay_timer = 0;
            // iniciar cooldown para próximo dash
            dash_cooldown_timer = dash_cooldown;
        }
    }

break;


// Attack
case PlayerState.ATTACK:

    hsp = 0;
    attack_timer++;
    
    // Combo Z+X — detecta X durante o ataque básico
    if (weapon == WeaponType.BASIC && key_kick && combo_zx_ready && combo_zx_timer > 0)
    {
        attack_type    = 5;
        attack_timer   = 0;
        combo_zx_ready = false;
        combo_zx_timer = 0;
    }

    // HitBox Básico
    if (weapon == WeaponType.BASIC)
    {
        switch (attack_type)
        {
            case 1:
                if (attack_timer == 4)
                    _hitEnemies(facing * 20, -10, facing * 38, 10, 1);
            break;

            case 2:
                if (attack_timer == 4)
                    _hitEnemies(facing * 18, -12, facing * 42, 12, 1);
            break;

            case 3:
                if (attack_timer == 5)
                    _hitEnemies(facing * 16, 2, facing * 40, 18, 1);
            break;

            case 4:
                if (attack_timer == 6)
                    _hitEnemies(-40, -14, 40, 14, 2);
            break;
			
			case 5:
			    if (attack_timer == 8)
			        _hitEnemies(facing * 10, -20, facing * 55, 20, 5); 
			break;
        }
    }

    // HitBox Espada
    if (weapon == WeaponType.SWORD)
    {
        switch (attack_type)
        {
            case 1:
                if (attack_timer == 3)
                    _hitEnemies(facing * 22, -16, facing * 50, 12, 2);
            break;

            case 2:
                if (attack_timer == 3)
                    _hitEnemies(facing * 20, -20, facing * 54, 16, 2);
            break;

            case 3:
                if (attack_timer mod 3 == 0 && attack_timer <= 12)
                    _hitEnemies(facing * 18, -18, facing * 52, 18, 3);
            break;
        }
    }

    // Disparo Canhão
    if (weapon == WeaponType.GUN && can_shoot)
    {
        var _dir = (facing == 1) ? 0 : 180;
        var _ox  = 8 * facing;
        var _oy  = -4;

        switch (attack_type)
        {
            case 10: shootBullet(sprt_TiroFracoPequeno, _dir, 6,    1,    _ox, _oy, false); break;
            case 11: shootBullet(sprt_TiroFracoMedio,   _dir, 6.5,  2,    _ox, _oy, false); break;
            case 12: shootBullet(sprt_TiroFracoGrande,  _dir, 7,    3,    _ox, _oy, false); break;
            case 13: shootBullet(sprt_TiroGrande,       _dir, 7.5,  5,    _ox, _oy, false); break;
            case 14: shootBullet(sprt_TiroAzulForte,    _dir, 8,    7,    _ox, _oy, false); break;
            case 15: shootBullet(sprt_TiroRoxoForte,    _dir, 8.5,  10,   _ox, _oy, false); break;
            case 16: shootBullet(sprt_TiroVermelhoForte,_dir, 9,    9999, _ox, _oy, true);  break;
        }

        gun_charge = 0;
        can_shoot  = false;
    }

    // Duração do estado
    var _atk_end = (weapon == WeaponType.SWORD) ? 10 : 15;
    if (attack_type == 4) _atk_end = 18;
	if (attack_type == 5) _atk_end = 22;
    if (attack_type == 3 && weapon == WeaponType.SWORD) _atk_end = 16;

    if (attack_timer > _atk_end)
    {
        can_shoot = true;
        state     = PlayerState.IDLE;
    }

break;


// Hit
case PlayerState.HIT:
    vsp += grv;

    hit_timer--;
    if (hit_timer <= 0) {
        state = grounded ? PlayerState.IDLE : PlayerState.AIR;
    }
break;


// Death
case PlayerState.DEATH:
    hsp = 0;
    vsp += grv;
    if (vsp > maxFall) vsp = maxFall;

    death_timer++;

    // Gruda no chão feito um cadáver
    if (place_meeting(x, y + 1, obj_Block)) {
        vsp = 0;
        // Empurra pra fora do chão caso esteja enterrado
        while (place_meeting(x, y, obj_Block)) {
            y--;
        }

        if (death_timer > 10 && !instance_exists(obj_game_over)) {
            instance_create_layer(0, 0, "Instances", obj_game_over);

        }
    }
break;

}
#endregion

#region Colisões
if (place_meeting(x + hsp, y, obj_Block))
{
    while (!place_meeting(x + sign(hsp), y, obj_Block))
        x += sign(hsp);
    hsp = 0;
}
x += hsp;

// depois do movimento horizontal, verifica se entramos numa rampa
if (instance_exists(ramp_inst))
{
    // calcula a altura do "chão" dentro da rampa com base na posição x
    var px      = x;
    var rel     = clamp(px - ramp_inst.x + ramp_inst.slope_length/2, 0, ramp_inst.slope_length);
    var floorY;
    if (ramp_inst.slope_dir == 1)
        floorY = ramp_inst.y - ramp_inst.slope_height/2 + rel;
    else
        floorY = ramp_inst.y + ramp_inst.slope_height/2 - rel;

    if (y > floorY)
    {
        y = floorY;
        vsp = 0;
    }
}

if (place_meeting(x, y + vsp, obj_Block))
{
    while (!place_meeting(x, y + sign(vsp), obj_Block))
        y += sign(vsp);
    vsp = 0;
}
y += vsp;
#endregion

// Recalcula grounded APÓS as colisões para sprites e lógica de morte
var grounded_final = place_meeting(x, y + 1, obj_Block);

#region Sprites
switch (state)
{

case PlayerState.IDLE:
    // Canhão — mostra hold assim que Z é segurado
    if (weapon == WeaponType.GUN && (is_charging || gun_hold_timer > 0))
    {
        var _spr_hold = (facing==1) ? sprt_PlayerAtirouHoldEsq : sprt_PlayerAtirouHoldDir;

        // Só atribui sprite_index se ainda não está nela — evita resetar image_index
        if (sprite_index != _spr_hold)
        {
            sprite_index = _spr_hold;
            image_speed  = 0;
            image_index  = 0;
        }

        if (!is_charging)
        {
            // Delay (0-60 frames) — avança frames 0 ao 2 (posicionamento)
            image_index = lerp(0, 2, gun_hold_timer / 60);
        }
        else if (gun_charge < gun_max_charge)
        {
            image_index = 2 + (gun_charge / (gun_max_charge - 1)) * 52;
        }
        else
        {
            // Charge 100% (vermelho) — loop entre frames 55 e 65
            image_index += 0.30;
            if (image_index >= 66)
                image_index = 55;
        }
    }
    else
    {
        switch (weapon)
        {
            case WeaponType.BASIC: sprite_index = (facing==1) ? sprt_PlayerIdleEsq       : sprt_PlayerIdleDir;       break;
            case WeaponType.SWORD: sprite_index = (facing==1) ? sprt_PlayerIdleEspadaDir : sprt_PlayerIdleEspadaEsq; break;
            case WeaponType.GUN:   sprite_index = (facing==1) ? sprt_PlayerIdleCanhaoEsq : sprt_PlayerIdleCanhaoDir; break;
        }
        image_speed = image_number / 8;
    }
break;

case PlayerState.RUN:
    switch (weapon)
    {
        case WeaponType.BASIC: sprite_index = (facing==1) ? sprt_PlayerRunEsq       : sprt_PlayerRunDir;       break;
        case WeaponType.SWORD: sprite_index = (facing==1) ? sprt_PlayerRunEspadaEsq : sprt_PlayerRunEspadaDir; break;
        case WeaponType.GUN:   sprite_index = (facing==1) ? sprt_PlayerRunCanhaoEsq : sprt_PlayerRunCanhaoDir; break;
    }
    image_speed = image_number / 8;
break;

case PlayerState.AIR:
    if (on_wall != 0 && vsp > 0 && weapon == WeaponType.BASIC)
    {
        sprite_index = (on_wall==1) ? sprt_PlayerWallSlideDir : sprt_PlayerWallSlideEsq;
		image_speed = image_number / 6;
    }
    else
    {
        switch (weapon)
        {
            case WeaponType.BASIC: sprite_index = (facing==1) ? sprt_PlayerJumpandFallEsq       : sprt_PlayerJumpandFallDir;       break;
            case WeaponType.SWORD: sprite_index = (facing==1) ? sprt_PlayerJumpandfallEspadaEsq : sprt_PlayerJumpandfallEspadaDir; break;
            case WeaponType.GUN:   sprite_index = (facing==1) ? sprt_PlayerJumpandFallCanhaoEsq : sprt_PlayerJumpandFallCanhaoDir; break;
        }
        image_speed = image_number / 8;
    }
break;

case PlayerState.DASH:
    switch (weapon)
    {
        case WeaponType.BASIC: sprite_index = (facing==1) ? sprt_PlayerDashEsq       : sprt_PlayerDashDir;       break;
        case WeaponType.SWORD: sprite_index = (facing==1) ? sprt_PlayerDashEspadaEsq : sprt_PlayerDashEspadaDir; break;
        case WeaponType.GUN:   sprite_index = (facing==1) ? sprt_PlayerDashCanhaoEsq : sprt_PlayerDashCanhaoDir; break;
    }
	image_speed = image_number / 4;
break;

case PlayerState.ATTACK:
    if (weapon == WeaponType.BASIC)
    {
        switch (attack_type)
        {
            case 1: sprite_index = (facing==1) ? sprt_PlayerSocoFrenteEsq      : sprt_PlayerSocoFrenteDir;      break;
            case 2: sprite_index = (facing==1) ? sprt_PlayerSocoFrenteEsq      : sprt_PlayerSocoFrenteDir;      break;
            case 3: sprite_index = (facing==1) ? sprt_PlayerChuteBaixoEsq      : sprt_PlayerChuteBaixoDir;      break;
            case 4: sprite_index = (facing==1) ? sprt_PlayerAtaqueGiratorioEsq : sprt_PlayerAtaqueGiratorioDir; break;
			case 5: sprite_index = (facing==1) ? sprt_PlayerSuperGiratorioEsq : sprt_PlayerSuperGiratorioDir; break;
        }
		image_speed = image_number / 6;
    }

    if (weapon == WeaponType.SWORD)
    {
        switch (attack_type)
        {
            case 1:
            case 2:
                sprite_index = (facing==1) ? sprt_PlayerAtaqueEspadaEsq : sprt_PlayerAtaqueEspadaDir;
                image_speed = image_number / 4;
            break;

            case 3:
                sprite_index = (facing==1) ? sprt_PlayerAtaqueLoucoEspadaEsq : sprt_PlayerAtaqueLoucoEspadaDir;
                image_speed = image_number / 8;
            break;
        }
    }

    if (weapon == WeaponType.GUN)
    {
        sprite_index = (facing==1) ? sprt_PlayerAtirouEsq : sprt_PlayerAtirouDir;
        image_speed = image_number / 4;
    }
break;

case PlayerState.HIT:
    switch (weapon)
    {
        case WeaponType.BASIC: sprite_index = (facing==1) ? sprt_PlayerHitEsq : sprt_PlayerHitDir; break;
        case WeaponType.SWORD: sprite_index = (facing==1) ? sprt_PlayerHitEsqEspada : sprt_PlayerHitDirEspada; break;
        case WeaponType.GUN:   sprite_index = (facing==1) ? sprt_PlayerHitEsqCanhao : sprt_PlayerHitDirCanhao; break;
    }
    image_speed = image_number / hit_duration;
break;

case PlayerState.DEATH:
    if (!grounded_final || death_timer <= 10) {
        sprite_index = (facing == 1) ? sprt_PlayerDeathEsq : sprt_PlayerDeathDir;
        image_speed  = 0.4;
    } else {
        switch (weapon)
        {
            case WeaponType.BASIC: sprite_index = (facing==1) ? sprt_PlayerDownEsq         : sprt_PlayerDownDir;         break;
            case WeaponType.SWORD: sprite_index = (facing==1) ? sprt_PlayerDownEsqEspada   : sprt_PlayerDownDirEspada;   break;
            case WeaponType.GUN:   sprite_index = (facing==1) ? sprt_PlayerDownCanhaoEsq   : sprt_PlayerDownCanhaoDir;   break;
        }
        image_speed = 0;
        image_index = 0;
    }
break;

}
#endregion

/// Define attack_type com base na arma e tecla pressionada
function _setAttackType(_wpn, _atk, _kick, _spin)
{
    switch (_wpn)
    {
		case WeaponType.BASIC:
		    if (_atk)
		    {
		        combo_step += 1;
		        combo_timer = combo_max_time;
		        if (combo_step > 2) combo_step = 1;
		        attack_type = combo_step;
		        combo_zx_ready = true; 
		        combo_zx_timer = combo_zx_window;
		    }
		    if (_kick)
		    {
		        if (combo_zx_ready && combo_zx_timer > 0) 
		        {
		            attack_type = 5;
		            combo_zx_ready = false;
		            combo_zx_timer = 0;
		        }
		        else
		        {
		            attack_type = 3; // chute normal
		        }
		    }
		    if (_spin) attack_type = 4;
		break;

        case WeaponType.SWORD:
            if (_atk)
            {
                combo_step += 1;
                combo_timer = combo_max_time;
                if (combo_step > 2) combo_step = 1;
                attack_type = combo_step;
            }
            if (_kick) attack_type = 3;
            // sem _spin aqui
        break;
    }
}

/// Aplica dano em inimigos dentro de um retângulo relativo ao player
function _hitEnemies(_x1, _y1, _x2, _y2, _dmg)
{
    var rx1 = x + min(_x1, _x2);
    var rx2 = x + max(_x1, _x2);
    var ry1 = y + _y1;
    var ry2 = y + _y2;

    var _hit = collision_rectangle(rx1, ry1, rx2, ry2, obj_InimigoPai, true, true);
    if (_hit != noone)
        with (_hit) { takeDamage(_dmg, other.facing); }
}

#region Sons
if (state == PlayerState.RUN) {    
        // correr
        if (som_atual != snd_passos_terra) {
			 
            audio_stop_sound(som_atual);
            som_atual = snd_passos_terra;
            audio_play_sound(snd_passos_terra, 1, true);
        }
} else {
    // parou de andar
    if (som_atual != noone) {
        audio_stop_sound(som_atual);
        som_atual = noone;
    }
}
if (keyboard_check_pressed(vk_shift) && can_dash && dash_cooldown_timer <= 0) {
    audio_play_sound(snd_dash, 10, false);
}

if (place_meeting(x, y, obj_Moedas) || place_meeting(x, y, obj_PotionLife)) {
    if (!audio_is_playing(snd_pegarItem)) {
        audio_play_sound(snd_pegarItem, 2, false);
    }
}

if (state == PlayerState.HIT && hit_timer == hit_duration){
	var hitSound = choose(snd_hit,snd_hitnovoice);
	audio_play_sound(hitSound,2,false);
}
#endregion