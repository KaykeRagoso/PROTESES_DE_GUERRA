// fundo preto
draw_set_color(c_black);
draw_rectangle(0, 0, room_width, room_height, false);

// desenha logo centralizada
draw_set_alpha(1);
draw_sprite_ext(
    logo_sprite,
    0,
    room_width / 2,
    room_height / 2,
    1,
    1,
    0,
    c_white,
    1
);

// overlay de fade
draw_set_alpha(alpha);
draw_rectangle(0, 0, room_width, room_height, false);

// reset
draw_set_alpha(1);
