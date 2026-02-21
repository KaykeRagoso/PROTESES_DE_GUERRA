//desenha o retângulo vermelho cobrindo a tela toda
draw_set_alpha(alpha);
draw_set_color(cor);
draw_rectangle(0, 0, display_get_gui_width(), display_get_gui_height(), false);
draw_set_alpha(1); //reseta o alpha para não afetar o resto do jogo
draw_set_color(c_white); //reseta a cor(se pá mais pela segurança)