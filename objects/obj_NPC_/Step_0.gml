// Inicia diálogo ao encostar no player
if (!npc_falando && !ja_falou && instance_exists(obj_Player))
{
    if (place_meeting(x, y, obj_Player) && obj_Player.state != PlayerState.DEATH)
    {
        _iniciarDialogo();
    }
}