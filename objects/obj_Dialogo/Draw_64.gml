if (!dialogo_ativo) exit;

var base_w   = 1280;
var base_h   = 720;
var escala_x = display_get_gui_width()  / base_w;
var escala_y = display_get_gui_height() / base_h;

var bx = caixa_x * escala_x;
var by = caixa_y * escala_y;
var bw = caixa_w * escala_x;
var bh = caixa_h * escala_y;
var pd = padding * escala_x;

// Fundo da caixa
draw_set_alpha(1);
draw_set_color(c_black);
draw_rectangle(bx, by, bx + bw, by + bh, false);

// Borda
draw_set_alpha(1);
draw_set_color(c_white);
draw_rectangle(bx, by, bx + bw, by + bh, true);

// Nome do NPC
if (instance_exists(npc_dono))
{
    draw_set_color(c_yellow);
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
    draw_set_font(ft_gui);
    draw_text_transformed(bx + pd, by + pd * 0.5, npc_dono.npc_nome, escala_x * 1.0, escala_y * 1.0, 0);
}

// Texto da fala atual
if (array_length(linhas) > 0 && linha_atual < array_length(linhas))
{
    draw_set_color(c_white);
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
    draw_set_font(ft_gui);
    draw_text_ext(bx + pd, by + pd * 2, linhas[linha_atual], 8, bw - pd * 2);
}

// Indicador de continuar
var _total = array_length(linhas);
var _texto_continuar = (linha_atual >= _total - 1) ? "[ F para fechar ]" : "[ F para continuar ]";
draw_set_color(c_gray);
draw_set_halign(fa_right);
draw_set_valign(fa_bottom);
draw_text_transformed(bx + bw - pd, by + bh - pd * 0.5, _texto_continuar, escala_x * 0.65, escala_y * 0.65, 0);

// Reseta padrões
draw_set_alpha(1);
draw_set_color(c_white);
draw_set_halign(fa_left);
draw_set_valign(fa_top);
