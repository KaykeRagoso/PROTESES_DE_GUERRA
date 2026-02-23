// Supondo que global.vida_max seja a vida total
if (keyboard_check_pressed(ord("Q"))) {
    if (global.pocoes > 0 && global.vida_atual < global.vida_max) {
        global.vida_atual += 20; // Quantidade que a poção cura
        global.pocoes -= 1; // Gasta uma poção
        
        // Impede que a vida passe do máximo
        if (global.vida_atual > global.vida_max) global.vida_atual = global.vida_max;
        
        // Efeito sonoro de cura (opcional)
        audio_play_sound(snd_bebendo, 1, false); 
        audio_sound_pitch(snd_bebendo, 1.5);
    }
}
