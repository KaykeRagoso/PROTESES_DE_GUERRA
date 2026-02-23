// Alterna entre aberto e fechado
if (keyboard_check_pressed(vk_tab) || keyboard_check_pressed(ord("M"))) {
    aberto = !aberto;
}

// Suavização da animação (Lerp)
if (aberto) {
    animacao = lerp(animacao, 1, velocidade_anim);
} else {
    animacao = lerp(animacao, 0, velocidade_anim);
}