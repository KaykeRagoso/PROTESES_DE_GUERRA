// 1. Aplicar Gravidade
if (!place_meeting(x, y + 1, meu_bloco_colisao)) {
    vsp += v_gravidade;
}

// 2. Inteligência de Perseguição
if (instance_exists(alvo)) {
    var _dist = x - alvo.x; // Distância horizontal

    if (abs(_dist) > distancia_parar) {
        // Decide a direção (-1 esquerda, 1 direita)
        var _dir = sign(alvo.x - x);
        hsp = _dir * v_velocidade;
        image_xscale = _dir; // Vira o sprite
    } else {
        hsp = 0; // Para perto do player
    }

    // 3. Pulo Automático (se encontrar um obstáculo do TIPO DELE)
    if (place_meeting(x + hsp, y, meu_bloco_colisao) && place_meeting(x, y + 1, meu_bloco_colisao)) {
        vsp = v_pulo;
    }
}

// --- 4. COLISÃO HORIZONTAL (COM O BLOCO DIFERENTE) ---
if (place_meeting(x + hsp, y, meu_bloco_colisao)) {
    while (!place_meeting(x + sign(hsp), y, meu_bloco_colisao)) {
        x += sign(hsp);
    }
    hsp = 0;
}
x += hsp;

// --- 5. COLISÃO VERTICAL (COM O BLOCO DIFERENTE) ---
if (place_meeting(x, y + vsp, meu_bloco_colisao)) {
    while (!place_meeting(x, y + sign(vsp), meu_bloco_colisao)) {
        y += sign(vsp);
    }
    vsp = 0;
}
y += vsp;

if distance_to_object(obj_Player) <= 50 {
	v_velocidade = 0
}else{
	v_velocidade = 1.5
}

if (global.fade_missao1 = true){
	x = 2300
	y = 4256
}else{
	x = x
	y = y
}
show_debug_message(obj_Player.y)