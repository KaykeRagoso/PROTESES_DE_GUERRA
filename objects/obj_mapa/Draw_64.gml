if (animacao <= 0.01) exit; // Não desenha nada se estiver totalmente fechado

// Configurações de posição centralizada
var _centro_x = display_get_gui_width() / 2;
var _centro_y = display_get_gui_height() / 2;

// O tamanho atual depende da animação para dar efeito de "zoom"
var _w = largura_alvo * animacao;
var _h = altura_alvo * animacao;
var _x1 = _centro_x - (_w / 2);
var _y1 = _centro_y - (_h / 2);

// 1. Fundo da Aba (Escuro com transparência)
draw_set_alpha(animacao * 0.9);
draw_set_color(c_black);
draw_rectangle(_x1, _y1, _x1 + _w, _y1 + _h, false);

// 2. Borda da Aba
draw_set_color(c_white);
draw_rectangle(_x1, _y1, _x1 + _w, _y1 + _h, true);

// 3. Desenhar o conteúdo (Somente se a aba estiver quase toda aberta)
if (animacao > 0.5) {
    var _offset_x = _x1;
    var _offset_y = _y1;
    
    // Desenha as Paredes
    draw_set_color(c_white);
    with (obj_Block) {
        draw_rectangle(_offset_x + (x * other.escala_mapa), 
                       _offset_y + (y * other.escala_mapa), 
                       _offset_x + ((x + sprite_width) * other.escala_mapa), 
                       _offset_y + ((y + sprite_height) * other.escala_mapa), false);
    }
    
    // Desenha Inimigos
    draw_set_color(c_red);
    with (obj_InimigoPai) {
        draw_circle(_offset_x + (x * other.escala_mapa), _offset_y + (y * other.escala_mapa), 4, false);
    }
    
    // Desenha o Player (Piscando)
    var _cor_player = make_color_rgb(255, 255, 0);
    draw_set_color(_cor_player);
    if (instance_exists(obj_Player)) {
        var _px = _offset_x + (obj_Player.x * other.escala_mapa);
        var _py = _offset_y + (obj_Player.y * other.escala_mapa);
        draw_circle(_px, _py, 6, false);
    }
}

draw_set_alpha(1); // Reset do alpha