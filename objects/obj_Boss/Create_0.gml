/// obj_Boss - Create Event

event_inherited();

tipo_inimigo = EnemyType.BOSS;

#region CARACTERÍSTICAS DO BOSS
hpEnemy = 50; // Muito mais HP
spdEnemy = 0.6;  // Patrulha bem lenta
spdEnemyMax = 1.8; // Chase moderado
shoot_range = 450;
dist_visao = 400;
dist_tiro = 250;
dist_min_tiro = 100;
ataque_delay = 80; // Atira devagar
tempo_mira_max = 30;
shot_inaccuracy = 8; // Menos preciso
reaction_time = 40;
nao_cair_plataforma = false; // Pode cair
grv = 0.25; // Gravidade reduzida - pula mais
maxFall = 5;
#endregion

#region SPRITES DO BOSS
spr_run = sprt_SapoRun;
spr_attack = sprt_SapoAttack;
spr_death = sprt_SapoDeath;
#endregion

#region BOSS MOVESET
ataque_especial_cooldown = 0;
ataque_especial_delay = 300; // A cada 5 segundos
ataque_especial_ativo = false;
ataque_especial_duracao = 60;
ataque_especial_tipo = 0;
#endregion
