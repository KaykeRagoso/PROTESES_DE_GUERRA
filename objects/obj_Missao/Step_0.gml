if (!missao_ativa || missao_completa) exit;

// Verifica objetivos a cada frame
_verificarObjetivos();

// Checa se o NPC alvo foi falado (caso objetivo_falar_npc esteja ativo)
if (objetivo_falar_npc && instance_exists(npc_alvo_id))
{
    if (npc_alvo_id.ja_falou)
        npc_alvo_falado = true;
}
