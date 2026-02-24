

//tamnho da caixa preta
var gui_largura = display_get_gui_width();
var gui_altura = display_get_gui_height();
var yy = gui_altura - 170; // padrao era 200
var xx = 0
// setando a caixa preta
draw_set_colour(c_black);
draw_rectangle(xx,yy,gui_largura, gui_altura, 0);
//fonte
draw_set_font(ft_gui)
draw_set_colour(c_white);

var texto_atual = string_copy(texto[index], 1, index_letra)

if(index_letra < string_width(texto[index])){
index_letra = index_letra + velocidade
}
draw_set_halign(fa_center)
draw_text((gui_largura / 2), yy +30, texto_atual); // o yy + é pra aumentar a altura, tava +30
draw_set_halign(-1)




