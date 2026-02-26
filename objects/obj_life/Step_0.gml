// Barra branca sobe junto se curar
if (global.vida_atual > vida_delay) {
    vida_delay = global.vida_atual;
}

// Barra de delay desce
if (vida_delay > global.vida_atual) {
    vida_delay -= 0.5;
} else {
    vida_delay = global.vida_atual;
}

// Testes de dano (remover depois)
if (keyboard_check_pressed(vk_f1)) {
    with (obj_Player) { takeDamage(100, facing); }
}
if (keyboard_check_pressed(vk_f2)) {
    with (obj_Player) { takeDamage(1, facing); }
}