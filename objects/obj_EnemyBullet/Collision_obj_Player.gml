if (other.invencivel == false)
{
    var dir = point_direction(x, y, other.x, other.y);

    other.takeDamagePlayer(1, dir);
}

instance_destroy();