#region Input
var key_left  = keyboard_check(ord("A")) || keyboard_check(vk_left);
var key_right = keyboard_check(ord("D")) || keyboard_check(vk_right);
var key_jump  = keyboard_check_pressed(vk_space) 
             || keyboard_check_pressed(vk_up);
var key_dash  = keyboard_check_pressed(vk_shift);

var move = key_right - key_left;
#endregion

#region Detecções
// DETECÇÕES 
var grounded = place_meeting(x, y + 1, obj_Block);

var wall_r = place_meeting(x + 1, y, obj_Block);
var wall_l = place_meeting(x - 1, y, obj_Block);

on_wall = 0;
if (wall_r) on_wall = 1;
if (wall_l) on_wall = -1;
#endregion

#region State Machine
// STATE MACHINE
switch (state)
{
    case PlayerState.IDLE:
        
        hsp = move * walksp;
        
        if (move != 0)
        {
            facing = move;
            image_xscale = facing;
            state = PlayerState.RUN;
        }
        
        if (!grounded)
        {
            state = PlayerState.AIR;
        }
        
        if (key_jump && grounded)
        {
            vsp = jump_force;
            state = PlayerState.AIR;
        }
        
        if (key_dash && can_dash)
        {
            state = PlayerState.DASH;
        }
        
    break;
    
    
    case PlayerState.RUN:
        
        hsp = move * walksp;
        
        if (move != 0)
        {
            facing = move;
            image_xscale = facing;
        }
        else
        {
            state = PlayerState.IDLE;
        }
        
        if (!grounded)
        {
            state = PlayerState.AIR;
        }
        
        if (key_jump)
        {
            vsp = jump_force;
            state = PlayerState.AIR;
        }
        
        if (key_dash && can_dash)
        {
            state = PlayerState.DASH;
        }
        
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
            {
                facing = move;
                image_xscale = facing;
            }
        }
        
        // Wall slide
        if (on_wall != 0 && vsp > 0)
        {
            vsp = min(vsp, wall_speed_limit);
        }
        
        // Wall jump
        if (on_wall != 0 && key_jump)
        {
            vsp = jump_force;
            hsp = -on_wall * walksp * 2.5;
            facing = -on_wall;
            image_xscale = facing;
            control_lock = 12;
        }
        
        if (grounded)
        {
            can_dash = true;
            state = PlayerState.IDLE;
        }
        
        if (key_dash && can_dash)
        {
            state = PlayerState.DASH;
        }
        
    break;
    
    
    case PlayerState.DASH:
        
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
        }
        
    break;
}
#endregion

#region Colisões

<<<<<<< HEAD
if (on_wall != 0 && !grounded) 
{
    if (vsp > 0) vsp = min(vsp, wall_speed_limit); //desliza devagar
}

//logica do pulo
if (grounded) 
{
    control_lock = 0; //reseta trava ao tocar o chão
    if (key_jump) vsp = jump_force;
} 
else if (on_wall != 0 && key_jump) 
{
    //o pulo na parede
    vsp = jump_force;
	audio_play_sound(snd_wall_jump, 10, false);
	//particulas pulo
        //determina se a poeira sai para a esquerda ou direita
        var lado_parede = place_meeting(x + 1, y, obj_Block) ? 1 : -1;
        
        
        part_particles_create(part_sys, x + (10 * lado_parede), y, part_dust, 10);
    hsp = -on_wall * (walksp * 2.5); //joga pro lado oposto com força
    control_lock = 12;            //trava o input por 12 frames
    image_xscale = -on_wall;       //vira o personagem para o lado oposto(n vai precisar eu acho)
}

// 6. colisões
=======
// Horizontal
>>>>>>> 750748dd30c450b9b68b605f0abf1b45dd7d5b04
if (place_meeting(x + hsp, y, obj_Block)) {
    while (!place_meeting(x + sign(hsp), y, obj_Block)) {
        x += sign(hsp);
    }
    hsp = 0;
}
x += hsp;

// Vertical
if (place_meeting(x, y + vsp, obj_Block)) {
    while (!place_meeting(x, y + sign(vsp), obj_Block)) {
        y += sign(vsp);
    }
    vsp = 0;
}
y += vsp;
<<<<<<< HEAD

	

/// cara deiei tudo escrito no codigo pra ajudar vc caso vc precise mecher em alguma ;)
=======
#endregion
>>>>>>> 750748dd30c450b9b68b605f0abf1b45dd7d5b04
