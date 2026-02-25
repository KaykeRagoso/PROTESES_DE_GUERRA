// Movimento
x += lengthdir_x(spd, dir);
y += lengthdir_y(spd, dir);

// Colisão com inimigo
var hit = instance_place(x, y, hit_enemy);
if (hit != noone) {
    with(hit) { hpEnemy -= other.damage; } // aplica dano
    instance_destroy();
}

// Destroi depois de "lifetime" passos
lifetime--;
if (lifetime <= 0) instance_destroy();