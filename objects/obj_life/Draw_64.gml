if (!instance_exists(obj_Player) || obj_Player.state != PlayerState.DEATH) {
	
    // Resolução base do seu jogo (muda pra resolução que você usa)
    var base_w = 1280;
    var base_h = 720;
	
    // Escala baseada na tela atual
    var escala_x = display_get_gui_width()  / base_w;
    var escala_y = display_get_gui_height() / base_h;
	
    // Posição e tamanho escalados
    var gx = 50 * escala_x;
    var gy = 47 * escala_y;
    var barra_w = barra_largura * escala_x;
    var barra_h = (barra_altura  * escala_y);
	
    // Fundo da barra
    draw_set_color(c_black);
    draw_rectangle(gx, gy, gx + barra_w + 2, gy + barra_h, false);
	
    // Barra de delay branca
    var largura_delay = (vida_delay / global.vida_max) * barra_w;
    draw_set_color(c_white);
    draw_rectangle(gx, gy, gx + largura_delay, gy + barra_h, false);
	
    // Barra de vida vermelha
    var largura_vida = (global.vida_atual / global.vida_max) * barra_w;
    draw_set_color(c_red);
    draw_rectangle(gx, gy + 2, gx + largura_vida, gy + barra_h, false);
	
    // Borda sprite
    draw_sprite_ext(spr_borda_vida, 0, gx, gy, escala_x, escala_y, 0, c_white, 1);
	
    // Texto de vida
    var _x = 63 * escala_x;
    var _y = (35 + 40) * escala_y;
    draw_set_color(c_white);
    draw_set_font(fnt_hud_vida_porc);
    var escala_texto_vida = escala_x * 0.60; // ajusta o 0.5 até ficar do tamanho certo
    draw_text_transformed(_x - 4, _y + 2, string(global.vida_atual) + "/" + string(global.vida_max), escala_texto_vida, escala_texto_vida, 0);
    draw_set_color(c_white);
}
