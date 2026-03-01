// ==========================================
// FUNDO ESCURO
// ==========================================
draw_set_alpha(alpha * 0.3);
draw_set_color(c_black);
draw_rectangle(0, 0, gui_w, gui_h, false);

// ==========================================
// Se estiver nas configurações
// ==========================================
if (em_config) {
    // Fundo da config
    draw_set_alpha(alpha);
    draw_set_color(c_black);
    //draw_rectangle(0, 0, gui_w, gui_h, false);
    
    // Título
    draw_set_alpha(alpha);
    draw_set_font(fnt_titulo);
    draw_set_halign(fa_center);
    draw_set_color(c_aqua);
    draw_text(gui_w/2, 80, "CONFIGURAÇÕES");
    
    // Opções
    draw_set_font(fnt_menu);
    draw_set_halign(fa_left);
    
    for (var i = 0; i < array_length(config_options); i++) {
        var cy = 200 + (i * 80);
        var focado = (config_index == i);
        
        // Indicador
        if (focado) {
            draw_set_color(c_aqua);
            draw_text(80, cy, "▶ ");
        } else {
            draw_set_color(c_gray);
            draw_text(80, cy, "  ");
        }
        
        // Opção
        draw_set_color(focado ? c_white : c_gray);
        draw_text(110, cy, config_options[i]);
        
        // Valores
        if (i < 3) {
            draw_set_color(focado ? c_aqua : c_gray);
            if (i == 2) {
                // Dificuldade
                draw_text(500, cy, config_dificuldade[config_values[2]]);
            } else {
                // Volume
                draw_text(500, cy, string(config_values[i]) + "%");
            }
        }
    }
    
    // Instruções
    draw_set_color(c_gray);
    draw_set_font(fnt_menu);
    draw_text(110, gui_h - 100, "SETAS para navegar | ESQUERDA/DIREITA para ajustar");
    draw_text(110, gui_h - 60, "ENTER para voltar | ESC para voltar");
    
    draw_set_alpha(1);
    exit;
}

// ==========================================
// TÍTULO COM GLITCH CONTROLADO (MENU PRINCIPAL)
// ==========================================
draw_set_alpha(alpha);
draw_set_font(fnt_titulo);
draw_set_halign(fa_left);
var title_y = 120;
var glitch = random_range(-2, 2);
draw_set_color(c_aqua);
draw_text(100 + menu_x_offset + glitch, title_y, "PRÓTESES DE GUERRA");
draw_set_color(c_red);
draw_text(100 + menu_x_offset - glitch, title_y, "PRÓTESES DE GUERRA");
draw_set_color(c_white);
draw_text(100 + menu_x_offset, title_y, "PRÓTESES DE GUERRA");

// ==========================================
// OPÇÕES DO MENU
// ==========================================
for (var i = 0; i < array_length(menu_options); i++) {
    var bx = 100 + menu_x_offset + button_x[i];
    var by = 300 + (i * 70);
    
    if (index == i) {
        // Linha lateral
        draw_set_alpha(alpha);
        draw_set_color(c_aqua);
        draw_rectangle(bx - 20, by, bx - 15, by + 40, false);
        // Glow
        draw_set_alpha(button_glow[i] * 0.5 * alpha);
        draw_rectangle(bx - 10, by, bx + 400, by + 40, false);
    }
    
    draw_set_alpha(alpha);
    draw_set_color((index == i) ? c_white : c_gray);
    draw_set_font(fnt_menu);
    var scale = 1 + (button_glow[i] * 0.05);
    draw_text_transformed(
        bx,
        by,
        menu_options[i],
        scale,
        scale,
        0
    );
}

// ==========================================
// BORDA DECORATIVA
// ==========================================
draw_set_color(c_aqua);
draw_set_alpha(0.2 * alpha);
draw_rectangle(20, 20, gui_w - 20, gui_h - 20, true);

// ==========================================
// INSTRUÇÕES
// ==========================================
draw_set_color(c_gray);
draw_set_alpha(alpha * 0.7);
draw_set_halign(fa_left);
draw_set_font(fnt_menu);
draw_text(100, gui_h - 80, "SETAS para navegar | ENTER para selecionar");

// ==========================================
// FADE FINAL PARA PRETO
// ==========================================
if (fade_alpha > 0) {
    draw_set_alpha(fade_alpha);
    draw_set_color(c_black);
    draw_rectangle(0, 0, gui_w, gui_h, false);
}

// ==========================================
// JANELA DE CONFIRMAÇÃO
// ==========================================
if (confirmando_saida) {
    // Fundo escurecido
    draw_set_alpha(0.6);
    draw_set_color(c_black);
    draw_rectangle(0, 0, gui_w, gui_h, false);
    
    // Caixa
    var box_x = gui_w/2 - 150;
    var box_y = gui_h/2 - 80;
    draw_set_alpha(1);
    draw_set_color(c_dkgray);
    draw_rectangle(box_x, box_y, box_x + 300, box_y + 160, false);
    
    draw_set_color(c_white);
    draw_set_halign(fa_center);
    draw_set_font(fnt_menu);
    draw_text(gui_w/2, box_y + 40, "Deseja realmente sair?");
    
    // SIM
    draw_set_color(confirm_index == 0 ? c_aqua : c_white);
    draw_rectangle(box_x + 30, box_y + 90, box_x + 130, box_y + 130, false);
    draw_set_color(c_black);
    draw_text(box_x + 80, box_y + 110, "SIM");
    
    // NÃO
    draw_set_color(confirm_index == 1 ? c_aqua : c_white);
    draw_rectangle(box_x + 170, box_y + 90, box_x + 270, box_y + 130, false);
    draw_set_color(c_black);
    draw_text(box_x + 220, box_y + 110, "NÃO");
    
    draw_set_halign(fa_left);
}

draw_set_alpha(1);
