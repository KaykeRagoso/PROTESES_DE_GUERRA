// Velocidade e Gravidade
hsp = 0;
vsp = 0;
v_velocidade = 1.5; // Um pouco mais lento que o player para não ficar colado
v_gravidade = 0.5;
v_pulo = -10;

// O SEU BLOCO DIFERENTE
meu_bloco_colisao = obj_Block_NPC; 

alvo = obj_Player;
distancia_parar = 40; // Distância para ele não subir em cima do player

global.fade_missao1 = false