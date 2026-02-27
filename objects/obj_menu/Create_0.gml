// Opções
menu_options = ["INICIAR", "CONFIGURAÇÕES", "CRÉDITOS/PRESETS", "SAIR"];
index = 0;

alpha = 0;
menu_x_offset = -100; //começa um pouco para a esquerda para deslizar
gui_w = display_get_gui_width();
gui_h = display_get_gui_height();

//controladores da animação individual dos botões
for (var i = 0; i < array_length(menu_options); i++) {
    button_x[i] = 0;      
    button_glow[i] = 0;   
}




input_modo = "teclado"; //começa no teclado por padrão
mouse_last_x = mouse_x;
mouse_last_y = mouse_y;

fade_alpha = 0;
fade_speed = 0.04;
iniciando = false;

// Confirmação de saída
confirmando_saida = false;
confirm_index = 0; // 0 = SIM | 1 = NÃO