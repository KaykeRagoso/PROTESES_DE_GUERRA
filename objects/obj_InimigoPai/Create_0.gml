enum EnemyState {
    PATROL,
    CHASE,
    ATTACK,
    DEATH
}

state = EnemyState.PATROL;

#region MOVIMENTO

spdEnemy = 1;
spdEnemyMax = 2.5;

hspdEnemy = 0;
vspdEnemy = 0;

grv = 0.35;
maxFall = 6;

facing = 1;
move_dir = 1;

nao_cair_plataforma = true;

#endregion

#region Tiro
shoot_range = 400;
shoot_cooldown = 90;
shoot_timer = 0;

aim_speed = 0.08;

aim_dir = 0;

shot_inaccuracy = 6; // erro do tiro
reaction_time = 30;
reaction_timer = 0;

target = obj_Player;	
#endregion


#region VIDA

hpEnemy = 3;
dropped = false;

#endregion


#region COMBATE

target = noone;

ataque = false;
ataque_cool = 0;
ataque_delay = 60;

tempo_mira = 0;
tempo_mira_max = 20;

erro_tiro = 6;

recoil_force = 0;
recoil_decay = 0.15;

contato_dano_cooldown = 0;

#endregion


#region VISÃO

dist_visao = 300;
dist_tiro  = 200;
dist_min_tiro = 80;

mostrar_alerta = 0;
tempo_perda_alvo = 0;

#endregion


#region FUNÇÕES

function checkDeath(){

    if (hpEnemy <= 0 && !dropped){
        dropItem();
        dropped = true;
        state = EnemyState.DEATH;	
    }

}

function aplicarRecoil(_dir, _forca){

    recoil_force = lengthdir_x(_forca, _dir + 180);

}

function dropItem(){

    var chance = irandom_range(1,100);
	
    if (chance <= 10){
        show_debug_message("Dropou Potion");
    }
    else if (chance <= 25){
        show_debug_message("Dropou Munição");
    }

}

function takeDamage(_dano,_dir){

    hpEnemy -= _dano;

    aplicarRecoil(_dir,5);

    state = EnemyState.CHASE;

    mostrar_alerta = 40;

}

#endregion