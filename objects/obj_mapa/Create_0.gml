aberto = false;       // Controla se a aba está visível
animacao = 0;         // Vai de 0 (fechado) a 1 (aberto)
velocidade_anim = 0.1; // Velocidade do deslize

// Tamanho do mapa quando aberto (ocupando boa parte da tela)
largura_alvo = display_get_gui_width() * 0.8;
altura_alvo = display_get_gui_height() * 0.8;

// Escala para caber a room inteira dentro dessa aba
escala_mapa = largura_alvo / room_width;