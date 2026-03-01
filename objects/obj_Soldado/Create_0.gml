/// obj_Soldado - Create Event

event_inherited();

tipo_inimigo = EnemyType.SOLDADO;

#region CARACTERÍSTICAS DO SOLDADO
hpEnemy = 5;
spdEnemy = 1.2;  // Patrulha lenta
spdEnemyMax = 2.4; // Chase rápido
shoot_range = 350;
dist_visao = 280;
dist_tiro = 200;
dist_min_tiro = 70;
ataque_delay = 50; // Atira rápido
tempo_mira_max = 15;
shot_inaccuracy = 5;
reaction_time = 20;
nao_cair_plataforma = true;
#endregion

#region SPRITES DO SOLDADO
spr_run = sprt_SoldadoRun;
spr_attack = sprt_SoldadoAttack;
spr_death = sprt_SoldadoDeath;
#endregion
