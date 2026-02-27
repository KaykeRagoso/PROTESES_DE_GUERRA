var base_w = 1280;
var base_h = 720;
var escala_x = display_get_gui_width()  / base_w;
var escala_y = display_get_gui_height() / base_h;
var _x = 50  * escala_x;
var _y = 640 * escala_y;

draw_sprite_ext(spr_pocaovida, 0, _x, _y, escala_x, escala_y, 0, c_white, 1);

draw_set_color(c_white);
draw_set_halign(fa_left);
draw_set_font(fnt_hud_vida_porc);
// Escala mínima de 1.5 pra não ficar pequeno demais
var escala_texto = max(escala_x, 1.5);
draw_text_transformed(_x + 40 * escala_x, _y - 10 * escala_y, "x" + string(global.pocoes), escala_texto, escala_texto, 0);