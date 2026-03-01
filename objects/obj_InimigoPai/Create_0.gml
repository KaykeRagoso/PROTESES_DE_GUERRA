/// obj_Inimigo - Create Event

#region ENUM
enum EnemyState {
    PATROL,
    CHASE,
    ATTACK,
    DEATH
}

enum EnemyType {
    SOLDADO,
    BOSS
}
#endregion

#region TIPO DE INIMIGO
tipo_inimigo = EnemyType.SOLDADO; // Mude para EnemyType.BOSS se for o chefe
#endregion

#region MOVIMENTO
state = EnemyState.PATROL;
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

#region TIRO
shoot_range = 400;
aim_speed = 0.08;
aim_dir = 0;
shot_inaccuracy = 6;
reaction_time = 30;
reaction_timer = 0;
target = noone;
#endregion

#region VIDA
hpEnemy = 1;
dropped = false;
drop_timer = 0;
drop_delay = 90;
#endregion

#region COMBATE
ataque = false;
ataque_cool = 0;
ataque_delay = 60;
tempo_mira = 0;
tempo_mira_max = 20;
recoil_force = 0;
recoil_decay = 0.15;
contato_dano_cooldown = 0;
#endregion

#region VISÃO
dist_visao = 300;
dist_tiro = 200;
dist_min_tiro = 80;
mostrar_alerta = 0;
tempo_perda_alvo = 0;
can_see_player = false;
alerta_foi_mostrado = false;
#endregion

#region PISCAR (HIT)
piscar_ativo = false;
piscar_tempo = 0;
piscar_duracao = 30; // Pisca por 30 frames
piscar_velocidade = 5; // Pisca a cada 5 frames
#endregion

#region SPRITES
// Vai ser definido no Create de cada tipo
spr_run = 0;
spr_attack = 0;
spr_death = 0;
#endregion

#region BOSS ESPECÍFICO
ataque_especial_cooldown = 0;
ataque_especial_delay = 300;
ataque_especial_ativo = false;
ataque_especial_duracao = 60;
ataque_especial_tipo = 0; // 0 = pulo, 1 = investida
#endregion

#region FUNÇÕES

function checkDeath(){
    if (hpEnemy <= 0 && !dropped){
        drop_timer++;
        if (drop_timer >= drop_delay){
            dropItem();
            dropped = true;
            state = EnemyState.DEATH;
        }
    }
}

function aplicarRecoil(_dir, _forca){
    recoil_force = lengthdir_x(_forca, _dir + 180);
}

function dropItem(){
    var chance = irandom_range(1,100);
	
    if (tipo_inimigo == EnemyType.SOLDADO){
        if (chance <= 35){
            instance_create_layer(x,y,"Instances",obj_Moedas);	
        }else if (chance <= 70){
            instance_create_layer(x,y,"Instances",obj_PotionLife);
        }
    }
    else if (tipo_inimigo == EnemyType.BOSS){
        if (chance <= 25){
            instance_create_layer(x,y,"Instances",obj_Moedas);
            instance_create_layer(x + 20,y,"Instances",obj_Moedas);	
        }else if (chance <= 60){
            instance_create_layer(x,y,"Instances",obj_PotionLife);
            instance_create_layer(x + 20,y,"Instances",obj_PotionLife);
        }
    }
}

function takeDamage(_dano,_dir){
    hpEnemy -= _dano;
    aplicarRecoil(_dir, 5);
    state = EnemyState.CHASE;
    mostrar_alerta = 40;
    piscar_ativo = true;
    piscar_tempo = 0;
}

function atirarBala(){
    var erro = random_range(-shot_inaccuracy, shot_inaccuracy);
    var dir = aim_dir + erro;

    var bullet = instance_create_layer(
        x + (facing * 12),
        y, // Bala mais baixa
        "Instances",
        obj_EnemyBullet
    );

    if (bullet != noone){
        bullet.direction = dir;
        bullet.speed = 5;
        bullet.damage = (tipo_inimigo == EnemyType.BOSS) ? 15 : 10;
        bullet.owner = id;
    }

    aplicarRecoil(dir, 4);
}

#endregion
