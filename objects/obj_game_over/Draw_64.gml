// Fundo preto
draw_set_alpha(alpha);
draw_set_color(c_black);
draw_rectangle(0, 0, display_get_gui_width(), display_get_gui_height(), false);

// Texto da morte
if (alpha > 0.5) {
    draw_set_alpha(1);
    draw_set_color(c_red);
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    
    // Texto principal
    draw_text_transformed(
        display_get_gui_width()/2, 
        display_get_gui_height()/2 - 20, 
        "A GUERRA CONTINUA SEM VOCE...", 
        2, 2, 0
    );
    
    // Subtexto piscando
    if (pode_reiniciar && blink_timer < blink_speed) {
        draw_set_color(c_white);
        draw_text(
            display_get_gui_width()/2, 
            display_get_gui_height()/2 + 40, 
            "Pressione 'R' para tentar novamente"
        );
    }
}

// Reseta configurações de draw
draw_set_alpha(1);
draw_set_color(c_white);
draw_set_halign(fa_left);
draw_set_valign(fa_top);