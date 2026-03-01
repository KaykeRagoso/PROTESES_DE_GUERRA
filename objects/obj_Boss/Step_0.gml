/// obj_Boss - Step Event

checkDeath();

if (state == EnemyState.DEATH){
    if (image_index >= image_number - 1){
        instance_destroy();
    }
    exit;
}

// Dano por contato
if (state != EnemyState.DEATH) {
	if (state == EnemyState.PATROL || state == EnemyState.CHASE){
		if (contato_dano_cooldown > 0){
			contato_dano_cooldown--;
		}else if (place_meeting(x,y,obj_Player)){
			with(obj_Player){
				takeDamage(10, other.facing);	
			}
			contato_dano_cooldown = 60;
		}
	}	
}

// Verificação de morte
if (hpEnemy <= 0){
	state = EnemyState.DEATH;
}

#region DETECÇÃO DO PLAYER

var player = instance_nearest(x, y, obj_Player);

if (player != noone){
    var distPlayer = point_distance(x, y, player.x, player.y);

    if (distPlayer <= dist_visao){
        target = player;
        tempo_perda_alvo = 0;
        
        // Marca o tempo que viu o player
        if (tempo_visto_player == 0){
            tempo_visto_player = 1; // Começa a contar
        }
        
        // Aumenta o contador de tempo visto
        tempo_visto_player++;

        // Alerta aparece só na PRIMEIRA VEZ que vê o player
        if (state == EnemyState.PATROL && !alerta_foi_mostrado){
            mostrar_alerta = 60;
            alerta_foi_mostrado = true;
        }
    }
    else if (target != noone){
        tempo_perda_alvo++;

        if (tempo_perda_alvo > 90){
            target = noone;
            alerta_foi_mostrado = false;
            tempo_visto_player = 0; // Reset o tempo
        }
    }
}

#endregion

#region STATE MACHINE

switch (state){

    case EnemyState.PATROL:
        move_dir = facing;
        hspdEnemy = spdEnemy * move_dir;

        var frontX = x + (facing * 8);
        var frontY = y + 16;

        var parede = place_meeting(x + facing, y, obj_Block);
        var chao_frente = place_meeting(frontX, frontY, obj_Block);

        if (parede || (nao_cair_plataforma && !chao_frente)){
            facing *= -1;
        }
        
        // Som de passos durante patrulha
        if (place_meeting(x, y + 1, obj_Block)){
            som_passos_cooldown--;
            if (som_passos_cooldown <= 0){
                audio_play_sound(snd_passos_terra, 10, false);
                som_passos_cooldown = som_passos_delay;
            }
        }

        if (target != noone){
            state = EnemyState.CHASE;
        }
    break;

    case EnemyState.CHASE:
        if (target != noone && instance_exists(target)){
            var dx = target.x - x;
            facing = sign(dx);
            hspdEnemy = spdEnemyMax * facing;

            if (place_meeting(x + hspdEnemy, y, obj_Block) && place_meeting(x, y + 1, obj_Block)){
                vspdEnemy = -7.5;
            }
            
            // Som de passos durante chase
            if (place_meeting(x, y + 1, obj_Block)){
                som_passos_cooldown--;
                if (som_passos_cooldown <= 0){
                    audio_play_sound(snd_passos_terra, 10, false);
                    som_passos_cooldown = som_passos_delay;
                }
            }

            var dist = point_distance(x, y, target.x, target.y);

            // Boss vai pra ATTACK quando fica perto
            if (dist < dist_tiro){
                state = EnemyState.ATTACK;
                ataque_ativo = false;
                ataque_cooldown = 0;
                socos_consecutivos = 0; // Reset dos socos
            }
        }
        else{
            state = EnemyState.PATROL;
        }
    break;

    case EnemyState.ATTACK:
        hspdEnemy = 0;

        // Permitir pulo durante ataque se bater em parede
        if (place_meeting(x, y + 1, obj_Block) && place_meeting(x + sign(facing), y, obj_Block)){
            vspdEnemy = -7.5;
        }

        if (target != noone && instance_exists(target)){
            // Cooldown entre ataques
            if (ataque_cooldown > 0){
                ataque_cooldown--;
            }
            else {
                // Decidir qual tipo de ataque fazer
                var fazer_pulo = false;
                
                // Só permite pulo se:
                // 1. Já viu o player há 10 segundos
                // 2. Já deu pelo menos 2 socos
                // 3. Tem chance de 40%
                if (tempo_visto_player >= tempo_minimo_pulo && socos_consecutivos >= socos_minimos){
                    if (irandom(100) < chance_pulo_apos_socos){
                        fazer_pulo = true;
                    }
                }
                
                if (fazer_pulo && pulo_especial_cooldown <= 0){
                    // PULO ESPECIAL
                    pulo_especial_ativo = true;
                    pulo_especial_duracao = 40;
                    pulo_especial_tocou_player = false;
                    
                    // Pulo muito forte
                    if (place_meeting(x, y + 1, obj_Block)){
                        vspdEnemy = -12;
                    }
                    
                    audio_play_sound(snd_Espada, 10, false);
                    pulo_especial_cooldown = pulo_especial_delay;
                    socos_consecutivos = 0; // Reset dos socos
                }
                else {
                    // SOCO NORMAL
                    if (!ataque_ativo){
                        ataque_ativo = true;
                        ataque_duracao = 15;
                        ataque_tocou_player = false;
                        audio_play_sound(snd_Espada, 10, false);
                        socos_consecutivos++; // Incrementa contador de socos
                    }
                }
            }

            // ===== SOCO NORMAL =====
            if (ataque_ativo){
                ataque_duracao--;
                
                // Aplicar dano se tocar no player
                if (!ataque_tocou_player && distance_to_object(target) < ataque_alcance){
                    with(target){
                        takeDamage(ataque_dano, other.facing);
                    }
                    ataque_tocou_player = true;
                }
                
                if (ataque_duracao <= 0){
                    ataque_ativo = false;
                    ataque_cooldown = 40; // Delay de 40 frames entre ataques
                }
            }

            // ===== PULO ESPECIAL =====
            if (pulo_especial_ativo){
                pulo_especial_duracao--;
                
                // Aplicar dano se tocar no player
                if (!pulo_especial_tocou_player && distance_to_object(target) < pulo_especial_alcance && !place_meeting(x, y + 1, obj_Block)){
                    with(target){
                        takeDamage(pulo_especial_dano, other.facing);
                    }
                    pulo_especial_tocou_player = true;
                }
                
                if (pulo_especial_duracao <= 0){
                    pulo_especial_ativo = false;
                    ataque_cooldown = 50; // Delay maior após pulo
                }
            }

            // Checar distância - volta pra CHASE se player ficar longe
            var dist = point_distance(x, y, target.x, target.y);
            if (dist > dist_tiro + 50){
                state = EnemyState.CHASE;
            }
        }
        else{
            state = EnemyState.PATROL;
        }
    break;
}

#endregion

#region COOLDOWNS

if (pulo_especial_cooldown > 0){
    pulo_especial_cooldown--;
}

#endregion

#region GRAVIDADE

vspdEnemy += grv;

if (vspdEnemy > maxFall)
    vspdEnemy = maxFall;

#endregion

#region COLISÃO HORIZONTAL

if (place_meeting(x + hspdEnemy, y, obj_Block)){
    while (!place_meeting(x + sign(hspdEnemy), y, obj_Block))
        x += sign(hspdEnemy);

    hspdEnemy = 0;
}

x += hspdEnemy;

#endregion

#region COLISÃO VERTICAL

if (place_meeting(x, y + vspdEnemy, obj_Block)){
    while (!place_meeting(x, y + sign(vspdEnemy), obj_Block))
        y += sign(vspdEnemy);

    vspdEnemy = 0;
}

y += vspdEnemy;

#endregion

#region RECOIL (APLICADO DEPOIS DAS COLISÕES)

if (recoil_force != 0){
    x += recoil_force;
    
    // Verificar colisão do recoil
    if (place_meeting(x, y, obj_Block)){
        while (!place_meeting(x - sign(recoil_force), y, obj_Block))
            x -= sign(recoil_force);
    }
    
    // Diminuir força do recoil
    recoil_force = lerp(recoil_force, 0, recoil_decay);

    if (abs(recoil_force) < 0.05)
        recoil_force = 0;
}

#endregion

#region SPRITE E ANIMAÇÃO

if (state == EnemyState.DEATH){
    sprite_index = spr_death;
    image_speed = 0.2;
}
else if (!place_meeting(x, y + 1, obj_Block)){
    sprite_index = spr_run;
    image_speed = 0.2;
}
else{
    switch(state){
        case EnemyState.PATROL:
        case EnemyState.CHASE:
            sprite_index = spr_run;
            image_speed = 0.2;
        break;

        case EnemyState.ATTACK:
            sprite_index = spr_attack;
            image_speed = 0.2;
        break;

        default:
            sprite_index = spr_run;
            image_speed = 0.15;
        break;
    }
}

image_xscale = facing;

#endregion

#region ALERTA

if (mostrar_alerta > 0) {
    draw_sprite(spr_alerta, 0, x, y - 50);
    mostrar_alerta--;
}

#endregion

#region PISCAR (HIT)

if (piscar_ativo){
    piscar_tempo++;
    if (piscar_tempo >= piscar_duracao){
        piscar_ativo = false;
        image_alpha = 1;
    } else {
        // Pisca alternando entre opaco e semi-transparente
        if ((piscar_tempo div piscar_velocidade) mod 2 == 0){
            image_alpha = 0.5;
        } else {
            image_alpha = 1;
        }
    }
}

#endregion
