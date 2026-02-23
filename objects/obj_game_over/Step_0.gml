//aumenta o escurecimento da tela gradualmente
alpha = min(alpha + 0.02, 1); 

//reiniciar a fase
if (pode_reiniciar) {
    if (keyboard_check_pressed(ord("R")) || keyboard_check_pressed(vk_space)) {
        room_restart();
    }
}