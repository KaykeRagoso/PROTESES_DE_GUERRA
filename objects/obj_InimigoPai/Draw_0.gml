draw_self(); // Desenha o inimigo

if (mostrar_alerta > 0) {
    draw_sprite(spr_alerta, 0, x, y - 50);
    mostrar_alerta--; // Diminui o tempo até sumir
}