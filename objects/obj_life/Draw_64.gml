var gx = 50; //posição x na tela
var gy = 47; //posição y na tela

//desenhando o Fundo da Barra
draw_set_color(c_black);
draw_rectangle(gx, gy, gx + barra_largura + 2, gy + barra_altura, false);

//desenha a Barra de deley branca
// ela fica por baixo da barra principal
var largura_delay = (vida_delay / global.vida_max) * barra_largura;
draw_set_color(c_white);
draw_rectangle(gx, gy, gx + largura_delay, gy + barra_altura, false);

//desenhando a Barra de vida de vrdd (vermelha até agr)
var largura_vida = (global.vida_atual / global.vida_max) * barra_largura;
draw_set_color(c_red); //cor dela
draw_rectangle(gx, gy, gx + largura_vida, gy + barra_altura, false);

//desenhando a borda (esse sprite vai ser uma pixelart que vai ser por cima que vou pedir pro andrey fzr)
draw_sprite(spr_borda_vida, 0, gx, gy); 

//resetar a cor para branco
draw_set_color(c_white);