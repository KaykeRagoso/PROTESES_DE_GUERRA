enum EnemyState {
    PATROL,
    CHASE,
    ATTACK,
    DEATH
}

state = EnemyState.PATROL;

// MOVIMENTO
spdEnemy = 1;
spdEnemyMax = 2.5;

hspdEnemy = 0;
vspdEnemy = 0;

grv = 0.35;
maxFall = 6;

facing = 1;
move_dir = 1;

// VIDA
hpEnemy = 3;
dropped = false;

// COMBATE
target = noone;

ataque = false;
ataque_cool = 0;
ataque_delay = 60;

recoil_force = 0;
recoil_decay = 0.15;

// VISÃO
dist_visao = 300;
dist_tiro  = 200;
mostrar_alerta = 0;
tempo_perda_alvo = 0;


// FUNÇÕES
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