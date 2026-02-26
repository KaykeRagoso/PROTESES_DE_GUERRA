if (instance_exists(alvo)) {
    // Calcula a posição ideal (X no centro, Y um pouco acima)
    var _x_destino = alvo.x - largura_view / 2;
    var _y_destino = (alvo.y + offset_y) - altura_view / 2;

    // LERP para o delayzinho (suavização)
    var _cur_x = camera_get_view_x(camera);
    var _cur_y = camera_get_view_y(camera);

    var _final_x = lerp(_cur_x, _x_destino, suavidade);
    var _final_y = lerp(_cur_y, _y_destino, suavidade);

    // Aplica a posição na câmera
    camera_set_view_pos(camera, _final_x, _final_y);
}

// ATALHO PARA TELA CHEIA (F11 ou F)
if (keyboard_check_pressed(vk_f11)) {
    if (window_get_fullscreen()) {
        window_set_fullscreen(false);
        // Reseta o tamanho da superfície para não bugar ao voltar
        surface_resize(application_surface, largura_view * escala_janela, altura_view * escala_janela);
    } else {
        window_set_fullscreen(true);
        // Ajusta a superfície para a resolução total do monitor
        surface_resize(application_surface, display_get_width(), display_get_height());
    }
}