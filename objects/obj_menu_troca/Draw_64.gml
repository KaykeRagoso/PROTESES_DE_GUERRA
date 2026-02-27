var _gui_w = display_get_gui_width();
var _gui_h = display_get_gui_height();
draw_set_font(fnt_troca)
// 1. FUNDO DO MENU
draw_set_color(c_black);
draw_set_alpha(0.8);
draw_rectangle(0, 0, _gui_w, _gui_h, false);
draw_set_alpha(1);

// 2. LISTA DE OPÇÕES (ESQUERDA)
for (var i = 0; i < array_length(opcoes); i++) {
    var _cor = (selecionado == i) ? c_yellow : c_white;
    draw_set_color(_cor);
    draw_text(100, 200 + (i * 50), opcoes[i]);
}

// 3. DETALHES E CUSTOS (CENTRO/ABAIXO)
var _meu_custo = custos[selecionado];
draw_set_halign(fa_center);

// Checagem de cores para os requisitos
var _c_sucata = (global.sucata_tech >= _meu_custo[0]) ? c_white : c_red;
var _c_chip   = (global.chips_dados >= _meu_custo[1]) ? c_white : c_red;
var _c_nucleo = (global.nucleos_energia >= _meu_custo[2]) ? c_white : c_red;

if (_meu_custo[0] > 0) draw_text_color(_gui_w/2, 400, "Sucatas: " + string(_meu_custo[0]), _c_sucata, _c_sucata, _c_sucata, _c_sucata, 1);
if (_meu_custo[1] > 0) draw_text_color(_gui_w/2, 430, "Chips: " + string(_meu_custo[1]), _c_chip, _c_chip, _c_chip, _c_chip, 1);
if (_meu_custo[2] > 0) draw_text_color(_gui_w/2, 460, "Núcleos: " + string(_meu_custo[2]), _c_nucleo, _c_nucleo, _c_nucleo, _c_nucleo, 1);

// BOTÃO TROCAR
draw_rectangle_color(_gui_w/2 - 50, 500, _gui_w/2 + 50, 540, c_dkgray, c_dkgray, c_black, c_black, false);
draw_set_color(c_white);
draw_text(_gui_w/2, 510, "TROCAR (ENTER)");

// 4. PREVIEW DO ITEM (DIREITA EM ESCALA)
var _spr_preview = spr_pocaovida; // Substitua pelos seus sprites
if (selecionado == 1) _spr_preview = spr_mochila;
if (selecionado == 2) _spr_preview = spr_espada_up;

draw_sprite_ext(_spr_preview, 0, _gui_w - 200, _gui_h/2, 4, 4, 0, c_white, 1);

// 5. INVENTÁRIO ATUAL (CANTO SUPERIOR)
draw_set_halign(fa_right);
draw_text(_gui_w - 20, 20, "SEUS RECURSOS:");
draw_text(_gui_w - 20, 40, "Sucatas: " + string(global.sucata_tech));
draw_text(_gui_w - 20, 60, "Chips: " + string(global.chips_dados));
draw_text(_gui_w - 20, 80, "Núcleos: " + string(global.nucleos_energia));
draw_set_halign(fa_left);