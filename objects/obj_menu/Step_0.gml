// 1. Fade e Movimento inicial
alpha = lerp(alpha, 1, 0.05);
menu_x_offset = lerp(menu_x_offset, 0, 0.05);

// 2. Controles
var up    = keyboard_check_pressed(vk_up) || keyboard_check_pressed(ord("W"));
var down  = keyboard_check_pressed(vk_down) || keyboard_check_pressed(ord("S"));
var enter = keyboard_check_pressed(vk_enter) || keyboard_check_pressed(vk_space);

// 3. Lógica de Seleção
var move = down - up;
if (move != 0) {
    index += move;
    if (index < 0) index = array_length(menu_options) - 1;
    if (index >= array_length(menu_options)) index = 0;
    // Pressione uma tecla e o sistema entende que o teclado está ativo
    input_modo = "teclado"; 
}

// 4. Mouse e Animação
var m_x = device_mouse_x_to_gui(0);
var m_y = device_mouse_y_to_gui(0);
var mouse_moveu = (mouse_x != mouse_last_x || mouse_y != mouse_last_y); 


for (var i = 0; i < array_length(menu_options); i++) {
    var bx = 100 + menu_x_offset;
    var by = 300 + (i * 70);
    
    //zona de colisão do mouse
    var mouse_em_cima = (m_x > bx && m_x < bx + 400 && m_y > by && m_y < by + 60);
    
    if (mouse_em_cima) {
        index = i;
        input_modo = "mouse";
    }

    //o botão só brilha se for o selecionado
    var focado = (index == i && (mouse_em_cima || input_modo == "teclado"));

    if (focado) {
        button_x[i] = lerp(button_x[i], 30, 0.15);
        button_glow[i] = lerp(button_glow[i], 1, 0.1);
    } else {
        button_x[i] = lerp(button_x[i], 0, 0.15);
        button_glow[i] = lerp(button_glow[i], 0, 0.1);
    }
}

//executar (tem que fazer)
if (enter)

event_user(0);