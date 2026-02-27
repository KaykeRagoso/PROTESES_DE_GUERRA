if (!missao_ativa) exit;
if (instance_exists(obj_Player) && obj_Player.state == PlayerState.DEATH) exit;

var base_w   = 1280;
var base_h   = 720;
var escala_x = display_get_gui_width()  / base_w;
var escala_y = display_get_gui_height() / base_h;

// Dimensões da caixa
var caixa_w  = 280 * escala_x;
var caixa_h  = 120 * escala_x;
var margem   = 20  * escala_x;
var pad      = 10  * escala_x;

var bx = display_get_gui_width()  - caixa_w - margem;
var by = margem;

// Fundo
draw_set_alpha(0.75);
draw_set_color(c_black);
draw_rectangle(bx, by, bx + caixa_w, by + caixa_h, false);

// Borda — amarela se ativa, verde se completa
draw_set_alpha(1);
draw_set_color(missao_completa ? c_lime : c_yellow);
draw_rectangle(bx, by, bx + caixa_w, by + caixa_h, true);

draw_set_font(ft_gui);
draw_set_halign(fa_left);
draw_set_valign(fa_top);

// Nome da missão
draw_set_color(c_yellow);
draw_text_transformed(bx + pad, by + pad, missao_nome, escala_x * 0.75, escala_y * 0.75, 0);

// Linha separadora
var linha_y = by + pad + 22 * escala_y;
draw_set_color(c_gray);
draw_line(bx + pad, linha_y, bx + caixa_w - pad, linha_y);

// Objetivos
var obj_y = linha_y + 6 * escala_y;
draw_set_color(c_white);

if (objetivo_matar)
{
    var _progresso = string(inimigos_mortos) + "/" + string(inimigos_necessarios);
    var _cor_matar = (inimigos_mortos >= inimigos_necessarios) ? c_lime : c_white;
    draw_set_color(_cor_matar);
    draw_text_transformed(bx + pad, obj_y, "Inimigos: " + _progresso, escala_x * 0.65, escala_y * 0.65, 0);
    obj_y += 20 * escala_y;
}

if (objetivo_falar_npc)
{
    var _cor_npc = npc_alvo_falado ? c_lime : c_white;
    var _txt_npc = npc_alvo_falado ? "Falar com NPC: ✓" : "Falar com NPC: pendente";
    draw_set_color(_cor_npc);
    draw_text_transformed(bx + pad, obj_y, _txt_npc, escala_x * 0.65, escala_y * 0.65, 0);
    obj_y += 20 * escala_y;
}

// Status
var _status     = missao_completa ? "COMPLETA!" : "Em andamento";
var _cor_status = missao_completa ? c_lime : c_gray;
draw_set_color(_cor_status);
draw_set_halign(fa_right);
draw_text_transformed(bx + caixa_w - pad, by + caixa_h - pad - 12, _status, escala_x * 0.60, escala_y * 0.60, 0);

// Reseta padrões
draw_set_alpha(1);
draw_set_color(c_white);
draw_set_halign(fa_left);
draw_set_valign(fa_top);
