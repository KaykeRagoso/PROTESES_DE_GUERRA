// Opções
menu_options = ["INICIAR SINCRONIZAÇÃO", "ÁREA DE TREINAMENTO", "CONFIGURAÇÕES", "ABANDONAR"];
index = 0;

alpha = 0;
menu_x_offset = -100; //começa um pouco para a esquerda para deslizar
gui_w = display_get_gui_width();
gui_h = display_get_gui_height();

//controladores da animação individual dos botões
for (var i = 0; i < array_length(menu_options); i++) {
    button_x[i] = 0;      
    button_glow[i] = 0;   
}




input_modo = "teclado"; //começa no teclado por padrão
mouse_last_x = mouse_x;
mouse_last_y = mouse_y;