//aaz a barra branca diminuir com deley até alcançar a vida atual
if (vida_delay > global.vida_atual) {
    vida_delay -= 0.5; // Velocidade da descida da barra branca (só se quiser mais rápido ou mais devagar)
} else {
    vida_delay = global.vida_atual;
}
//exemplo de quando o player toma dano

if (keyboard_check_pressed(vk_f1)){ {
    global.vida_atual -= 10;
    instance_create_layer(0, 0, "Instances", obj_flash_dano);
}
}
//garantir que a vida não fique negativa
global.vida_atual = clamp(global.vida_atual, 0, global.vida_max);

if (global.vida_atual <= 0) {
    //cria o objeto de Game Over se ele ainda não existir
    if (!instance_exists(obj_game_over)) {
        instance_create_layer(0, 0, "Instances", obj_game_over);
        room_speed = 30;
    }else{
		room_speed = real
	}
  
    instance_destroy(); 
}