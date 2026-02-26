draw_self();

if (mostrar_alerta > 0) {
    draw_sprite(spr_alerta, 0, x, y - 50);
    mostrar_alerta--;
}