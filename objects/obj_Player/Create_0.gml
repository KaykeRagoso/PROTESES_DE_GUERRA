//input
hsp = 0; 
vsp = 0; 
grv = 0.4; //gravidade
walksp = 4; //velocidade de caminhada
jump_force = -9;

//dash
can_dash = true;
dashing = false;
dash_duration = 10; //frames
dash_timer = 0;
dash_sp = 10;

//wall Jump
wall_speed_limit = 2;
on_wall = 0;
control_lock = 0; //timer para travar o input horizontal


// Criar o Sistema
part_sys = part_system_create();

//partícula de poeira
part_dust = part_type_create();
part_type_sprite(part_dust, spr_pixel, false, false, false); //usa um sprite de 1x1 ou 2x2
part_type_size(part_dust, 1, 2, -0.05, 0);
part_type_color1(part_dust, c_gray);
part_type_alpha2(part_dust, 0.8, 0);
part_type_speed(part_dust, 1, 3, 0, 0);
part_type_direction(part_dust, 0, 360, 0, 0);
part_type_life(part_dust, 10, 20);