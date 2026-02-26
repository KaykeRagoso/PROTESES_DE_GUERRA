x += lengthdir_x(spd, dir);
y += lengthdir_y(spd, dir);

// destruir se bater em parede
if place_meeting(x, y, obj_Block)
{
    instance_destroy();
}

// acertar player
if place_meeting(x, y, obj_Player)
{
    with(obj_Player)
    {
        hpPlayer -= other.damage;
    }
    
    instance_destroy();
}