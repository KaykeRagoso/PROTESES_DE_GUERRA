// Estados
enum ESTADO { PATRULHA, ALERTA }
estado_atual = ESTADO.PATRULHA;

// Movimentação
vel_patrulha = 1;
vel_perseguicao = 2.5;
hsp = 0;
vsp = 0;
grv = 0.3;
dir = 1; // Direção (1 direita, -1 esquerda)

// Visão e Combate
dist_visao = 300;
dist_tiro = 200;
cadencia_tiro = 60;
pode_atirar = true;
timer_pulo = 0;

// Exclamação
mostrar_alerta = 0; // Timer para o desenho do "!"