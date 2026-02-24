// Faz o portal pulsar levemente o tamanho
image_xscale = 1 + sin(current_time * 0.005) * 0.1;
image_yscale = 1 + sin(current_time * 0.005) * 0.1;

// Faz ele brilhar mudando o alpha
image_alpha = 0.8 + random(0.2);
// Cria partículas na base do portal
part_particles_create(meu_sistema, x + random_range(-32, 32), y, minha_part, 2);