// Aumenta o escurecimento da tela gradualmente
alpha = min(alpha + 0.02, 1);

// Lógica de piscar
if (pode_reiniciar) {
    blink_timer++;
    if (blink_timer >= blink_speed * 2) {
        blink_timer = 0;
    }
    
    // Detecta input para reiniciar
    if keyboard_check_pressed(ord("R")) {
        show_debug_message("VOLTANDO PARA O MENU");

        global.vida_atual = 100;
        global.vida_max = 100;
        
        if (instance_exists(obj_Dialogo)) {
            obj_Dialogo.dialogo_ativo = false;
            obj_Dialogo.linhas = [];
            obj_Dialogo.linha_atual = 0;
            obj_Dialogo.npc_dono = noone;
        }
		    with (obj_Player) instance_destroy();
			
        instance_destroy();
        room_goto(menu); // volta para o menu
    }
}