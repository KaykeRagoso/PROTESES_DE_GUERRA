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
    var click = mouse_check_button_pressed(mb_left);

    // Alternar entre SIM e NÃO
    if (left || right) {
        confirm_index = 1 - confirm_index;
    }

    // Controle por mouse
    var m_x = device_mouse_x_to_gui(0);
    var m_y = device_mouse_y_to_gui(0);

    var box_x = gui_w/2 - 150;
    var box_y = gui_h/2 - 80;

    var sim_hover = (m_x > box_x + 30 && m_x < box_x + 130 &&
                     m_y > box_y + 90 && m_y < box_y + 130);

    var nao_hover = (m_x > box_x + 170 && m_x < box_x + 270 &&
                     m_y > box_y + 90 && m_y < box_y + 130);

    if (sim_hover) confirm_index = 0;
    if (nao_hover) confirm_index = 1;

    if (enter || click) {
        if (confirm_index == 0) {
            game_end();
        } else {
            confirmando_saida = false;
        }
    }

    exit; // bloqueia o menu
}

// ==========================================
// 3. Fade inicial e animação
// ==========================================
alpha = lerp(alpha, 1, 0.05);
menu_x_offset = lerp(menu_x_offset, 0, 0.05);

// ==========================================
// 4. Controles teclado menu principal
// ==========================================
var up    = keyboard_check_pressed(vk_up) || keyboard_check_pressed(ord("W"));
var down  = keyboard_check_pressed(vk_down) || keyboard_check_pressed(ord("S"));
var enter = keyboard_check_pressed(vk_enter) || keyboard_check_pressed(vk_space);

var move = down - up;

if (move != 0) {
    index += move;

    if (index < 0) index = array_length(menu_options) - 1;
    if (index >= array_length(menu_options)) index = 0;

    input_modo = "teclado";
}

// ==========================================
// 5. Mouse menu principal
// ==========================================
var m_x = device_mouse_x_to_gui(0);
var m_y = device_mouse_y_to_gui(0);

for (var i = 0; i < array_length(menu_options); i++) {

    var bx = 100 + menu_x_offset;
    var by = 300 + (i * 70);

    var mouse_em_cima = (m_x > bx && m_x < bx + 400 && m_y > by && m_y < by + 60);

    if (mouse_em_cima) {
        index = i;
        input_modo = "mouse";
    }

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
// 6. Ativar opção
// ==========================================
var click = mouse_check_button_pressed(mb_left);

if (enter || (click && input_modo == "mouse")) {

    switch(index) {

        case 0:
            iniciando = true;
        break;

        case 1:
            room_goto(rm_config);
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