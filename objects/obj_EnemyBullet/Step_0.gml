// Colisão com o player
if (place_meeting(x, y, obj_Player)) {
    var _dir = (direction > 90 && direction < 270) ? 1 : -1;
    with (obj_Player) {
        takeDamage(other.damage, _dir);
    }
    instance_destroy();
    exit;
}

// Colisão com bloco
if (place_meeting(x, y, obj_Block)) {
    instance_destroy();
    exit;
}