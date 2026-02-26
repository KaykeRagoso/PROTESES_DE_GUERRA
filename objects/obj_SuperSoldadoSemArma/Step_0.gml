event_inherited();

if (state == EnemyState.ATTACK)
{

    if (point_distance(x,y,obj_Player.x,obj_Player.y) < 40)
    {

        if (!ataque)
        {

            with(obj_Player)
            {
                hp -= 1;
            }

            ataque = true;
            ataque_cool = 0;

        }

    }

}