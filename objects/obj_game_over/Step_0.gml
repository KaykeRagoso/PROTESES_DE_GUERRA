// Aumenta o escurecimento da tela gradualmente
alpha = min(alpha + 0.02, 1); 

// Reiniciar a fase e piscar texto
if (pode_reiniciar) {
    blink_timer++;
    if (blink_timer >= blink_speed * 2) {
        blink_timer = 0;
    }
    if (keyboard_check_pressed(ord("R")) || keyboard_check_pressed(vk_space)) {
        show_debug_message("RESTART CHAMADO");
        global.vida_atual = 100;
        global.vida_max   = 100;
        if (instance_exists(obj_Dialogo)) {
            obj_Dialogo.dialogo_ativo = false;
            obj_Dialogo.linhas        = [];
            obj_Dialogo.linha_atual   = 0;
            obj_Dialogo.npc_dono      = noone;
        }
        instance_destroy();
        game_restart();
    }
}