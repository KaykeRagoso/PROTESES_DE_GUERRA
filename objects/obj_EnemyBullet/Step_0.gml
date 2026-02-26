// Conta down do spawn
if (spawn_timer > 0) {
    spawn_timer--;
    exit;
}

// Colisão com o player
if (place_meeting(x, y, obj_Player)) {
    var _knockback_dir = (direction > 90 && direction < 270) ? 1 : -1;
    var _dmg = damage;
    with (obj_Player) {
        takeDamage(_dmg, _knockback_dir);
    }
    instance_destroy();
    exit;
}

// Colisão com bloco
if (place_meeting(x, y, obj_Block)) {
    instance_destroy();
    exit;
}