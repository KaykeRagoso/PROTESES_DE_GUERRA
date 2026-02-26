// Configura a transparência e a cor
draw_set_alpha(fade_alpha);
draw_set_color(c_black);

// Desenha o retângulo no tamanho da interface
draw_rectangle(0, 0, display_get_gui_width(), display_get_gui_height(), false);

// SEMPRE reseta o alpha para 1 para não deixar os outros objetos invisíveis
draw_set_alpha(1);
draw_set_color(c_white);