
npc_nome       = "NPC";           // nome exibido na caixa de diálogo
npc_falando    = false;           // está em diálogo agora?
ja_falou       = false;           // já completou o diálogo ao menos uma vez?

npc_linhas_inicio = ["Olá! Fale comigo para começar uma missão."];
npc_linhas_missao = ["Ainda não terminou a missão..."];
npc_linhas_fim    = ["Obrigado pela ajuda!"];

// ID da missão associada a este NPC (noone = sem missão)
missao_id = noone;

// Referência ao obj_dialogo global
dialogo_ref = noone;

/// Inicia o diálogo com este NPC
function _iniciarDialogo()
{
    if (!instance_exists(obj_Dialogo)) exit;
    if (obj_Dialogo.dialogo_ativo)     exit;
	if (instance_exists(obj_Player))   obj_Player.state = PlayerState.CUTSCENE;

    npc_falando = true;

    // Escolhe as linhas certas dependendo do estado da missão
    var _linhas = npc_linhas_inicio;

    if (instance_exists(missao_id))
    {
        var _missao = missao_id;
        if (_missao.missao_completa)
            _linhas = npc_linhas_fim;
        else if (_missao.missao_ativa)
            _linhas = npc_linhas_missao;
    }

    with (obj_Dialogo)
    {
        linhas        = _linhas;
        linha_atual   = 0;
        npc_dono      = other.id;
        dialogo_ativo = true;
    }
}

/// Chamado pelo obj_dialogo quando o diálogo termina
function _onDialogoFim()
{
    npc_falando = false;
    ja_falou    = true;

    // Libera o player
    if (instance_exists(obj_Player))
        obj_Player.state = PlayerState.IDLE;

    // Ativa a missão ao fim do diálogo inicial
    if (instance_exists(missao_id) && !missao_id.missao_ativa && !missao_id.missao_completa)
        with (missao_id) { _ativarMissao(); }

    // Entrega recompensa se a missão foi completada
    if (instance_exists(missao_id) && missao_id.missao_completa && !missao_id.recompensa_entregue)
        with (missao_id) { _entregarRecompensa(); }
}