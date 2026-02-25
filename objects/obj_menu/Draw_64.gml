// --- FUNDO COM PARALLAX ---
draw_set_alpha(alpha * 0.3);
draw_set_color(c_black);
draw_rectangle(0, 0, gui_w, gui_h, false);

// --- TÍTULO DO JOGO (COM GLITCH) ---
draw_set_alpha(alpha);
draw_set_font(fnt_titulo); // Use uma fonte bem grande
draw_set_halign(fa_left);

var title_y = 120;
// Efeito de sombra fantasma (ciano e vermelho)
draw_set_color(c_aqua);
draw_text(100 + menu_x_offset + random_range(-2, 2), title_y, "PROJECT: CHRONOS");
draw_set_color(c_red);
draw_text(100 + menu_x_offset + random_range(-2, 2), title_y, "PROJECT: CHRONOS");
//título Principal
draw_set_color(c_white);
draw_text(100 + menu_x_offset, title_y, "PROJECT: CHRONOS");

//opcoes
for (var i = 0; i < array_length(menu_options); i++) {
    var bx = 100 + menu_x_offset + button_x[i];
    var by = 300 + (i * 70);
    
    //linha decorativa ao lado do botão selecionado
    if (index == i) {
        draw_set_color(c_aqua);
        draw_rectangle(bx - 20, by, bx - 15, by + 40, false);
        draw_set_alpha(button_glow[i] * 0.5);
        draw_rectangle(bx - 10, by, bx + 400, by + 40, false); // Glow de fundo
    }
    
    draw_set_alpha(alpha);
    draw_set_color((index == i) ? c_white : c_gray);
    draw_set_font(fnt_menu);
    draw_text(bx, by, menu_options[i]);
}

//detalhes hud
draw_set_color(c_aqua);
draw_set_alpha(0.2 * alpha);
draw_rectangle(20, 20, gui_w - 20, gui_h - 20, true); // Borda da tela
draw_text(gui_w - 250, gui_h - 50, "");
draw_set_alpha(1);