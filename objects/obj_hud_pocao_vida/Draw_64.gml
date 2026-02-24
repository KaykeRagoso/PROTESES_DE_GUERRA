var _x = 50;  // Posição X no canto da tela
var _y = 720;  // Posição Y no canto da tela

// Desenha o sprite da poção
// draw_sprite(sprite, subimagem, x, y)

draw_sprite(spr_pocaovida, 0, _x, _y);

// Configura a fonte e cor para o texto
draw_set_color(c_white);
draw_set_halign(fa_left);

// Desenha a quantidade ao lado do sprite
draw_set_font(ft_gui)
draw_text(_x + 40, _y - 10, "x" + string(global.pocoes));

