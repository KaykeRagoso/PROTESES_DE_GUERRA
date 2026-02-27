// Navegação
if (keyboard_check_pressed(vk_up)) selecionado--;
if (keyboard_check_pressed(vk_down)) selecionado++;
selecionado = clamp(selecionado, 0, array_length(opcoes) - 1);

// Lógica do Botão Trocar
if (keyboard_check_pressed(vk_enter)) {
    var _c = custos[selecionado];
    
    // Verifica se tem todos os materiais
    if (global.sucata_tech >= _c[0] && global.chips_dados >= _c[1] && global.nucleos_energia >= _c[2]) {
        // Paga o custo
        global.sucata_tech -= _c[0];
        global.chips_dados -= _c[1];
        global.nucleos_energia -= _c[2];
        
        // Entrega o benefício
        if (selecionado == 0) global.vida_player += 50;
        if (selecionado == 1) global.max_inventario += 5;
        if (selecionado == 2) global.dano_player += 2;
        
        // Efeito sonoro de sucesso aqui
    }
}