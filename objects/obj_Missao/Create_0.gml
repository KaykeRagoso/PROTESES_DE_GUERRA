// obj_missao — Create Event
// Objeto separado que controla o estado de uma missão
// Coloque este objeto na room e configure as variáveis abaixo

missao_nome     = "Missão";       // nome da missão
missao_ativa    = false;          // foi ativada pelo NPC?
missao_completa = false;          // todos os objetivos foram cumpridos?
recompensa_entregue = false;      // recompensa já foi dada?


// Matar inimigos
objetivo_matar          = true;   // usa esse objetivo?
inimigos_necessarios    = 5;      // quantos inimigos matar
inimigos_mortos         = 0;      // contador (incrementado externamente)

// Falar com outro NPC
objetivo_falar_npc      = false;  // usa esse objetivo?
npc_alvo_id             = noone;  // instância do NPC alvo
npc_alvo_falado         = false;  // player já falou com ele?


recompensa_moeda = 0;             // quantidade de moedas
recompensa_vida  = 0;             // vida recuperada
recompensa_item  = noone;         // objeto a criar (ex: obj_PotionLife)


/// Ativa a missão
function _ativarMissao()
{
    missao_ativa    = true;
    missao_completa = false;
    inimigos_mortos = 0;
    npc_alvo_falado = false;
    show_debug_message("Missão iniciada: " + missao_nome);
}

/// Verifica se todos os objetivos foram cumpridos
function _verificarObjetivos()
{
    if (!missao_ativa || missao_completa) exit;

    var _ok = true;

    if (objetivo_matar && inimigos_mortos < inimigos_necessarios)
        _ok = false;

    if (objetivo_falar_npc && !npc_alvo_falado)
        _ok = false;

    if (_ok)
    {
        missao_completa = true;
        show_debug_message("Missão completa: " + missao_nome);
    }
}

/// Entrega a recompensa ao player
function _entregarRecompensa()
{
    if (recompensa_entregue) exit;

    recompensa_entregue = true;

    if (instance_exists(obj_Player))
    {
        // Moedas
        if (recompensa_moeda > 0)
            global.moeda += recompensa_moeda;

        // Vida
        if (recompensa_vida > 0)
        {
            global.vida_atual = min(global.vida_atual + recompensa_vida, global.vida_max);
            obj_Player.hp     = global.vida_atual;
        }

        // Item
        if (recompensa_item != noone)
            instance_create_layer(obj_Player.x, obj_Player.y, "Instances", recompensa_item);
    }

    show_debug_message("Recompensa entregue: " + missao_nome);
}
