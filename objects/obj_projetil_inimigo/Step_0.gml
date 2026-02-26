// Física básica (Gravidade)
vsp += grv;

// --- LÓGICA DE DETECÇÃO ---
var _player_perto = false;
if (instance_exists(obj_Player)) {
    var _dist = distance_to_object(obj_Player);
    var _parede = collision_line(x, y - 10, obj_Player.x, obj_Player.y - 10, obj_Block, false, true);
    
    if (_dist < dist_visao && !_parede) {
        _player_perto = true;
        if (estado_atual == ESTADO.PATRULHA) {
            estado_atual = ESTADO.ALERTA;
            mostrar_alerta = 60; // Mostra "!" por 1 segundo
        }
    } else if (_dist > dist_visao * 1.5) {
        estado_atual = ESTADO.PATRULHA;
    }
}

// --- MÁQUINA DE ESTADOS ---
switch (estado_atual) {
    case ESTADO.PATRULHA:
        hsp = dir * vel_patrulha;
        
        // Inverter direção ao bater em parede ou chegar em buracos
        if (place_meeting(x + hsp, y, obj_Block) || !position_meeting(x + (dir * 20), y + 32, obj_Block)) {
            dir *= -1;
        }
    break;

    case ESTADO.ALERTA:
        if (instance_exists(obj_Player)) {
            dir = sign(obj_Player.x - x);
            hsp = dir * vel_perseguicao;

            // PULAR OBSTÁCULOS: Se houver parede à frente ou um pequeno degrau
            if (place_meeting(x + hsp, y, obj_Block) && place_free(x, y - 1)) {
                if (place_meeting(x, y + 1, obj_Block)) { // Só pula se estiver no chão
                    vsp = -7.5; 
                }
            }

            // ATIRAR: Só se estiver na distância de tiro
            if (distance_to_object(obj_Player) < dist_tiro && pode_atirar) {
                pode_atirar = false;
                alarm[0] = cadencia_tiro;
                var _tiro = instance_create_layer(x, y - 10, "Instances", obj_projetil_inimigo);
                _tiro.direction = point_direction(x, y - 10, obj_Player.x, obj_Player.y - 10);
                _tiro.speed = 5;
            }
        }
    break;
}

// --- COLISÃO E MOVIMENTO FINAL ---
if (place_meeting(x + hsp, y, obj_Block)) {
    while (!place_meeting(x + sign(hsp), y, obj_Block)) x += sign(hsp);
    hsp = 0;
}
x += hsp;

if (place_meeting(x, y + vsp, obj_Block)) {
    // Note que agora só temos: x, a nova posição y, e o objeto
    while (!place_meeting(x, y + sign(vsp), obj_Block)) {
        y += sign(vsp);
    }
    vsp = 0;
}
y += vsp;

// Lado do sprite
if (hsp != 0) image_xscale = sign(hsp);

if distance_to_object(obj_Player) <= 100{
	vel_patrulha = 0;
vel_perseguicao = 0;
}else{
vel_patrulha = 1;
vel_perseguicao = 2.5;	
}