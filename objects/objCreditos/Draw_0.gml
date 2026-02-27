// desenhar sprite de fundo
//draw_sprite(sprt_fundoCreditos, 0, 0, 0);

// escurecer levemente o fundo (opcional)
draw_set_color(c_black);
draw_set_alpha(0.6);
draw_rectangle(0, 0, room_width, room_height, false);
draw_set_alpha(1);

// título
draw_set_halign(fa_center);
draw_set_color(c_white);
draw_set_font(fnt_titulo);
draw_text(room_width/2, 80, "CRÉDITOS");

// créditos
draw_set_font(fnt_menu);

var _y = 150;
var espacamento = 30;

for (var i = 0; i < array_length(creditos); i++)
{
    var texto = creditos[i];
    
    if (texto == "DESENVOLVIMENTO" || texto == "ASSETS")
        draw_set_color(c_yellow);
    else
        draw_set_color(c_white);

    draw_text(room_width/2, _y + (i * espacamento), texto);
}

// sair
draw_set_color(c_gray);
draw_text(room_width/2, room_height - 40, "ESC - SAIR");