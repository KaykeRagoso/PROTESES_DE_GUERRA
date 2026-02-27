if (!dialogo_ativo) exit;

// Avança ou fecha o diálogo ao apertar Espaço
if (keyboard_check_pressed(ord("F")))
{
    linha_atual++;

    if (linha_atual >= array_length(linhas))
    {
        // Diálogo terminou
        dialogo_ativo = false;
        linha_atual   = 0;
        linhas        = [];

        // Avisa o NPC que o diálogo terminou
        if (instance_exists(npc_dono))
            with (npc_dono) { _onDialogoFim(); }

        npc_dono = noone;
    }
}
