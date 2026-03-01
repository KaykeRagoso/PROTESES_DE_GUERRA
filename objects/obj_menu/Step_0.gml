/// obj_Menu - Step Event

// ==========================================
// 1. Se estiver iniciando (fade para próxima room)
// ==========================================
if (iniciando) {
    fade_alpha += fade_speed;
    if (fade_alpha >= 1) {
        fade_alpha = 1;
		scr_Reset();
		room_goto(Room1);
    }
    exit;
}

// ==========================================
// 2. Se estiver na confirmação de saída
// ==========================================
if (confirmando_saida) {
    var left  = keyboard_check_pressed(vk_left)  || keyboard_check_pressed(ord("A"));
    var right = keyboard_check_pressed(vk_right) || keyboard_check_pressed(ord("D"));
    var enter = keyboard_check_pressed(vk_enter) || keyboard_check_pressed(vk_space);
    
    // Alternar entre SIM e NÃO
    if (left || right) {
        confirm_index = 1 - confirm_index;
    }
    
    // Confirmar
    if (enter) {
        if (confirm_index == 0) {
            game_end();
        } else {
            confirmando_saida = false;
        }
    }
    exit; // bloqueia o menu
}

// ==========================================
// 3. Se estiver nas configurações
// ==========================================
if (em_config) {
    var up    = keyboard_check_pressed(vk_up) || keyboard_check_pressed(ord("W"));
    var down  = keyboard_check_pressed(vk_down) || keyboard_check_pressed(ord("S"));
    var left  = keyboard_check_pressed(vk_left) || keyboard_check_pressed(ord("A"));
    var right = keyboard_check_pressed(vk_right) || keyboard_check_pressed(ord("D"));
    var enter = keyboard_check_pressed(vk_enter) || keyboard_check_pressed(vk_space);
    var esc   = keyboard_check_pressed(vk_escape);
    
    var move = down - up;
    if (move != 0) {
        config_index += move;
        if (config_index < 0) config_index = array_length(config_options) - 1;
        if (config_index >= array_length(config_options)) config_index = 0;
    }
    
    // Ajustar valores com LEFT e RIGHT
    if (config_index < 3) { // Primeiras 3 opções (volume e dificuldade)
        if (left) {
            if (config_index == 2) {
                // Dificuldade
                config_values[2]--;
                if (config_values[2] < 0) config_values[2] = 2;
            } else {
                // Volume
                config_values[config_index] -= 10;
                if (config_values[config_index] < 0) config_values[config_index] = 0;
            }
        }
        if (right) {
            if (config_index == 2) {
                // Dificuldade
                config_values[2]++;
                if (config_values[2] > 2) config_values[2] = 0;
            } else {
                // Volume
                config_values[config_index] += 10;
                if (config_values[config_index] > 100) config_values[config_index] = 100;
            }
        }
    }
    
    // Voltar (Enter em "VOLTAR" ou ESC)
    if (enter || esc) {
        if (config_index == 3 || esc) {
            em_config = false;
            config_index = 0;
        }
    }
    
    exit; // Bloqueia menu principal
}

// ==========================================
// 4. Fade inicial e animação
// ==========================================
alpha = lerp(alpha, 1, 0.05);
menu_x_offset = lerp(menu_x_offset, 0, 0.05);

// ==========================================
// 5. Controles teclado menu principal
// ==========================================
var up    = keyboard_check_pressed(vk_up) || keyboard_check_pressed(ord("W"));
var down  = keyboard_check_pressed(vk_down) || keyboard_check_pressed(ord("S"));
var enter = keyboard_check_pressed(vk_enter) || keyboard_check_pressed(vk_space);

var move = down - up;
if (move != 0) {
    index += move;
    if (index < 0) index = array_length(menu_options) - 1;
    if (index >= array_length(menu_options)) index = 0;
}

// ==========================================
// 6. Animação dos botões
// ==========================================
for (var i = 0; i < array_length(menu_options); i++) {
    var focado = (index == i);
    if (focado) {
        button_x[i] = lerp(button_x[i], 30, 0.15);
        button_glow[i] = lerp(button_glow[i], 1, 0.1);
    } else {
        button_x[i] = lerp(button_x[i], 0, 0.15);
        button_glow[i] = lerp(button_glow[i], 0, 0.1);
    }
}

// ==========================================
// 7. Ativar opção
// ==========================================
if (enter) {
    switch(index) {
        case 0:
            iniciando = true;
        break;
        case 1:
            em_config = true;
            config_index = 0;
        break;
        case 2:
            room_goto(rm_creditos);
        break;
        case 3:
            confirmando_saida = true;
            confirm_index = 1; // começa selecionando NÃO
        break;
    }
}
