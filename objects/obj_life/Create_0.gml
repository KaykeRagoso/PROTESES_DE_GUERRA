global.vida_max = obj_Player.max_hp;
global.vida_atual = obj_Player.hp;
vida_delay = global.vida_atual;
barra_largura = 200;
barra_altura = 20;
show_debug_message("vida_atual no create do obj_life: " + string(global.vida_atual));