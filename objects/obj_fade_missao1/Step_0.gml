if (indo_para_preto) {
    // Fase 1: Escurecendo
    fade_alpha += fade_velocidade;
    
    // Quando ficar tudo escuro, muda a direção
    if (fade_alpha >= 1) {
        fade_alpha = 1;
		global.fade_missao1 = true
        indo_para_preto = false;
        
        // DICA: Se quiser mudar de sala exatamente no escuro, coloque aqui:
        // room_goto(proxima_fase);
    }
} else {
    // Fase 2: Clareando
    fade_alpha -= fade_velocidade;
	global.fade_missao1 = false
    
    // Quando clarear tudo, o objeto se destrói para não pesar no jogo
    if (fade_alpha <= 0) {
        instance_destroy();
    }
}

if instance_place(x,y,obj_Player){
	instance_create_layer(0, 0, "Instances", obj_fade_missao1);
}