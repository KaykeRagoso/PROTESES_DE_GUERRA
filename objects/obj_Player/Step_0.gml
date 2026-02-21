//inputs
var key_left  = keyboard_check(ord("A")) || keyboard_check(vk_left);
var key_right = keyboard_check(ord("D")) || keyboard_check(vk_right);
var key_jump  = keyboard_check_pressed(vk_space) || keyboard_check(vk_up);

//verificando chão e parede
var grounded = place_meeting(x, y + 1, obj_Block);
var on_wall  = place_meeting(x + 1, y, obj_Block) - place_meeting(x - 1, y, obj_Block);

//controle de mov com trava do wall jump
if (control_lock > 0) 
{
    control_lock -= 1; //reduz o tempo de trava
    // enquanto estiver travado, o hsp não é resetado pelos botões A/D
} 
else 
{
    var move = key_right - key_left;
    hsp = move * walksp;
    
    //inverte o sprite conforme a direção mas acho que nn vai usar ne o sprite tem que ter dois lado
    if (move != 0) image_xscale = move;
}

//gravidade e wall slide
vsp += grv;

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
    hsp = -on_wall * (walksp * 2.5); //joga pro lado oposto com força
    control_lock = 12;            //trava o input por 12 frames
    image_xscale = -on_wall;       // Vira o personagem para o lado oposto(n vai precisar eu acho)
}

// 6. colisões
if (place_meeting(x + hsp, y, obj_Block)) {
    while (!place_meeting(x + sign(hsp), y, obj_Block)) x += sign(hsp);
    hsp = 0;
}
x += hsp;

if (place_meeting(x, y + vsp, obj_Block)) {
    while (!place_meeting(x, y + sign(vsp), obj_Block)) y += sign(vsp);
    vsp = 0;
}
y += vsp;

/// cara deiei tudo escrito no codigo pra ajudar vc caso vc precise mecher em alguma ;)
