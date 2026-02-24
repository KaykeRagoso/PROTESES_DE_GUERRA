#region INPUT
var key_left  = keyboard_check(ord("A")) || keyboard_check(vk_left);
var key_right = keyboard_check(ord("D")) || keyboard_check(vk_right);
var key_jump  = keyboard_check_pressed(vk_space) || keyboard_check_pressed(vk_up);
var key_dash  = keyboard_check_pressed(vk_shift);

var move = key_right - key_left;
#endregion


#region DETECÇÕES
var grounded = place_meeting(x, y + 1, obj_Block);

var wall_r = place_meeting(x + 1, y, obj_Block);
var wall_l = place_meeting(x - 1, y, obj_Block);

on_wall = 0;
if (wall_r) on_wall = 1;
if (wall_l) on_wall = -1;
#endregion


#region STATE MACHINE

switch (state)
{
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
        
		// Tira a opção de quando tá parado
        //if (key_dash && can_dash)
        //    state = PlayerState.DASH;
        
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
        
    break;
    
    
    case PlayerState.AIR:
        
        // Gravidade
        vsp += grv;
        
        // Controle aéreo
        if (control_lock > 0)
        {
            control_lock--;
        }
        else
        {
            hsp = move * walksp;
            if (move != 0)
                facing = move;
        }
        
        // Wall slide
        if (on_wall != 0 && vsp > 0)
            vsp = min(vsp, wall_speed_limit);
        
        // Wall jump
        if (on_wall != 0 && key_jump)
        {
            vsp = jump_force;
            hsp = -on_wall * walksp * 2.5;
            facing = -on_wall;
            control_lock = 12;
            
            audio_play_sound(snd_wall_jump, 10, false);
            
            var lado_parede = on_wall;
            part_particles_create(part_sys, x + (10 * lado_parede), y, part_dust, 10);
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

	    // Inicializa delay
	    if (!variable_instance_exists(id, "dash_delay_timer"))
	        dash_delay_timer = 8; // 8 frames de delay antes do dash

	    // Se ainda está no delay, trava movimento
	    if (dash_delay_timer > 0)
	    {
	        dash_delay_timer--;
	        hsp = 0;
	        vsp = 0;
	    }
	    else
	    {
	        // Inicia o dash real
	        if (dash_timer <= 0)
	        {
	            dash_timer = dash_duration;
	            can_dash = false;
	        }

	        vsp = 0;
	        hsp = facing * dash_sp;

	        dash_timer--;

	        // Ao final, volta para o estado AIR
	        if (dash_timer <= 0)
	        {
	            state = PlayerState.AIR;
	            dash_delay_timer = undefined; // reseta o delay para o próximo dash
	        }
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


#region Sprites
// Direção visual centralizada
if (facing != 0)
    image_xscale = facing;
switch (state)
{
    case PlayerState.IDLE:
        sprite_index = sprt_PlayerIdle;
        image_speed = image_number / 2;
    break;
    
    case PlayerState.RUN:
        sprite_index = sprt_PlayerRun;
        image_speed = image_number / 3;
    break;
    
    case PlayerState.AIR:
	
        
        if (on_wall != 0 && vsp > 0)
        {
            sprite_index = sprt_PlayerJumpHold;
            image_speed = image_number / 1;
			image_xscale = -on_wall;

        }
        else if (vsp < 0)
        {
            sprite_index = sprt_PlayerJump;
            image_speed = image_number / 3.5;
			image_xscale = facing;
			image_index = 0;
        }
        else
        {
            sprite_index = sprt_PlayerFall;
            image_speed = image_number / 2.5;
			image_xscale = facing;
        }
        
    break;
    
    case PlayerState.DASH:
        sprite_index = sprt_PlayerDash;
        image_speed = image_number / (dash_duration * 2);
    break;
}

#endregion
/*
if keyboard_check(ord("A")) or keyboard_check(ord("D"))  {
 
		layer_set_visible("efeito_correndo", true);
  
	
} else {
   
	 layer_set_visible("efeito_correndo", false);
	 
}
*/