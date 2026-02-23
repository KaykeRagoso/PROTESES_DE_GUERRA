// 1. Garante que a superfície existe
if (!surface_exists(luz_surface)) {
    luz_surface = surface_create(640, 360); // Use a resolução da sua câmera
}

// 2. Desenha na superfície
surface_set_target(luz_surface);
    
    // Pinta a tela de preto (a escuridão)
    draw_clear_alpha(c_black, escuridao_alfa);
    
    // Define o modo de "subtração" (fura a escuridão)
    gpu_set_blendmode(bm_subtract);
    
    // LUZ DO PLAYER: Segue o jogador
    if (instance_exists(obj_Player)) {
        // O valor 1.2 no scale faz a luz ser discreta. 0.8 a 1.2 é o ideal.
        draw_sprite_ext(spr_luz_suave, 0, obj_Player.x - camera_get_view_x(view_camera[0]), obj_Player.y - camera_get_view_y(view_camera[0]), 1.2, 1.2, 0, c_white, 1);
    }
    
    // LUZES DE AMBIENTE (Ex: Poste ou Amuleto)
    // Você pode fazer um 'with' para desenhar luz em todos os inimigos ou tochas
    /*
    with(obj_inimigo) {
        draw_sprite_ext(spr_luz_suave, 0, x - camera_get_view_x(view_camera[0]), y - camera_get_view_y(view_camera[0]), 0.5, 0.5, 0, c_white, 0.5);
    }
    */

    gpu_set_blendmode(bm_normal); // Volta ao normal

surface_reset_target();

// 3. Desenha a superfície final na tela
draw_surface(luz_surface, camera_get_view_x(view_camera[0]), camera_get_view_y(view_camera[0]));