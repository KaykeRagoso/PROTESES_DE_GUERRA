// subindo escada
if (mostrar_interacao = 1) {
    draw_set_alpha(1);
    draw_set_color(c_white);
    draw_set_font(ft_gui);

    var margem = 16;
    var texto = "Encontre e Resgate a filha do Camponês ";

    var tx = display_get_gui_width() - string_width(texto) - margem;
    var ty =  28;

    draw_text(tx, ty, texto);

    draw_set_alpha(1);
}
