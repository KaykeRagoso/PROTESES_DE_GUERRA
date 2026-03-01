/// obj_Boss - Create Event

event_inherited();

tipo_inimigo = EnemyType.BOSS;

#region CARACTERÍSTICAS DO BOSS
hpEnemy = 20; // Muito mais HP
spdEnemy = 0.5;  // Patrulha bem lenta
spdEnemyMax = 2.5; // Chase rápido pra alcançar o player
shoot_range = 999; // Ignora o sistema de tiro (corpo-a-corpo)
dist_visao = 400; // Vê de longe
dist_tiro = 150; // Distância para começar a atacar (corpo-a-corpo)
dist_min_tiro = 0; // Pode atacar de perto
nao_cair_plataforma = false; // Pode cair
grv = 0.35;
maxFall = 6;
#endregion

#region SPRITES DO BOSS
spr_run = sprt_SapoRun;
spr_attack = sprt_SapoAttack; // Soco
spr_punch = sprt_SapoAttack; // Sprite do soco (mesma ou diferente)
spr_death = sprt_SapoDeath;
#endregion

#region BOSS MOVESET - SISTEMA DE SOCOS
ataque_tipo = 0; // 0 = soco, 1 = pulo especial
ataque_cooldown = 0;
ataque_ativo = false;
ataque_duracao = 15;
ataque_dano = 12; // Dano por soco
ataque_alcance = 35; // Alcance do soco
ataque_tocou_player = false; // Evita dano múltiplo

socos_consecutivos = 0; // Quantos socos já deu
socos_minimos = 2; // Mínimo de socos antes de poder fazer pulo
chance_pulo_apos_socos = 40; // Chance (%) de fazer pulo após os socos mínimos
#endregion

#region BOSS SPECIAL ATTACK - PULO
tempo_visto_player = 0; // Tempo desde que viu o player
tempo_minimo_pulo = 600; // 10 segundos (600 frames a 60fps)
pulo_especial_cooldown = 0;
pulo_especial_delay = 600; // 10 segundos entre pulos
pulo_especial_ativo = false;
pulo_especial_duracao = 40;
pulo_especial_dano = 18; // Dano do pulo
pulo_especial_alcance = 50; // Alcance maior do pulo
pulo_especial_tocou_player = false;
#endregion
